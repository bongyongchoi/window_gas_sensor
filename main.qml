import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import Test 1.0
import "content"
import "hello.js" as Logic
import "ledscreencomponent"
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

Window {
    id: win
    visible: true
    width: 500
    height: 500

    /*
    Timer{
        interval: 1000; running: true; repeat: true
        onTriggered:
        {
            test.qmlTimerData()
        }
    }
    */
    TabWidget {
        id: tabs
        width: 500; height: 500

        Rectangle {
            property string title: "DashBoard"
            anchors.fill: parent
            color: "#e3e3e3"

            Rectangle {
                anchors.fill: parent;
                color: "#ff7f7f"
                Text {
                    id: fi
                    width: parent.width - 20
                    anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
                    text: "Roses are red"
                    font.pixelSize: 20
                    wrapMode: Text.WordWrap
                }

                    Button{


                        text: "serial open"
                        width: 100
                        onClicked: {
                            test.openSerial()
                        }
                    }



            }
        }

        Rectangle {
            property string title: "Log"
            anchors.fill: parent
            color: "#e3e3e3"

            Rectangle {
                anchors.fill: parent;
                color: "#7fff7f"
                Text {
                    width: parent.width - 20
                    anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
                    text: "Flower stems are green"
                    font.pixelSize: 20
                    wrapMode: Text.WordWrap
                }
            }
        }

        Rectangle {
            property string title: "Settings"
            anchors.fill: parent; color: "#e3e3e3"

            Rectangle {
                anchors.fill: parent;
                color: "#7f7fff"
                Text {
                    id: t
                    width: parent.width - 20
                    anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
                    text: "Violets are blue"
                    font.pixelSize: 20
                    wrapMode: Text.WordWrap
                }
                Grid{

                    columns: 2
                    columnSpacing: 20
                    Text {
                        id: b
                        text: qsTr("port")
                    }
                    TextField {id:port; text: "COM1"}

                    Text {
                        text: qsTr("baudrate")
                    }
                    ComboBox {
                        id:combo1
                        currentIndex: 0
                        model: ListModel {
                            id: baudrate
                            ListElement { text: "9600"; value: 9600; }
                            ListElement { text: "19200"; value: 19200; }
                            ListElement { text: "38400"; value: 38400;  }
                        }
                        width: 200
                    }

                    Text {
                        text: qsTr("data bit")
                    }
                    ComboBox {
                        id: combo2
                        currentIndex: 3
                        model: ListModel {
                            id: databit
                            ListElement { text: "5"; value: 5; }
                            ListElement { text: "6"; value: 6;  }
                            ListElement { text: "7"; value: 7;  }
                            ListElement { text: "8"; value: 8;  }
                        }
                        width: 200
                    }

                    Text {
                        text: qsTr("parity")
                    }
                    ComboBox {
                        id: combo3
                        currentIndex: 0
                        model: ListModel {
                            id: parity
                            ListElement { text: "None"; value: 0; }
                            ListElement { text: "Evne"; value: 2;  }
                            ListElement { text: "Odd"; value: 3;  }
                            ListElement { text: "Mark"; value: 4; }
                            ListElement { text: "Space"; value: 5;  }

                        }
                        width: 200
                    }

                    Text {
                        text: qsTr("stop bit")
                    }
                    ComboBox {
                        id: combo4
                        currentIndex: 0
                        model: ListModel {
                            id: stopbit
                            ListElement { text: "1"; value: 1 }
                            ListElement { text: "1.5"; value: 2  }
                            ListElement { text: "2"; value: 3 }
                        }
                        width: 200
                    }

                    Text {
                        text: qsTr("flow control")
                    }
                    ComboBox {
                        id: combo5
                        currentIndex: 2
                        model: ListModel {
                            id: flowcontrol
                            ListElement { text: "NONE"; value: 0; }
                            ListElement { text: "RTS/CTS"; value: 1;  }
                            ListElement { text: "XON/XOFF"; value: 2;  }
                        }
                        width: 200
                    }

            }
                Button{
                    anchors.top: parent.verticalCenter
                    width: 100
                    text: "apply"
                    onClicked: {
                        test.getSetting(port.text, baudrate.get(combo1.currentIndex).value,
                             databit.get(combo2.currentIndex).value, parity.get(combo3.currentIndex).value,
                                        stopbit.get(combo4.currentIndex).value, flowcontrol.get(combo5.currentIndex).value);
                    }
                }



            }
        }
    }


    Test{
        id:test

        onErrorOccur:
        {
            fi.text = "not open"
        }

        onSendQmlSerial:
        {
            fi.text = data
        }
    }

    Component.onCompleted: {

        //test.openSerial()

     }
    onWidthChanged:   {
        tabs.width = win.width
    }
    onHeightChanged: {
        tabs.height = win.height
    }



}












