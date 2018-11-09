import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Styles 1.4

import cxl.normal 1.0

Item {
    property string selectTitle
    property string dirPath
    property var fileMode
    property bool enableChangeDir: false

    signal pathSelected(var path)

    Rectangle{
        id:top_item
        anchors.top: parent.top
        width: parent.width
        height: 30
        color:"#ffffff"
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

        style: TreeViewStyle {
            branchDelegate: Image {
                width: 14
                height: width
                source:styleData.isExpanded ? "qrc:/item/images/svg/triangle_down.svg" : "qrc:/item/images/svg/triangle_right.svg"
            }

            itemDelegate: Item {
                Image {
                    id: doc_type_image
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.verticalCenter: parent.verticalCenter
                    width: 15
                    height: width
                    source: styleData.hasChildren?
                                (styleData.isExpanded?"qrc:/item/images/svg/dir_open.svg":"qrc:/item/images/svg/dir.svg"):
                                (fileMode.data(styleData.index, FileModel.IsMarkdownFileRole)?"qrc:/item/images/svg/doc.svg":
                                                                                               "qrc:/item/images/svg/doc_null.svg")
                }

                Text {
                    anchors.left: doc_type_image.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    elide: Text.ElideMiddle
                    text: styleData.value
                }
            }

            rowDelegate:Rectangle{
                height: 25
                color: styleData.selected?"#efefef":"#ffffff"
            }

            handle: Rectangle {
                implicitWidth: 10
                color: styleData.hovered?"#c0c0c0":"#e0e0e0"
            }

            scrollBarBackground: Rectangle {
                implicitWidth: 10
                color: "#f5f5f5"
            }
            decrementControl: null
            incrementControl: null
        }

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
    }

    onDirPathChanged: {
        fileMode.dirPath = dirPath
    }
}
