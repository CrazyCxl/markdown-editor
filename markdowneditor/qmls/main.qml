import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1

import "./custom/custom"
//import "./custom"

ApplicationWindow {
    id:root
    visible: true
    width: 1340
    height: 820
    minimumWidth: 640
    minimumHeight: 480
    color:"#efefef"
    flags: Qt.FramelessWindowHint | Qt.Window
    property int stepSize: 15

    TitleBar{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: root.stepSize
        anchors.topMargin: root.stepSize/2
    }

    Component.onCompleted: {

    }
}
