import QtQuick 2.10

Rectangle {
    color:"#ffffff"
    property var tiltes:[]

    signal titleChecked(var title_data)
    signal callAddPage()

    function hasItemUnsaved(){
        for(var i = 0;i<titles_mode.count;i++){
            if(titles_mode.get(i).unsaved){
                return true
            }
        }
        return false
    }

    function setCurrentItemUnsaved(status){
        if(titles_list.currentIndex >= 0){
            titles_mode.setProperty(titles_list.currentIndex,"unsaved",status)
        }
    }

    function isCurrentItemUnsaved(){
        if(titles_list.currentIndex >= 0){
            return titles_mode.get(titles_list.currentIndex).unsaved;
        }

        return true;
    }

    function touchItem(title,path,doc){
        var i = titles_mode.getIndexByPath(path)
        console.log("touch title:"+title+" path:"+path+" i:"+i)
        if(i === -1){
            if((parent.width - 60)/(titles_mode.count+1) > 50 ){
                var js = {"title":title,"path":path,"unsaved":false,"doc":doc}
                titles_mode.append(js)
                titles_list.currentIndex = titles_mode.count-1
            }else{
                //too many titles
            }
        }else{
            titles_list.currentIndex = i
        }
    }

    function changeCurrentPath(new_path){
        var new_path_str = JSON.stringify(new_path)
        var i = titles_mode.getIndexByPath(new_path_str)
        if(i === -1){
            if(titles_list.currentIndex >= 0){
                //current is null path
                titles_mode.setProperty(titles_list.currentIndex,"title",
                                        utils.getBaseNameFromPath(new_path))
                titles_mode.setProperty(titles_list.currentIndex,"path",new_path_str)
            }else{
                //title list is null
                touchItem(utils.getBaseNameFromPath(new_path),new_path_str,editor.text)
            }
        }else if(i === titles_list.currentIndex){
            //current and new path is same
        }else{
            //new path is existed
            titles_mode.setProperty(titles_list.currentIndex,"title",
                                    utils.getBaseNameFromPath(new_path))
            titles_mode.setProperty(titles_list.currentIndex,"path",new_path_str)
            titles_mode.setProperty(titles_list.currentIndex,"doc",editor.text)
            console.log("will remove same title "+i+" "+new_path_str)
            titles_mode.remove(i,1)
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

        delegate:TitleNavigationItem{}

        onCurrentIndexChanged: {
            if(currentIndex >= 0){
                titleChecked(titles_mode.get(currentIndex))
            }else{
                var js = {"title":null,"path":null,"unsaved":false,"doc":null}
                titleChecked(js)
            }
        }
    }

    Image {
        anchors.verticalCenter: titles_list.verticalCenter
        anchors.left: titles_list.right
        anchors.leftMargin: 5
        width: 20
        height: 20
        source: "qrc:/item/images/svg/add.svg"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                callAddPage()
            }
        }
    }

    ListModel{
        id:titles_mode
        function getIndexByPath(path){
            if(path === null)
                return -1;

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
