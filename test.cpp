#include "test.h"
#include "QDebug"
Test::Test(QObject *parent) :
    QObject(parent)
{
    count = 0;
    serial = new QSerialPort();
    timer = new QTimer();
}
void Test::getSetting(QString port, int baudrate, int databit,
                            int parity, int stopbit, int flowcontrol ){
    qDebug()<<port<<baudrate<<databit<<parity<<stopbit<<flowcontrol;
    serial->setPortName(port);
    serial->setBaudRate(static_cast<QSerialPort::BaudRate>(baudrate));
    serial->setDataBits(static_cast<QSerialPort::DataBits>(databit));
    serial->setParity(static_cast<QSerialPort::Parity>(parity));
    serial->setStopBits(static_cast<QSerialPort::StopBits>(stopbit));
    serial->setFlowControl(static_cast<QSerialPort::FlowControl>(flowcontrol));
}

int Test::hello() const{
    return 3;

}

void Test::openSerial()
{

    //connect(serial, SIGNAL(readyRead()), this, SLOT(sendData()));
    connect(timer, SIGNAL(timeout()), this, SLOT(qmlTimerData()));
    /*
    serial->setPortName("COM6");
    serial->setBaudRate(QSerialPort::Baud9600);
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    serial->setFlowControl(QSerialPort::NoFlowControl);
    */
      if (serial->open(QIODevice::ReadWrite)) {



          timer->start(300);
       }
      else {
          emit errorOccur();

      }

}

void Test::sendData()
{
    count++;
    QString test = QString(serial->readAll().toHex()) + " " + QString::number(count);
    timer->start();
    emit sendQmlSerial(test);

}

void Test::qmlTimerData()
{
    timer->stop();
    QByteArray cd;
    cd[0]=0x07;
    cd[1]=0x04;
    cd[2]=0x02;
    cd[3]=0x44;
    cd[4]=0x00;
    cd[5]=0x02;
    cd[6]=0x30;
    cd[7]=0x00;
    serial->write(cd, 8);
    QTimer::singleShot(100, this, SLOT(sendData()));
}




