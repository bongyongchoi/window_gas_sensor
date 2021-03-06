import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import SerialControl 1.0
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

    property string hex

    property color color: "#0066cc"


    Timer{
        interval: 1000; running: true; repeat: true
        onTriggered:
        {
            logText.append("hello" + logText.cursorPosition);
        }
    }

    TabWidget {
        id: tabs
        width: 500; height: 500

        //DashBoard
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
                        id: openButton
                        text: "serial open"
                        width: 100
                        onClicked: {
                            secont.openSerial()
                        }
                    }

                    Button{
                        id: closeButton
                        anchors.top: openButton.bottom
                        anchors.topMargin: 20
                        text: "serial close"
                        width: 100
                        onClicked: {
                            secont.closeSerial();
                        }
                    }
                    GroupBox{

                        anchors.top: closeButton.bottom
                        anchors.topMargin: 20
                        width: parent.width
                        RowLayout{


                            anchors.fill: parent

                             Rectangle{color: "red"; width: 100; height: 100; radius: width*0.5}
                             Rectangle{color: "blue"; width: 100; height: 100; radius: width*0.5}
                             Rectangle{color: "green"; width: 100; height: 100; radius: width*0.5}
                            Rectangle{color: "yellow"; width: 100; height: 100;radius: width*0.5}

                        }
                    }
                    Turbulence {
                        x: 100
                        y: 200
                    }

                    ProgressBar {
                        y: 300
                        indeterminate: true
                    }



            }
        }

        //Log
        Rectangle {
            property string title: "Log"
            anchors.fill: parent
            color: "#e3e3e3"

            Rectangle {
                anchors.fill: parent;
                //color: "#7fff7f"
                Text {
                    width: parent.width - 20
                    anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
                    text: "Flower stems are green"
                    font.pixelSize: 20
                    wrapMode: Text.WordWrap
                }
                TextArea {
                    id: logText
                    readOnly: true
                    text:
                          "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
                          "sed do eiusmod tempor incididunt ut labore et dolore magna " +
                          "aliqua. Ut enim ad minim veniam, quis nostrud exercitation " +
                          "ullamco laboris nisi ut aliquip ex ea commodo cosnsequat. ";

                }

                Canvas {
                    anchors.top: parent.top
                    id: canvas
                    width: 300
                    height: 300

                    onPaint: {
                        var ctx = canvas.getContext('2d');
                        ctx.fillStyle = "#FF0000";
                        ctx.fillRect(0,0,150,75);
                        ctx.closePath();

                    }

                }



            }
        }

        //Settings
        Rectangle {
            property string title: "Settings"
            anchors.fill: parent; color: "#e3e3e3"
            SplitView{
                anchors.fill: parent
                 orientation: Qt.Horizontal


                 Rectangle {
                     color: "skyblue"
                     width: 200
                     Layout.minimumWidth: 100
                     Layout.maximumWidth: 300
                     ColumnLayout{
                         Button{
                             text: "1"
                             onClicked: {
                                 tab1.visible = false;
                             }
                         }
                         Button{
                             text: "2"
                             onClicked: {
                                 tab1.visible = true;
                             }
                         }
                         Button{
                             text: "3"
                         }
                     }
                 }

                Rectangle {

                    //Layout.fillWidth:  true
                    id: tab1
                    color: "#7f7fff"

                    Grid{
                        id: gridbox
                        anchors.left: parent.left
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
                            Layout.fillWidth: true
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
                            currentIndex: 0
                            model: ListModel {

                                id: flowcontrol
                                ListElement { text: "NONE"; value: 0; }
                                ListElement { text: "RTS/CTS"; value: 1;  }
                                ListElement { text: "XON/XOFF"; value: 2;  }
                            }
                            width: 200
                        }



                }
                ColumnLayout{
                    anchors.topMargin: 100
                    anchors.top: gridbox.bottom
                    CheckBox {
                        id: checked

                    }

                RowLayout{
                    enabled: checked.checked

                    id: hexvalue
                    Repeater {
                        model: 6
                           TextField {

                           }
                    }




                }
                RowLayout {
                             enabled: !checked.checked
                   SpinBox {
                       id: spin1
                   }

                   SpinBox {
                       id: spin2

                   }

                }

                Button{

                    width: 100
                    text: "apply"
                    onClicked: {
                        hex = "";
                        for(var i = 0; i < 6; i ++)
                        {
                             hex  += hexvalue.children[i].text
                            if(i!=5) hex += "#";



                        }

                        console.log(hex);
                        if(checked.checked)
                        {
                            secont.getSetting(port.text, baudrate.get(combo1.currentIndex).value,
                                 databit.get(combo2.currentIndex).value, parity.get(combo3.currentIndex).value,
                                            stopbit.get(combo4.currentIndex).value, flowcontrol.get(combo5.currentIndex).value , spin1.value, spin2.value);
                        }

                        secont.getSetting(port.text, baudrate.get(combo1.currentIndex).value,
                             databit.get(combo2.currentIndex).value, parity.get(combo3.currentIndex).value,
                                        stopbit.get(combo4.currentIndex).value, flowcontrol.get(combo5.currentIndex).value , hex);
                    }
                }
               }











                }


            }
        }

    }





    SerialControl{
        id: secont

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
4
        //test.openSerial()

     }
    onWidthChanged:   {
        tabs.width = win.width
    }
    onHeightChanged: {
        tabs.height = win.height
    }



}












