import QtQuick 2.0

Item {
    id: root
    clip: true
    property string caption: ''
    Text {
        id: caption
        text: qsTr(root.caption)
        anchors.fill: parent
        color: 'Gray'
        wrapMode: Text.WordWrap
        font {
            family: 'Arial'
            pixelSize: 12
            italic: true
        }

    }
}
