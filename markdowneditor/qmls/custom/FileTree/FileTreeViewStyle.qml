import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import cxl.normal 1.0

TreeViewStyle {
    frame:null
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
                        (fileMode.data(styleData.index, FileModel.IsMarkdownFileRole)?"qrc:/item/images/svg/file-markdown.svg":
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
