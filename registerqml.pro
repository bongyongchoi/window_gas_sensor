TEMPLATE = app

QT += qml quick serialport

SOURCES += main.cpp \
    test.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    test.h

OTHER_FILES +=
