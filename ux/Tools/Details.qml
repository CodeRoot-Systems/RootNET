import QtQuick 2.0

Item {
    id: root
    property var objData: []
    property color vlColor: 'white'

    ListView {
        id: details
        model: root.objData
        height: 15 * objData.length
        clip: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        delegate: Item {
            id: detail
            height: 15
            anchors {
                right: parent.right
                rightMargin: 5
                left: parent.left
            }

            Component.onCompleted: {
                var ln = modelData.length
            }

            // Label
            Text {
                id: label
                text: qsTr(modelData.title)
                color: 'Gray'
                anchors {
                    left: parent.left
                }
                font {
                    family: 'Arial'
                    pixelSize: 12
                }
            }
            // Detail
            Text {
                id: dtTxt
                text: qsTr(modelData.value)
                elide: Text.ElideRight
                color: root.vlColor
                anchors {
                    left: label.right
                    leftMargin: 3
                    right: parent.right
                }

                font {
                    family: 'Arial'
                    pixelSize: 12
                }
            }
        }
    }
}
