TEMPLATE = app

QT += qml quick serialport

SOURCES += main.cpp \
    SerialControl.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    SerialControl.h

OTHER_FILES +=
