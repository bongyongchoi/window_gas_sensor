#include "SerialControl.h"
#include "QDebug"
SerialControl::SerialControl(QObject *parent) :
    QObject(parent)
{
    count = 0;
    serial = new QSerialPort();
    timer = new QTimer();
}
void SerialControl::getSetting(QString port, int baudrate, int databit,
                            int parity, int stopbit, int flowcontrol, QString hexVal6 )
{
    qDebug()<<port<<baudrate<<databit<<parity<<stopbit<<flowcontrol;
    p.name = port;
    p.baudRate = static_cast<QSerialPort::BaudRate>(baudrate);
    p.dataBits = static_cast<QSerialPort::DataBits>(databit);
    p.parity = static_cast<QSerialPort::Parity>(parity);
    p.stopBits = static_cast<QSerialPort::StopBits>(stopbit);
    p.flowControl =static_cast<QSerialPort::FlowControl>(flowcontrol);

    /*
    serial->setPortName(port);
    serial->setBaudRate(static_cast<QSerialPort::BaudRate>(baudrate));
    serial->setDataBits(static_cast<QSerialPort::DataBits>(databit));
    serial->setParity(static_cast<QSerialPort::Parity>(parity));
    serial->setStopBits(static_cast<QSerialPort::StopBits>(stopbit));
    serial->setFlowControl(static_cast<QSerialPort::FlowControl>(flowcontrol));
    */

    QStringList strlist = hexVal6.split("#");
    int i=0;
    calChannel(strlist);

    for(QString temp : strlist)
    {
        sendArray[i++] = temp.toInt(0, 16);
    }

}

void SerialControl::getSetting(QString port, int baudrate, int databit,
                            int parity, int stopbit, int flowcontrol, int mcChannel, int lkChannel)
{
    qDebug()<<port<<baudrate<<databit<<parity<<stopbit<<flowcontrol;
    p.name = port;
    p.baudRate = static_cast<QSerialPort::BaudRate>(baudrate);
    p.dataBits = static_cast<QSerialPort::DataBits>(databit);
    p.parity = static_cast<QSerialPort::Parity>(parity);
    p.stopBits = static_cast<QSerialPort::StopBits>(stopbit);
    p.flowControl =static_cast<QSerialPort::FlowControl>(flowcontrol);

}

int SerialControl::hello() const
{
    return 3;

}

void SerialControl::openSerial()
{
    closeSerial();
    //connect(serial, SIGNAL(readyRead()), this, SLOT(sendData()));

    /*
    serial->setPortName("COM6");
    serial->setBaudRate(QSerialPort::Baud9600);
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    serial->setFlowControl(QSerialPort::NoFlowControl);
    */
      if (serial->open(QIODevice::ReadWrite)) {
          if (serial->setBaudRate(p.baudRate)
                  && serial->setDataBits(p.dataBits)
                  && serial->setParity(p.parity)
                  && serial->setStopBits(p.stopBits)
                  && serial->setFlowControl(p.flowControl)) {
             connect(timer, SIGNAL(timeout()), this, SLOT(qmlTimerData()));
             timer->start(300);
        } else {
           closeSerial();
          emit errorOccur();
      }
    } else {
             emit errorOccur();;
      }

}

void SerialControl::sendData()
{
    count++;
    QString test = QString(serial->readAll().toHex()) + " " + QString::number(count);

    timer->start();
    emit sendQmlSerial(test);

}

void SerialControl::qmlTimerData()
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
    serial->write(sendArray, 8);
    QTimer::singleShot(100, this, SLOT(sendData()));
}

void SerialControl::closeSerial()
{
    disconnect(timer, SIGNAL(timeout()), this, SLOT(qmlTimerData()));
    timer->stop();
    serial->close();
}

void SerialControl::calChannelByte(int mcChannel, int lkChannel)
{
    setLk(lkChannel);
    setMc(mcChannel);

    int x = 0x74;
    int y = 0x00;
   int j = 0;
   if(lkChannel >= 10)
   {
       j = (lkChannel-10)/16;
       for(int k = 0; k <= j; k++)
       {
           y += 0x01;
       }
   }
   for(int i = 1; i < lkChannel; i++)
   {
       x += 0x10;
   }
   sendArray[0] = mcChannel;
   sendArray[1] = 0x04;
   sendArray[2] =  y;
   sendArray[3] =  x;
   sendArray[4] = 0x00;
   sendArray[5] = 0x02;
}

int SerialControl::mc() const
{
    return mMc;
}

void SerialControl::setMc(const int &mc)
{
    if(mc != mMc) {
        mMc = mc;
        emit mcChanged(mMc);
    }
}

int SerialControl::lk() const
{
    return mLk;
}

void SerialControl::setLk(const int &lk)
{
    if(lk != mLk) {
        mLk = lk;
        emit lkChanged(mLk);
    }
}

void SerialControl::calChannel(QStringList temp)
{
    int ch = 0;
    int a = temp[2].toInt(0, 16);
    int b = temp[3].toInt(0, 16);
    int i = 0x74;
    if(a==0x00)
    {
        while(i<=b)
        {
            ++ch;
            i+=0x10;
        }
    }
    else
    {
        ch=10;
        i=0x04;
        int j=0x01;
        while(j<a)
        {
            ch+=16;
            j+=0x01;
        }
        while(i<b)
        {
            ++ch;
            i+=0x10;
        }
    }
    setMc(temp[0].toInt(0, 16));
    setLk(ch);

}

