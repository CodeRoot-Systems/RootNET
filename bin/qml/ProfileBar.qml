import QtQuick 2.0

Rectangle {
    id: root
    color: "#1A1A1A"

    property string user: ""
    property string host: ""
    property string avatarSrc: ""

    Rectangle {
        id: avatarContainer
        color: "white"
        width: 75; height: 75; radius: width * 0.5
        clip: true
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }

        Image {
            id: avatar
            source: root.avatarSrc
            anchors {
                fill: parent
            }
        }
    }

    Rectangle {
        id: captions
        anchors {
            left: avatarContainer.right
            leftMargin: 15
            right: parent.right
            top: parent.top
            topMargin: 35
        }

        Text {
            id: usrName
            text: qsTr(root.user)
            color: "white"
            font {
                family:"Arial Bold"
                pixelSize: 18
            }
        }

        Text {
            id: hashID
            text: qsTr(root.user+'@'+root.host) //<domain-name>
            color: "white"
            font {
                family: "Arial Bold"
                pixelSize: 14
            }

            anchors {
                top: usrName.bottom
                topMargin: 3
            }
        }
    }
}
