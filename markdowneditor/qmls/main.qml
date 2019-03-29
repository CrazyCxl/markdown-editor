import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

import "./custom"
import "./custom/partition"
import "./custom/FileTree"
import "./custom/navigationbar"
import cxl.normal 1.0

ApplicationWindow {
    id:root
    visible: true
    width: 1340
    height: 820
    minimumWidth: 640
    minimumHeight: 480
    title: " "
    color:"#efefef"
//    flags: Qt.FramelessWindowHint | Qt.Window
    property int stepSize: 15

    MouseArea{
        id:root_area
        anchors.fill: parent
    }

    Utils{
        id:utils
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
                editor.path = typeof title_data.path === 'undefined'?null:title_data.path
            }else{
                editor.text = ""
            }
        }

        onCallAddPage: {
            touchItem(qsTr("New Page"),null,"")
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

    Triangle{
        property bool isOnlyEdit: false
        anchors.bottom:drog_line.bottom
        anchors.right:drog_line.left
        onClicked: {
            isOnlyEdit = !isOnlyEdit
            if(isOnlyEdit){
                drog_line.state = "EDIT"
            }else{
                drog_line.state = "EDITVIEW"
            }
        }
    }

    Triangle{
        property bool isOnlyRead: false
        anchors.bottom:parent.bottom
        anchors.left:drog_line.left
        trianglePosition:leftBottom
        color: "#c0c0c0"
        onClicked: {
            isOnlyRead = !isOnlyRead
            if(isOnlyRead){
                drog_line.state = "VIEW"
            }else{
                drog_line.state = "EDITVIEW"
            }
        }
    }

    SubTree{
        id:file_view
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        fileMode:fileModel
        enableChangeDir: true
        width:200

        onPathSelected: {
            navigation_bar.touchItem(file_view.selectTitle,path,utils.readFile(path))
        }
    }

    SettingsItem{
        visible: false
        onCallChangeDir: file_view.showChangeDirDialog()
        onCallOnlyEdit: drog_line.state = "EDIT"
        onCallOnlyRead: drog_line.state = "VIEW"
        onCallReadEdit: drog_line.state = "EDITVIEW"
    }

    DragArea{
        anchors.fill: parent
        onTextDrop: {
            editor.text += text
            navigation_bar.setCurrentItemUnsaved(true)
        }
        onFileDrop: navigation_bar.touchItem(utils.getBaseNameFromPath(file_path),
                                             file_path,utils.readFile(file_path))
    }

    Component.onCompleted: {
        if(typeof argPath !== 'undefined'){
            navigation_bar.touchItem(utils.getBaseNameFromPath(argPath),
                                     argPath,utils.readFile(argPath))
        }
    }

    property bool sureClose: false

    onClosing: {
        if(navigation_bar.hasItemUnsaved() && !sureClose){
            message_dialog.visible = true
            close.accepted = false
        }
    }

    Dialog{
        id:message_dialog
        title: qsTr("Warning")
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        onAccepted: {
            sureClose = true
            root.close()
        }

        contentItem: Rectangle {
            implicitWidth: 300
            implicitHeight: 60
            Text {
                text: qsTr("You have unsaved content, are you sure to close?")
                anchors.centerIn: parent
            }
        }

        standardButtons:StandardButton.Yes|StandardButton.Cancel
    }
}
