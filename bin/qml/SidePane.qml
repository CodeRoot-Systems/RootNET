import QtQuick 2.0
import "../auth/qml/"
// Module pyotherside to interface with Python3 Backend API.
import io.thp.pyotherside 1.5

Item {
    id: root

    // Inherited properties
    // system properties
    property string user: ''
    property string mode: '' // Modes === Online/Offline/Inactive
    property string host: '' // socket.hostname
    property string os: ''
    property string base: '' // ['linux|linux2','win32','darwin']
    property string kernel: ''
    property string architecture: ''
    property string processor: ''
    // daemon properties
    property string nodeID: '' // subprocess.run(['ipfs id'])...
    property string publicKey: ''
    property string root: ''
    property string state: '' // 'on|off'
    // session properties
    signal expand()
    signal expired()

    function modSwitch(){
        if(root.mode === 'Inactive'){
            pane.state = pane.states==='Inactive'?'':'Inactive'
            xcontainer.state = xcontainer.states==='Inactive'?'':'Inactive'
            xcontainer.height = auth.height
        }
        else if(root.mode === 'Offline'){
            pane.state = pane.states==='Offline'?'':'Offline'
            xcontainer.state = xcontainer.states==='Offline'?'':'Offline'
            xcontainer.height = auth.height
        }
        else if(root.mode === 'Online'){
            pane.state = pane.states==='Online'?'':'Online'
            xcontainer.state = xcontainer.states==='Online'?'':'Online'
            xcontainer.height = systemDetails.height
        }
    }

    function normalize(){
        pane.state = pane.states==='Online'?'':'Online'
    }
    function invert(){
        pane.state = pane.states==='Inverted'?'':'Inverted'
    }

    onModeChanged: {
        sessActivate.start()
        modSwitch()
    }


    Rectangle {
        id: pane
        anchors.fill: parent
        color: "#202020"
        //border.color: '#2E2E2E'
        // --------- Details ---------
        // Daemon
        Details {
            id: daemonDetails
            anchors {
                top: parent.top
                topMargin: 50
                left: parent.left
                leftMargin: 10
                right: parent.right
            }

            modelData: [
                {title: 'Node ID:', value: root.nodeID},
            ]
        }

        Separator {
            id: separator1
            anchors {
                top: daemonDetails.bottom
                topMargin: 20
                left: daemonDetails.left
                right: parent.right
                rightMargin: 5
            }
        }

        Rectangle {
            id: xcontainer
            color: parent.color
            anchors {
                top: separator1.bottom
                topMargin: 10
                left: parent.left
                leftMargin: 10
                right: parent.right
            }

            states: [
                State {
                    name: "Inactive"
                    PropertyChanges {
                        target: systemDetails
                        opacity: 0.0
                    }
                    PropertyChanges {
                        target: auth
                        opacity: 1.0
                        height: 140
                    }
                },
                State {
                    name: "Offline"
                    PropertyChanges {
                        target: systemDetails
                        opacity: 0.0
                    }
                    PropertyChanges {
                        target: auth
                        opacity: 1.0
                        height: 65
                    }
                },
                State {
                    name: "Online"
                    PropertyChanges {
                        target: auth
                        opacity: 0.0
                        height: 0
                    }
                    PropertyChanges {
                        target: systemDetails
                        height: 90
                        opacity: 1.0
                    }
                }
            ]

            Details {
                id: systemDetails
                opacity: 0.0
                Timer {
                    id: sessActivate
                    interval: 5000
                    running: Qt.application.active && visible == true
                    triggeredOnStart: false
                    onTriggered: {
                        if(root.mode === 'Online'){
                            expired()
                        }
                    }
                }

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                modelData: [
                    {title: 'Host:', value: root.host},
                    {title: 'OS:', value: root.os},
                    {title: 'Base:', value: root.base},
                    {title: 'Kernel:', value: root.kernel},
                    {title: 'Type:', value: root.architecture},
                    {title: 'Processor:', value: root.processor}
                ]
            }

            Auth {
                id: auth
                color: parent.color
                anchors {
                    top: parent.top
                    topMargin: 15
                    left: parent.left
                    right: parent.right
                    rightMargin: 25
                }

                mode: root.mode
                user: root.user
                nodeID: root.nodeID
                publicKey: root.publicKey

                onModeChanged: {
                    root.mode = mode
                    root.modSwitch()
                }
            }
        }

        Separator {
            id: separator2
            opacity: 0.0
            anchors {
                top: xcontainer.bottom
                topMargin: 10
                left: xcontainer.left
                right: parent.right
                rightMargin: 5
            }
        }

        states: [
            State {
                name: "Inactive"
                PropertyChanges {
                    target: tooltip
                    width: 0
                }
            },
            State {
                name: "Offline"
                PropertyChanges {
                    target: tooltip
                    width: 0
                }
            },
            State {
                name: "Online"
                PropertyChanges {
                    target: tooltip
                    width: 35
                }
                PropertyChanges {
                    target: separator2
                    opacity: 1.0
                }
            },
            State {
                name: "Inverted"
                PropertyChanges {
                    target: tooltip
                    anchors {
                        rightMargin: -34
                    }
                    width: 35
                    rotation: 180
                }
                PropertyChanges {
                    target: separator2
                    opacity: 1.0
                }
            }
        ]

        transitions: [
            Transition {
                from: "*"; to: "Inverted"
                NumberAnimation {properties: 'anchors'; easing.type: Easing.InOutQuad; duration: 800}
            }
        ]

        Image {
            id: tooltip
            clip: true
            width: 0
            source: '../auth/thumbs/toolTip.png'
            height: 25
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                right: parent.right
            }

            Rectangle {
                id: bars
                width: 20
                color: 'Transparent'
                clip: true
                anchors {
                    right: parent.right
                    rightMargin: 5
                    top: parent.top
                    topMargin: 7
                    bottom: parent.bottom
                    bottomMargin: 5
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        sessActivate.stop()
                        expand()
                    }
                }

                Column {
                    spacing: 3
                    clip: true
                    anchors.fill: parent

                    Repeater {
                        model: 3
                        delegate: Rectangle  {
                            color: 'White'
                            height: 2
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                        }
                    }
                }
            }
        }

        /*Platform {
            id: platform
            color: parent.color
            height: parent.height*1/4
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 10
            }
        }*/
    }
}
