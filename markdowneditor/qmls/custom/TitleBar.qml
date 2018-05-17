import QtQuick 2.2

Item{
    height: root.stepSize * 2
//    color:  "#aaaaaa"
    anchors.right: parent.right
    anchors.top: parent.top

    TristateBtn{
        id: delete_btn
        width: parent.height
        height: width
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/item/images/svg/delete.svg"
        onClicked: root.close()
    }


    TristateBtn {
        id:max_btn
        anchors.left: parent.left
        width: delete_btn.width
        height: width
        anchors.top: delete_btn.top
        source: "qrc:/item/images/svg/max.svg"

        property bool isMaxed: false

        onClicked: {
            if(isMaxed){
                root.showNormal()
                isMaxed = false
                max_btn.source = "qrc:/item/images/svg/max.svg"
            }else{
                root.showFullScreen()
                isMaxed = true
                max_btn.source = "qrc:/item/images/svg/min.svg"
                max_btn.color=root.color
            }
        }
    }
}
