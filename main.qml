import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import Test 1.0
import "content"
import "hello.js" as Logic
import "ledscreencomponent"
import QtGraphicalEffects 1.0


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
                        id: name
                        text: qsTr("paraty")
                    }
                    ComboBox{
                        id: combo
                        width: 100
                        model: ["Paris", "Oslo", "New York"]
                        onCurrentIndexChanged:   {
                            if(combo.currentText!="")
                            {
                            console.log(combo.currentText)
                            t.text = combo.currentText
                            }
                        }
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
        test.openSerial()

     }
    onWidthChanged:   {
        tabs.width = win.width
    }
    onHeightChanged: {
        tabs.height = win.height
    }



}












