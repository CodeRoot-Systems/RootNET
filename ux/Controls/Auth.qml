import QtQuick 2.0
import QtQuick.Controls 2.3
import "../Tools/"

Rectangle {
    id: root
    clip: true
    property string mode: '' // modes === Inactive/Offline/Online
    property string action: ''
    property string user: ''
    property string nodeID: ''
    property string publicKey: ''

    onModeChanged: {

        if (root.mode === 'Inactive'){
            root.action = 'Activate'
            root.state = root.states==='Inactive'?'':'Inactive'
            actvInputs.state = actvInputs.states==='Labeled'?'':'Labeled'
            logInputs.state = logInputs.states==='Labeled'?'':'Labeled'
        }
        else if(root.mode === 'Offline'){
            root.action = 'Connect'
            root.state = root.states==='Offline'?'':'Offline'
            secretKey.defText = 'secret key'
            actvInputs.state = actvInputs.states==='Labeled'?'':'Labeled'
            logInputs.state = logInputs.states==='Labeled'?'':'Labeled'
        }
        else if(root.mode === 'Online'){
            root.state = root.states==='Online'?'':'Online'
        }
    }

    states: [
        State {
            name: "Inactive"
            PropertyChanges {
                target: actvContainer
                opacity: 1.0
                height: secretKey.height + secretKeySecondary.height + activationDtls.height
            }
            PropertyChanges {
                target: logContainer
                opacity: 0.0
                height: 0
            }
        },
        State {
            name: "Offline"
            PropertyChanges {
                target: actvContainer
                opacity: 0.0
                height: 0
            }
            PropertyChanges {
                target: logContainer
                opacity: 1.0
                height: loginDtls.height+loginKey.height
            }
        },
        State {
            name: "Online"
            PropertyChanges {
                target: actvContainer
                opacity: 0.0
                height: 0
            }
            PropertyChanges {
                target: logContainer
                opacity: 0.0
                height: 0
            }
        }
    ]

    Rectangle {
        id: actvContainer
        color: parent.color
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        property string secretKey: ''

        Caption {
            id: activationDtls
            height: 70
            caption: 'We have generated a Node ID for you. To begin, choose a suitable secret key. We will use this as your login key, and the encryption key to your archive'

            anchors {
                right: parent.right
                left: parent.left
                rightMargin: 20
            }
        }

        Column {
            id: actvInputs
            spacing: 2
            anchors {
                top: activationDtls.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
            }

            states: [
                State {
                    name: "Labeled"
                    PropertyChanges {
                        target: secretKey
                        defText: 'secret key'
                    }
                    PropertyChanges {
                        target: secretKeySecondary
                        defText: 'confirm key'
                    }
                }
            ]

            InputType {
                id: secretKey
                defText: ''
                anchors {
                    left: parent.left
                    right: parent.right
                }

                user: root.user
                nodeID: root.nodeID
                action: root.action

                onNewStateChanged: {
                    root.mode = newState
                }
            }

            InputType {
                id: secretKeySecondary
                defText: ''
                anchors {
                    left: parent.left
                    right: parent.right
                }

                user: root.user
                nodeID: root.nodeID
                publicKey: root.publicKey
                action: root.action
                secretKey: secretKey.secretKey

                onNewStateChanged: {
                    root.mode = newState
                }
            }
        }
    }

    Rectangle {
        id: logContainer
        color: parent.color
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }


        Caption {
            id: loginDtls
            height: 25
            caption: 'To Connect, simply key in your secret key.'

            anchors {
                right: parent.right
                left: parent.left
                rightMargin: 20
            }
        }

        Column {
            id: logInputs
            spacing: 2
            anchors {
                top: loginDtls.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
            }

            states: [
                State {
                    name: "Labeled"
                    PropertyChanges {
                        target: loginKey
                        defText: 'login key'
                        height: loginKey.height
                    }
                }
            ]

            InputType {
                id: loginKey
                defText: ''
                anchors {
                    left: parent.left
                    right: parent.right
                }

                user: root.user
                nodeID: root.nodeID
                publicKey: root.publicKey
                action: root.action

                onNewStateChanged: {
                    root.mode = newState
                }
            }
        }
    }
}
