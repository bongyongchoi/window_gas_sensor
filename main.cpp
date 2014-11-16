#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QtQml/qqml.h>
#include "SerialControl.h"
int main(int argc, char *argv[])
{

    qmlRegisterType<SerialControl>("SerialControl", 1, 0, "SerialControl");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
