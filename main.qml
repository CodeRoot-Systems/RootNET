import QtQuick 2.0
import QtQuick.Window 2.0

// Module pyotherside to interface with Python3 Backend API.
import io.thp.pyotherside 1.5
// RootNET Objects
import "../RootNET/bin/qml/"
//import "../js/ScreenFetch.js" as ScreenFetch

/////////////////////////////////////////////+++++system+++++////////////////////////////////////////////////////
// RootNET .alpha *systemWindow
Window {
    id: system

    // Window Properties
    width: 820
    height: 640
    color: 'transparent'
    title: qsTr('RootNET')

    // QVariants (Python Object References)
    property var baseManager: ''
    property var daemon: ''
    property var profiler: ''

    // Global Properties
    property string user: ''
    property string host: ''
    property string os: ''
    property string base: ''
    property string kernel: ''
    property string architecture: ''
    property string processor: ''
    property string avatarSrc: ''
    // IPFS Daemon properties
    property string ipfsInstall: ''
    property bool nodeInitialized: false
    property string nodeID: ''
    property string publicKey: ''
    property string secretKey: ''
    property var addresses: []
    property string nodeState: 'off'
    // RootNET Profile Properties
    property bool registered: false
    property string mode: ''


    Python {
        id: python
        // Asynchronous calls to RootNET's backend
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'))

            // System Base Module
            importModule('lib.libbase', function(){
                call('lib.libbase.baseManager', [], function(baseManager){
                    system.baseManager = baseManager
                })
            })
            // IPFS Daemon Module
            importModule('lib.libipfs', function(){
                call('lib.libipfs.nodeManager', [], function(ipfsManager){
                    system.daemon = ipfsManager
                })
            })
            // RootNET Profiler Module
            importModule('bin.auth.profiler', function(){})
        }
    }


    // baseManager Signal
    onBaseManagerChanged: {
        // Base data mapper
        system.user = python.getattr(baseManager, 'user')
        system.host = python.getattr(baseManager, 'host')
        system.avatarSrc = python.getattr(baseManager, 'avatarSrc')


        var sysDetails = python.call(python.getattr(baseManager, 'getSysInfo'), {}, function(sysInfo){
            system.os = sysInfo['os']
            system.base = sysInfo['base']
            system.kernel = sysInfo['kernel']
            system.architecture = sysInfo['architecture']
            system.processor = sysInfo['processor']
        })
    }

    onDaemonChanged: {
        system.ipfsInstall = python.getattr(daemon, 'version')

        if (system.ipfsInstall !== '!!Missing'){
            system.nodeInitialized = python.getattr(daemon, 'initialized')
        }
    }

    // Write script to start the daemon on system boot.
    onNodeInitializedChanged: {
        // Code to initialize RootNET's Profiler module
        python.call('bin.auth.profiler.profiler', [], function(profiler){
            system.profiler = profiler
        })

        python.call(python.getattr(daemon, 'getNodeID'), {}, function(parseData){
            system.publicKey = parseData['PublicKey']
            system.addresses = parseData['Addresses']
            system.nodeID = parseData['ID']
        })

        /*
        Write code to activate daemon here.
        var init = python.getattr(daemon, 'daemonLoader')
        python.call(init, function(){
            console.log('Done...')
        })
        system.nodeState = 'on'
        */
    }

    onProfilerChanged: {
        var session = python.getattr(profiler, 'session')
        python.call(session, [], function(mode){
            system.mode = mode
        })
    }

    function modswitch(){
        if(system.mode === 'Inactive'){
            sidePane.state = sidePane.states==='Inactive'?'':'Inactive'
        }
        else if(system.mode === 'Offline'){
            sidePane.state = sidePane.states==='Offline'?'':'Offline'
        }
        else if(system.mode === 'Online'){
            sidePane.state = sidePane.states==='Online'?'':'Online'
        }
    }

    onModeChanged: {
        system.modswitch()
    }

    //////////////////////////////////////////////+++++canvas+++++////////////////////////////////////////////////////
    Rectangle {
        id: canvas
        color: '#1A1A1A'
        anchors {
            fill: parent
        }

        ///////////////////////////////////+++++Left Panel+++++/////////////////////////////////
        // Left Panel holding the Control Menu
        Rectangle {
            id: leftPanel
            color: 'transparent'
            width: 260
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            // +++++Profile Bar+++++
            ProfileBar {
                id: profileBar
                height: 110; width: 260
                anchors {
                    left: parent.left
                    top: parent.top
                }

                user: system.user
                avatarSrc: system.avatarSrc
                host: system.host
            }


            // +++++.xsession Controls+++++
            Xpane {
                id: xpane
                width: 0
                anchors {
                    top: profileBar.bottom
                    right: parent.right
                    leftMargin: 10
                    bottom: parent.bottom
                }

                onActiveXChanged: {
                    // page control changes to xpane.activeX
                    console.log(activeX)

                }
            }

            states: [
                State {
                    name: "Folded"
                    PropertyChanges {
                        target: sidePane
                        width: 0
                    }
                    PropertyChanges {
                        target: xpane
                        width: parent.width-10
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation {
                    target: sidePane
                    property: 'width'
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: xpane
                    property: "width"
                    duration: 1500
                    easing.type: Easing.InOutQuad
                }
            }

            // +++++ sidePane +++++
            SidePane {
                id: sidePane
                width: parent.width-10
                anchors {
                    top: profileBar.bottom
                    left: parent.left
                    leftMargin: 10
                    bottom: parent.bottom
                }

                // properties
                user: system.user
                mode: system.mode
                host: system.host
                os: system.os
                base: system.base
                kernel: system.kernel
                architecture: system.architecture
                processor: system.processor
                nodeID: system.nodeID
                publicKey: system.publicKey

                onModeChanged: {
                    system.mode = mode
                }

                onExpired: {
                    leftPanel.state=leftPanel.states==='Folded'?'':'Folded'
                    sidePane.invert()
                }

                onExpand: {
                    if(leftPanel.state === 'Folded'){
                        leftPanel.state = leftPanel.states===''?'':''
                        sidePane.normalize()
                    }
                    else if(leftPanel.state === ''){
                        leftPanel.state = leftPanel.states==='Folded'?'':'Folded'
                        sidePane.invert()
                    }
                }
            }
        }

        /////////////////////////////////////+++++Right Panel+++++///////////////////////////////////////
        // Right Panel holding the Workspace
        Rectangle {
            id: rightPanel
            color: "whitesmoke"
            opacity: 1.0
            anchors {
                left: leftPanel.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            /////////////////////////////////////+++++Pages+++++//////////////////////////////////////
            // PagePanel goes here.
            PagePanel {
                id: workpanel
                anchors.fill: parent
            }
        }
    }
}
