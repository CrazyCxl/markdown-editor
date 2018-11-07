import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

import "./custom"
import cxl.normal 1.0

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

    Utils{
        id:utils
    }

    MouseArea{
        id:root_area
        anchors.fill: parent
    }

    SubTree{
        id:file_view
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        fileMode:fileModel
        enableChangeDir: true
        width:200
        onSelectPathChanged: {
            navigation_bar.touchItem(file_view.selectTitle,file_view.selectPath,utils.readFile(file_view.selectPath))
        }
    }

    TitleNavigationBar{
        id:navigation_bar
        anchors.top: file_view.top
        anchors.left: file_view.right
        anchors.right: drog_line.left
        height: 30

        onTitleChecked: {
            if(title_data.path !== null){
                editor.text = title_data.doc
                editor.path = title_data.path
            }else{
                editor.text = ""
            }
        }
    }

    MarkdownEditor{
        id:editor
        anchors.top: navigation_bar.bottom
        anchors.left: file_view.right
        anchors.right: drog_line.left
        anchors.bottom: parent.bottom
        onTextChanged: {
            viewer.text = editor.text
        }
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
//        anchors.bottomMargin: root.stepSize*3
//        anchors.topMargin: root.stepSize*3
    }

    Component.onCompleted: {

    }
}
