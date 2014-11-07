import QtQuick 2.0
import QtQuick.Controls 1.2
import Test 1.0

 Item{
    Row{
        spacing: 10
        Rectangle{color: "red"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "blue"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "green"; width: 100; height: 100; radius: width*0.5}
        Rectangle{color: "yellow"; width: 100; height: 100; radius: width*0.5}
    }

    Text{
        id: statusText
        text: "hello"
    }




    ProgressBar{
        id:te
        value: 1
        indeterminate: true
        anchors.bottom: parent.bottom
    }

    Rectangle{
        anchors.bottom: te.bottom
        width: 10
        height: te.height
        color: "red"
        x: te.width/2

    }

    function changeText(text)
    {
        statusText.text = text;
    }
}





