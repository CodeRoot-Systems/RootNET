import QtQuick 2.0
import QtQuick.Controls 2.2
import '../Pages/'

Item {
    id: root

    property string focusedPage: ''

    // Pages go here.
    Archive {
        id: pgArchives
        anchors {left: parent.left; right: parent.right}
        anchors {top: parent.top; bottom: parent.bottom}
    }

}
