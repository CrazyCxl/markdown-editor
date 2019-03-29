import QtQuick 2.0
import QtQuick.Controls 2.0

Component{
    Rectangle{
        id:title_text
        width: titles_list.itemWidth
        height: titles_list.height
        radius: height/4

        color:ListView.isCurrentItem?colorSelect:colorNormal

        property color colorSelect: "#efefef"
        property color colorNormal: "#ffffff"
        property bool  isNormal: !ListView.isCurrentItem && !item_area.containsMouse && !delete_btn_area.containsMouse

        Rectangle{
            anchors.bottom: parent.bottom
            anchors.left:parent.left
            anchors.right: parent.right
            color: parent.color
            height: parent.radius
        }

        Image{
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/item/images/svg/point.svg"
            width: 20
            height: 20
            visible: unsaved
        }

        Text {
            id:tilte_text
            text: title
            anchors.centerIn: parent
        }

        MouseArea{
            id:item_area
            anchors.fill: parent
            onClicked:titles_list.currentIndex = index
            hoverEnabled: true
            onEntered: {
                var tmp = titles_mode.get(index).path
                if (typeof tmp !== 'undefined'){
                    title_path_tooltip.visible = true
                }
            }
            onExited: title_path_tooltip.visible = false
            ToolTip{
                id:title_path_tooltip
                delay:500
                onVisibleChanged:{
                    if(title_path_tooltip.visible){
                        title_path_tooltip.text = utils.filterNativeSeparators(titles_mode.get(index).path)
                    }
                }
            }
        }

        Rectangle{
            id:delete_btn
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            visible: !isNormal
            width: 20
            height: 20
            radius: width/2
            color: delete_btn_area.containsMouse?colorNormal:parent.color

            Image{
                anchors.centerIn: parent
                width: 10
                height: 10
                source: "qrc:/item/images/svg/delete.svg"
            }

            MouseArea{
                id:delete_btn_area
                anchors.fill: parent
                hoverEnabled: true
                onClicked: titles_mode.remove(index,1)
            }
        }
    }
}
