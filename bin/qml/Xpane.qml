import QtQuick 2.0

// Controls
import "../xsession/qml/"

Item {
    id: root
    clip: true
    property string activeX: ''


    Rectangle {
        id: pane
        color: "#2E2E2E"
        opacity: 1.0
        anchors.fill: parent

        // creating Controls
        // Control 1: File Hub

        Rectangle {
            id: ctrlContainer
            color: parent.color
            height: fileHUB.height+connections.height+pages.height+jobs.height
            y: (parent.height-platform.height)/2 - (ctrlContainer.height)/2
            anchors {
                left: parent.left
                right: parent.right
            }

            Control {
                id: fileHUB
                label: "File Hub"
                thumbSource: "../thumbs/appbar.cabinet.files.variant.png"
                subControls: ["Archive","Public"]

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        fileHUB.state = fileHUB.state==="Expanded"?"":"Expanded"
                        connections.state = ""
                        pages.state = ""
                        jobs.state = ""
                    }
                }

                onActiveXChanged: {
                    root.activeX = fileHUB.activeX
                }
            }

            Control {
                id: connections
                label: "Connections"
                thumbSource: "../thumbs/appbar.globe.png"
                subControls: ["Friends","Circles","Communities"]
                anchors {
                    top: fileHUB.bottom
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        connections.state = connections.state==="Expanded"?"":"Expanded"
                        fileHUB.state = ""
                        pages.state = ""
                        jobs.state = ""
                    }
                }

                onActiveXChanged: {
                    root.activeX = connections.activeX
                }
            }

            Control {
                id: pages
                label: "Pages"
                thumbSource: "../thumbs/appbar.pages.png"
                subControls: ["Business", "Assets"]
                anchors {
                    top: connections.bottom
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        pages.state = pages.state==="Expanded"?"":"Expanded"
                        fileHUB.state = ""
                        connections.state = ""
                        jobs.state = ""
                    }
                }

                onActiveXChanged: {
                    root.activeX = pages.activeX
                }
            }

            Control {
                id: jobs
                label: "Jobs"
                thumbSource: "../thumbs/appbar.suitcase.png"
                subControls: ["Transporter"]
                anchors {
                    top: pages.bottom
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        jobs.state = jobs.state==="Expanded"?"":"Expanded"
                        fileHUB.state = ""
                        connections.state = ""
                        pages.state = ""
                    }
                }

                onActiveXChanged: {
                    root.activeX = jobs.activeX
                }
            }


        }

        ///////////////////////////////////+++++Platform Panel+++++/////////////////////////////////
        Platform {
            id: platform
            color: parent.color
            height: parent.height*1/4
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 10
            }
        }
    }

}
