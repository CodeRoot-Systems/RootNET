import QtQuick 2.0
import QtQuick 2.7
// Pyotherside to interface with profiler
import io.thp.pyotherside 1.5

Item {
    id: root
    height: 25
    // QTVariant Profiler
    property var profiler: ''
    // Global Properties
    property string user: ''
    property string nodeID: ''
    property string publicKey: ''

    property string defText: ''
    property string secretKey: ''
    property string secretKeySecondary: ''
    property string loginKey: ''
    property string action: ''
    property string newState: ''

    Python {
        id: profiler_py

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'))

            // Profiler Module
            importModule('bin.auth.profiler', function(){
                call('bin.auth.profiler.profiler',[], function(profiler){
                    root.profiler = profiler
                })
            })
        }
    }

    onDefTextChanged: {
        inputType.text = root.defText
    }

    TextInput {
        id: inputType
        activeFocusOnPress: true
        height: 15
        anchors {
            right: parent.right
            rightMargin: 60
            left: parent.left
        }
        text: root.defText
        wrapMode: TextInput.Wrap
        autoScroll: false
        renderType: TextInput.QtRendering
        padding: 2
        color: "Gray"
        horizontalAlignment: TextInput.AlignLeft

        font {
            capitalization: Font.MixedCase
            family: "Arial"
            hintingPreference: Font.PreferDefaultHinting
            letterSpacing: 1
            pixelSize: 13
        }
        overwriteMode: true

        onFocusChanged: {
            if(inputType.text === root.defText){
                inputType.text = ''
                inputType.color = 'White'
                inputType.echoMode = TextInput.Password
            }
            else if(inputType.text === ''){
                inputType.color = 'Gray'
                inputType.text = root.defText
                inputType.echoMode = TextInput.Normal
            }
        }

        onTextChanged: {
            if(root.defText === 'secret key'){
                if(inputType.text.length >= 8){
                    root.secretKey = inputType.text
                }
                else {
                    console.log('Secret Key should be longer than 8 characters')
                }
            }
            else if(root.defText === 'confirm key'){
                if(root.secretKey !== 'secret key'){
                    root.secretKeySecondary = inputType.text

                    if(root.secretKey !== ''){
                        if(root.secretKey !== root.defText){
                            if(root.secretKeySecondary === root.secretKey){
                                // Send secret key to backend for hashing
                                // change state to activated (Offline)
                                var regEngine = profiler_py.getattr(root.profiler, 'activation')
                                profiler_py.call(regEngine, [root.nodeID, root.publicKey, root.secretKey], function(message){
                                    console.log(message)
                                    root.newState = 'Offline'
                                    root.action = 'Connect'
                                })
                            }
                        }
                    }
                }
            }
            else if(root.defText === 'login key'){
                root.loginKey = inputType.text
                if(root.loginKey !== root.defText){
                    // hash input key and send for evaluation to backend
                    var authEngine = profiler_py.getattr(root.profiler, 'authorization')
                    profiler_py.call(authEngine, [loginKey], function(result){

                        if(result === '<-false>'){
                            root.newState = 'Offline'
                        }
                        else if(result === '<+true>'){
                            root.newState = 'Online'
                            var update = profiler_py.getattr(root.profiler, 'setState')
                            profiler_py.call(update, [root.newState], function(){})
                        }
                    })
                }
            }
        }
    }

    // Validation Indicator goes here
    // Type {image}

    Rectangle {
        id: underStroke
        color: "#2E2E2E"
        height: 1
        anchors {
            top: inputType.bottom
            topMargin: 4
            right: inputType.right
            rightMargin: 30
            left: parent.left
        }
    }
}
