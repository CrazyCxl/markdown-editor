import QtQuick 2.0

Rectangle {
    color:"#ffffff"
    property var tiltes:[]

    signal titleChecked(var title_data)

    function touchItem(title,path,doc){
        var i = titles_mode.getIndexByPath(path)
        console.log("touch title:"+title+" path:"+path+" i:"+i)
        if(i === -1){
            if((parent.width - 60)/(titles_mode.count+1) > 50 ){
                var js = {"title":title,"path":path,"unsaved":false,"doc":doc}
                var msg = {"model":titles_mode,"data":js}
                titles_mode.append(js)
                titles_list.currentIndex = titles_mode.count-1
            }else{
                //too many titles
            }
        }else{
            titles_list.currentIndex = i
        }
    }

    ListView{
        id:titles_list
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom:parent.bottom
        orientation: ListView.Horizontal
        width: itemWidth*titles_mode.count
        model: titles_mode
        property int itemWidth: {
            var h = 50;
            if(titles_mode.count > 0){
                h = (parent.width - 60)/titles_mode.count;
                if(h > parent.width /3){
                    h = parent.width /3;
                }else if( h < 50){
                    h = 50;
                }
            }
            return h;
        }

        delegate:Component{
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

                Text {
                    text: title
                    anchors.centerIn: parent
                }

                MouseArea{
                    id:item_area
                    anchors.fill: parent
                    onClicked:titleChecked(titles_mode.get(index))
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
    }


    ListModel{
        id:titles_mode
//        ListElement {
//            title: "test"
//            path:"test"
//            doc:"test"
//        }
        function getIndexByPath(path){
            for(var i = 0;i < count;i++){
                if(path === get(i).path ){
                    return i;
                }
            }
            return -1;
        }
    }

    Item {
        id: add_btn
        anchors.left: titles_list.right
        anchors.top: parent.top
        anchors.bottom:parent.bottom
    }
}
