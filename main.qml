import QtQuick 2.2
import QtQuick.Window 2.1
import Test 1.0
import "hello.js" as Logic
import "ledscreencomponent"


Window {
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
    Row{
        anchors.top: {parent.topMa + 50}
        spacing: 10
        Rectangle{color: "red"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "blue"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "green"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "yellow"; width: 100; height: 100; radius: width*0.5}


    }


    Test{
        id:test

        onErrorOccur:
        {
            statusText.text = "serial open fail"
        }

        onSendQmlSerial:
        {
            statusText.text = hi
        }
    }


    Text {
        id: statusText
        text: {Logic.func()}
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
          statusText.text = test.hello()
        }
    }

    Component.onCompleted: {
        test.openSerial()
    }




}
