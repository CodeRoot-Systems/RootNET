import QtQuick 2.0

// MenuConrols
import "../Controls/"

Item {
    id: root
    clip: true
    property string activeX: ''


    Rectangle {
        id: pane
        color: "#2E2E2E"
        opacity: 1.0
        anchors.fill: parent

        // creating MenuConrols
        // MenuConrol 1: File Hub

        Rectangle {
            id: ctrlContainer
            color: parent.color
            height: fileHUB.height+connections.height+pages.height+jobs.height
            y: (parent.height-platform.height)/2 - (ctrlContainer.height)/2
            anchors {
                left: parent.left
                right: parent.right
            }

            MenuControl {
                id: fileHUB
                label: "File Hub"
                thumbSource: "../thumbs/appbar.cabinet.files.variant.png"
                subControls:  ["Archive","Public"]

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {

                        if(fileHUB.state === "Hovered"){
                            fileHUB.state = fileHUB.states==="Pressed"?"":"Pressed"
                            connections.state = ""
                            pages.state = ""
                            jobs.state = ""
                        }
                        else if(containsMouse){
                            fileHUB.state = "Hovered"
                        }
                    }

                    onEntered: {
                        if(fileHUB.state !== "Pressed"){
                            fileHUB.state = "Hovered"
                        }
                    }
                    onExited: {
                        if(fileHUB.state !== "Pressed"){
                            fileHUB.state = ""
                        }
                    }
                }

                onActiveXChanged: {
                    root.activeX = fileHUB.activeX
                }
            }

            MenuControl {
                id: connections
                label: "Connections"
                thumbSource: "../thumbs/appbar.globe.png"
                subControls:  ["Friends","Circles","Communities"]
                anchors {
                    top: fileHUB.bottom
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {

                        if(connections.state === "Hovered"){
                            fileHUB.state = ""
                            connections.state = connections.states==="Pressed"?"":"Pressed"
                            pages.state = ""
                            jobs.state = ""
                        }
                        else if(containsMouse){
                            connections.state = "Hovered"
                        }
                    }

                    onEntered: {
                        if(connections.state !== "Pressed"){
                            connections.state = "Hovered"
                        }
                    }
                    onExited: {
                        if(connections.state !== "Pressed"){
                            connections.state = ""
                        }
                    }
                }

                onActiveXChanged: {
                    root.activeX = connections.activeX
                }
            }

            MenuControl {
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

                    onPressed: {

                        if(pages.state === "Hovered"){
                            fileHUB.state = ""
                            connections.state = ""
                            pages.state = pages.states==="Pressed"?"":"Pressed"
                            jobs.state = ""
                        }
                        else if(containsMouse){
                            pages.state = "Hovered"
                        }
                    }

                    onEntered: {
                        if(pages.state !== "Pressed"){
                            pages.state = "Hovered"
                        }
                    }
                    onExited: {
                        if(pages.state !== "Pressed"){
                            pages.state = ""
                        }
                    }
                }

                onActiveXChanged: {
                    root.activeX = pages.activeX
                }
            }

            MenuControl {
                id: jobs
                label: "Jobs"
                thumbSource: "../thumbs/appbar.suitcase.png"
                subControls:  ["Transporter"]
                anchors {
                    top: pages.bottom
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {

                        if(jobs.state === "Hovered"){
                            fileHUB.state = ""
                            connections.state = ""
                            pages.state = ""
                            jobs.state = jobs.states==="Pressed"?"":"Pressed"
                        }
                        else if(containsMouse){
                            jobs.state = "Hovered"
                        }
                    }

                    onEntered: {
                        if(jobs.state !== "Pressed"){
                            jobs.state = "Hovered"
                        }
                    }
                    onExited: {
                        if(jobs.state !== "Pressed"){
                            jobs.state = ""
                        }
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
