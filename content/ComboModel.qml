import QtQuick 2.0

Item {

    ListModel {
        id: baudrate
        ListElement { text: "9600"; value: 9600; }
        ListElement { text: "19200"; value: 19200; }
        ListElement { text: "38400"; value: 38400;  }
    }

    ListModel {
        ListElement { text: "5"; value: 5; }
        ListElement { text: "6"; value: 6;  }
        ListElement { text: "7"; value: 7;  }
        ListElement { text: "8"; value: 8;  }
    }

    ListModel {
        ListElement { text: "None"; value: 0; }
        ListElement { text: "Evne"; value: 2;  }
        ListElement { text: "Odd"; value: 3;  }
        ListElement { text: "Mark"; value: 4; }
        ListElement { text: "Space"; value: 5;  }
    }

    ListModel {
        ListElement { text: "1"; value: 1 }
        ListElement { text: "1.5"; value: 2  }
        ListElement { text: "2"; value: 3 }
    }

    ListModel {
        ListElement { text: "NONE"; value: 0; }
        ListElement { text: "RTS/CTS"; value: 1;  }
        ListElement { text: "XON/XOFF"; value: 2;  }
    }
}

