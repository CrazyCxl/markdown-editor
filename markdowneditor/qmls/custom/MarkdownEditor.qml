import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3
import cxl.normal 1.0

Flickable{
    anchors.leftMargin: root.stepSize*3
//    anchors.bottomMargin: root.stepSize*3
//    anchors.topMargin: root.stepSize*3
//    boundsBehavior: Flickable.OvershootBounds
    ScrollBar.vertical: scroller
    property string text
    property string path

    TextArea.flickable:  TextArea{
        id:text_area
        selectByMouse: true
        text: editor.text
        font.pixelSize: 15
        font.family: "Microsoft YaHei UI"
        onTextChanged: {
            if(editor.text !== text_area.text){
                editor.text = text_area.text
                navigation_bar.setCurrentItemUnsaved(true)
            }
        }
    }

    Shortcut {
        sequence: StandardKey.Save
        context: Qt.ApplicationShortcut
        onActivated: {
            if(navigation_bar.isCurrentItemUnsaved()){
                if(path !== null && path.length !== 0){
                    saveDoc(path)
                }else{
                    save_file_dialog.visible = true
                }
            }
        }
    }

    function saveDoc(path){
        var ret = utils.saveDocToFile(editor.text,path)
        console.log("saved "+path +" "+ret)
        navigation_bar.setCurrentItemUnsaved(!ret)
    }

    FileDialog{
        id:save_file_dialog
        title: qsTr("Save File")
        folder: shortcuts.home
        selectMultiple: false
        nameFilters: [qsTr("Markdown Files (*.md)"),qsTr("Text Files (*.txt)"),qsTr("All Files (*.*)")]
        onAccepted: {
            saveDoc(fileUrl)
            navigation_bar.changeCurrentPath(fileUrl)
        }
    }
}


