import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

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

    MouseArea{
        id:root_area
        anchors.fill: parent
    }

    TextArea{
        id:editor
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: drog_line.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: root.stepSize*3
        anchors.bottomMargin: root.stepSize*3
        anchors.topMargin: root.stepSize*3

        backgroundVisible:false


        Component.onCompleted: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "/default.md");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == XMLHttpRequest.DONE) {
                    var response =
                    // use file contents as required
                    editor.text = xhr.responseText
                }
            };
            xhr.send();
        }

        style: TextAreaStyle {
            frame:null
        }

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

    TitleBar{
        id:title_bar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: root.stepSize
        anchors.topMargin: root.stepSize/2
    }

    Component.onCompleted: {

    }
}
