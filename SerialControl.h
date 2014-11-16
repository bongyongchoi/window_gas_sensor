#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QTimer>

class SerialControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int mc READ mc WRITE setMc NOTIFY mcChanged)
    Q_PROPERTY(int lk READ lk WRITE setLk NOTIFY lkChanged)

public:
    struct Settings {
        QString name;
        qint32 baudRate;
        QString stringBaudRate;
        QSerialPort::DataBits dataBits;
        QString stringDataBits;
        QSerialPort::Parity parity;
        QString stringParity;
        QSerialPort::StopBits stopBits;
        QString stringStopBits;
        QSerialPort::FlowControl flowControl;
        QString stringFlowControl;
        bool localEchoEnabled;
    };

    int mc() const;
    void setMc(const int &mc);

    int lk() const;
    void setLk(const int &lk);

    explicit SerialControl(QObject *parent = 0);
    void calChannelByte(int mcChannel, int lkChannel);
    void calChannel(QStringList temp);
    Q_INVOKABLE int hello() const;
    Q_INVOKABLE void getSetting(QString port, int baudrate, int databit,
                                int parity, int stopbit, int flowcontrol, QString hexVal6);
    Q_INVOKABLE void getSetting(QString port, int baudrate, int databit,
                                int parity, int stopbit, int flowcontrol, int mcChanel, int lkChannel);

signals:
    void sendQmlSerial(const QString &data);
    void errorOccur();
    void mcChanged(const int &mc);
    void lkChanged(const int &lk);

public slots:
    void closeSerial();
    void openSerial();
    void sendData();
    void qmlTimerData();

private:
    int count;
    Settings p;
    QSerialPort *serial;
    QTimer *timer;
    QByteArray sendArray;
    int mMc;
    int mLk;

};

#endif // TEST_H
