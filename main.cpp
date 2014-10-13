#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QtQml/qqml.h>
#include "test.h"
int main(int argc, char *argv[])
{

    qmlRegisterType<Test>("Test", 1, 0, "Test");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
