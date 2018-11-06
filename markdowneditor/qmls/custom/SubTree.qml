import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import QtQuick.Dialogs 1.0

import cxl.normal 1.0

Item {
    property string selectPath
    property string selectTitle
    property string dirPath
    property var fileMode
    property bool enableChangeDir: false
    Item{
        id:top_item
        anchors.top: parent.top
        width: parent.width
        height: 30
        TextField {
            id:text_field
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            width: parent.width
            text: fileMode.dirPath
        }

        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                if(enableChangeDir){
                    fileDialog.visible = true
                }
            }
        }

        FileDialog {
            id: fileDialog
            title: qsTr("Please choose a directory")
            folder: fileMode.dirPath
            selectFolder:true
            selectMultiple:false
            onAccepted: {
                console.log("You chose: " + fileDialog.fileUrls)
                dirPath = fileDialog.fileUrl
            }
        }
    }

    ItemSelectionModel {
        id: sel
        model: fileMode
    }

    TreeView {
        id: view
        anchors.top: top_item.bottom
        width: parent.width
        anchors.bottom: parent.bottom
        model: fileMode
        rootIndex: fileMode.rootIndex
        selection: sel
        headerVisible: false

        TableViewColumn {
            role: "fileName"
        }

        onActivated : {
            if(!fileMode.data(index, FileModel.IsDirRole)){
                selectTitle = fileMode.data(index, FileModel.BaseNameStringRole)
                selectPath = fileMode.data(index, FileModel.UrlStringRole)
            }
        }
    }

    onDirPathChanged: {
        fileMode.dirPath = dirPath
    }
}
