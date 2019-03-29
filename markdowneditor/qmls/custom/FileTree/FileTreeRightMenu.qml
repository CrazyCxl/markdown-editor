import QtQuick 2.0
import QtQuick.Controls 2.2
import cxl.normal 1.0

Menu{
    property var selectFileIndex
    property bool isDir: false
    property bool isDirExpanded: false
    property bool isSpaceClick: false
    MenuItem{
        text: isDir? (isDirExpanded ? qsTr("Fold") : qsTr("Expanded") ): qsTr("Open")
        visible:!isSpaceClick
        height:visible?implicitHeight :0
        onTriggered: {
            if(isDir){
                if(isDirExpanded){
                    view.collapse(selectFileIndex)
                }else{
                    view.expand(selectFileIndex)
                }
            }else{
                file_view.selectTitle = fileMode.data(selectFileIndex, FileModel.BaseNameStringRole)
                file_view.pathSelected(fileMode.data(selectFileIndex, FileModel.UrlStringRole))
            }
        }
    }

    MenuItem{
        text: qsTr("Open the folder")
        visible:!isSpaceClick
        height:visible?implicitHeight :0
        onTriggered: {
            var url = fileMode.data(selectFileIndex, FileModel.DirStringRole)
            Qt.openUrlExternally(url)
        }
    }

    MenuItem{
        text: qsTr("Set working folders")
        visible:isSpaceClick
        height:visible?implicitHeight :0
        onTriggered: {
            file_view.showChangeDirDialog()
        }
    }

    function reload(index){
        selectFileIndex = index
        if(fileMode.data(index, FileModel.IsValidRole)){
            isSpaceClick = false
            if(!fileMode.data(index, FileModel.IsDirRole)){
                isDir = false
            }else{
                isDir = true
                isDirExpanded = view.isExpanded(index)
            }
        }else{
            isSpaceClick = true
        }
    }
}
