import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: root
    width: 468
    height: 580

    Rectangle {
        id: pg_Archives
        // Search tool goes here.
        Rectangle {
            id: searchTool
            color: "black"
            width: 50
            anchors {
                top: parent.top
                topMargin: 30
                right: parent.right
            }

        }

        Rectangle {
            id: caption
            height: 30
            width: 120
            clip: true
            color: "lightgray"
            anchors {
                top: searchTool.bottom
                left: parent.left
                leftMargin: 30
            }
            smooth: true
            // Label
            Text {
                id: archvLbl
                text: qsTr("Archived Files")
                font {
                    family: "Arial"
                    pixelSize: 13
                }
                anchors {
                    left: parent.left
                    leftMargin: 3
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Table View here..
        Rectangle {
            id: tblContainer
            color: "black"
            //height: (3/4 * parent.height) - (5/8*(1/4*parent.height))
            height: 320
            clip: true
            anchors {
                top: caption.bottom
                left: parent.left
                leftMargin: 30
                right: parent.right
                rightMargin: 30
            }

            TableView {
                id: archivedFiles
                opacity: 1.0


            }
        }




    }
}
