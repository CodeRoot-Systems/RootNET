import QtQuick 2.0

Rectangle {
    id: root

    // Platform name
    Text {
        id: platform
        text: qsTr("RootNET")
        color: "Gray"
        anchors {
            top: parent.top
            topMargin: 30
            left: parent.left
            leftMargin: 35
        }
        font {
            family: "Arial Bold"
            pixelSize: 14
        }
    }


    // Version info
    Text {
        id: version
        text: qsTr("version .alpha")
        color: "Gray"
        anchors {
            top: platform.bottom
            topMargin: 3
            left: parent.left
            leftMargin: 35
        }
        font {
            family: "Arial Bold"
            pixelSize: 12
        }
    }
}


