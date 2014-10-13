#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QTimer>

class Test : public QObject
{
    Q_OBJECT
public:
    int count;
    QSerialPort *serial;
    QTimer *timer;
    explicit Test(QObject *parent = 0);
    Q_INVOKABLE int hello() const;
signals:
    void sendQmlSerial(const QString &hi);
    void errorOccur();

public slots:
    void openSerial();
    void sendData();
    void qmlTimerData();


};

#endif // TEST_H
