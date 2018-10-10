import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

import "./custom"

ApplicationWindow {
    id:root
    visible: true
    width: 1340
    height: 820
    minimumWidth: 640
    minimumHeight: 480
    color:"#efefef"
//    flags: Qt.FramelessWindowHint | Qt.Window
    property int stepSize: 15

    MouseArea{
        id:root_area
        anchors.fill: parent
    }

    MarkdownEditor{
        id:editor
    }

    ScrollBar{
      id: scroller
      anchors.right: drog_line.left
      anchors.top: parent.top
      anchors.bottom: parent.bottom
    }

    DragLine{
        id:drog_line
    }

    Rectangle{
        color:"#ffffff"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: viewer.left
    }

    MarkdownViewer{
        id:viewer
        anchors.top:parent.top
        anchors.left: drog_line.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.stepSize*3
        anchors.topMargin: root.stepSize*3

        text:editor.text
    }

    Component.onCompleted: {

    }
}
