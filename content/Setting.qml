import QtQuick 2.0
import QtQuick.Controls 1.2

Item{
    id: root

    ComboBox{
        model: ["Paris", "Oslo", "New York"]
    }

    function ho(text){
        console.log(text)
    }
}
