import QtQuick 2.0

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
            text: title
            anchors.centerIn: parent
        }

        MouseArea{
            id:item_area
            anchors.fill: parent
            onClicked:titles_list.currentIndex = index
            hoverEnabled: true
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
