import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import QtQuick.Dialogs 1.0
import cxl.normal 1.0

Rectangle {
    color:"#ffffff"

    property string selectTitle
    property string dirPath
    property var fileMode
    property bool enableChangeDir: false

    signal pathSelected(var path)

    function showChangeDirDialog(){
        if(enableChangeDir){
            fileDialog.visible = true
        }
    }

    Rectangle{
        id:top_item
        anchors.top: parent.top
        width: parent.width
        height: 30
        visible: false
        Text {
            id:text_field
            anchors.centerIn: parent
            width: parent.width-20
            text: fileMode.dirPath
            elide: Text.ElideMiddle
            color:top_area.containsMouse?"#202020":"#000000"
        }

        MouseArea{
            id:top_area
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                showChangeDirDialog()
            }
        }

        FileDialog {
            id: fileDialog
            title: qsTr("Please choose a directory")
            folder: "file:///" + fileMode.dirPath
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
        anchors.top: top_item.visible?top_item.bottom:parent.top
        width: parent.width
        anchors.bottom: parent.bottom
        model: fileMode
        rootIndex: fileMode.rootIndex
        selection: sel
        headerVisible: false

        TableViewColumn {
            role: "fileName"
        }

        FileTreeRightMenu{
            id:right_menu
        }

        style:FileTreeViewStyle{}

        onDoubleClicked: {
            if(!fileMode.data(index, FileModel.IsDirRole)){
                selectTitle = fileMode.data(index, FileModel.BaseNameStringRole)
                pathSelected(fileMode.data(index, FileModel.UrlStringRole))
            }else{
                if(view.isExpanded(index)){
                    view.collapse(index)
                }else{
                    view.expand(index)
                }

            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            acceptedButtons: Qt.RightButton
            onClicked: mouse.accepted = false;
            onPressed: {
                var index_t = parent.indexAt(mouse.x,mouse.y)
                right_menu.x = mouse.x
                right_menu.y = mouse.y
                right_menu.visible = true
                view.selection.setCurrentIndex(index_t,ItemSelectionModel.Select)
                right_menu.reload(index_t)
                mouse.accepted = false;
            }
            onReleased: mouse.accepted = false;
            onDoubleClicked: mouse.accepted = false;
            onPositionChanged: mouse.accepted = false;
            onPressAndHold: mouse.accepted = false;
        }
    }

    onDirPathChanged: {
        fileMode.dirPath = dirPath
    }
}
