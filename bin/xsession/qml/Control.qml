import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
//////////////////////////////////////////// +++Properties+++ //////////////////////////////////////////////////
    id: root
    color: "#2E2E2E"
    height: ctrl.height
    smooth: true
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    property string label: ""
    property string thumbSource: ""
    property variant subControls: []
    property string activeX: ""
//////////////////////////////////////////// +++Functions+++ //////////////////////////////////////////////////


//////////////////////////////////////////// +++States + Transitions+++ //////////////////////////////////////////////////
    states: [
        State {
            name: "Hovered"
            PropertyChanges {
                target: ctrl
                color: '#34393B'
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: ctrl
                height: 45 + (30*subControls.length)
                color : "#215D9C"
            }
        }
    ]

    transitions: [
        Transition {
            from: "Hovered"; to: ""
            ColorAnimation {duration: 350}
        },
        Transition {
            NumberAnimation {
                target: ctrl
                property: "height"
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }
    ]

//////////////////////////////////////////// +++Components+++ //////////////////////////////////////////////////
    Rectangle {
        id: ctrl
        color: parent.color
        height: 45; z:100
        clip: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        // Caption
        Rectangle {
            id: caption
            color: parent.color
            height: 45
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Image {
                id: thumbnail
                smooth: true
                source: root.thumbSource
                width: 40
                height: 40
                anchors {
                    left: parent.left
                    leftMargin: 30
                    verticalCenter: parent.verticalCenter
                }
            }

            Text {
                id: lblTxt
                text: qsTr(root.label)
                color: "White"
                smooth: true
                font {
                    family: "Arial"
                    pixelSize: 16
                }

                anchors {
                    left: thumbnail.right
                    leftMargin: 20
                    right: parent.right
                    verticalCenter: thumbnail.verticalCenter
                }
            }
        }

        // Subcontrols
        Rectangle {
            id: dropDown
            color: parent.color
            opacity: 1.0
            //height: 65
            //height: 0
            //clip: true
            smooth: true

            anchors {
                top: caption.bottom
                left: parent.left
                right: parent.right

            }

            Column {
                id: subCModels
                spacing: 2
                anchors.fill: parent

                Repeater {
                    model: root.subControls
                    delegate:

                        Item {
                           id: subControl
                           height: 30
                           width: 50
                           anchors {left: parent.left; leftMargin: 90; right: parent.right}

                           MouseArea {
                               anchors.fill: parent
                               hoverEnabled: true
                               cursorShape: Qt.PointingHandCursor

                               onClicked: {
                                   root.activeX = ''
                                   root.activeX = root.label+'.'+modelData
                               }
                           }

                           Text {
                               text: modelData
                               color: "black"
                               font {
                                   family: "Arial"
                                   pixelSize: 14
                               }

                               anchors {
                                   top: parent.top
                                   right: parent.right
                                   left: parent.left
                               }
                           }
                        }
                    }
                }
            }
        }
    }
