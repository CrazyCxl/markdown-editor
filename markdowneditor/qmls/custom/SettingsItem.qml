import QtQuick 2.10
import "./items"

Item {
    id:set_item
    x:0
    y:0

    signal callChangeDir()
    signal callOnlyEdit()
    signal callOnlyRead()
    signal callReadEdit()

    property int offset:{
        var w = set_hollow.width + list_set.width + edit_set.width+look_set.width+ edit_look_set.width +itemMargin*5
        if( set_hollow.x+w > root.width){
            return -w;
        }
        return w;
    }

    property int itemMargin: 10

    Rectangle{
        id:sets_background
        anchors.left: set_hollow.left
        anchors.verticalCenter: set_hollow.verticalCenter
        anchors.right: set_solid.right
        anchors.margins: -5
        height: set_hollow.height+itemMargin
        color: "#e0e0e0"
        radius: 8
    }

    Image{
        id:set_solid
        width: 30
        height: width
        x:set_hollow.x
        y:set_hollow.y
        source: "qrc:/item/images/svg/sets/set_solid.svg"
        MouseArea{
            anchors.fill: parent
            onClicked: changeState()
        }
    }

    Image{
        id:set_hollow
        y:root.height - set_hollow.height*2
        x:set_hollow.width
        width: set_solid.width
        height: width
        source: "qrc:/item/images/svg/sets/set_hollow.svg"

        MouseArea{
            id:set_hollow_area
            anchors.fill: parent
            drag{
                target: parent
                axis: Drag.XAndYAxis
                minimumX: -set_hollow.width+5
                maximumX: root.width - 5
                minimumY: 0
                maximumY: root.height -set_hollow.height
            }
            onClicked: changeState()
        }
    }

    ImageButton{
        id:list_set
        x:offset > 0? set_hollow.x + set_hollow.width+itemMargin:set_hollow.x - list_set.width - itemMargin
        anchors.verticalCenter: set_hollow.verticalCenter
        width: 30;height: list_set.width
        imageSource: "qrc:/item/images/svg/sets/file_list.svg"
        onClicked: callChangeDir()
        normalColor: sets_background.color
        hoverColor: "#ffffff"
    }

    ImageButton{
        id:edit_set
        x:offset > 0? list_set.x + list_set.width+itemMargin:list_set.x - edit_set.width - itemMargin
        anchors.verticalCenter: set_hollow.verticalCenter
        width: list_set.width;height: list_set.width
        opacity:list_set.opacity
        visible: list_set.visible
        imageSource: "qrc:/item/images/svg/sets/edit.svg"
        onClicked: callOnlyEdit()
        normalColor: sets_background.color
        hoverColor: list_set.hoverColor
    }


    ImageButton{
        id:look_set
        x:offset > 0? edit_set.x + edit_set.width+itemMargin:edit_set.x - look_set.width - itemMargin
        anchors.verticalCenter: set_hollow.verticalCenter
        width: edit_set.width;height: look_set.width
        opacity:list_set.opacity
        normalColor: sets_background.color
        hoverColor: list_set.hoverColor
        imageSource: "qrc:/item/images/svg/sets/look.svg"
        onClicked: callOnlyRead()
    }


    ImageButton{
        id:edit_look_set
        x:offset > 0? look_set.x + look_set.width+itemMargin:look_set.x - edit_look_set.width - itemMargin
        anchors.verticalCenter: set_hollow.verticalCenter
        width: edit_set.width;height: look_set.width
        opacity:list_set.opacity
        imageSource: "qrc:/item/images/svg/sets/edit_view.svg"
        onClicked: callReadEdit()
        normalColor: sets_background.color
        hoverColor: list_set.hoverColor
    }

    function changeState(){
        if(set_item.state == "SETTING"){
            set_item.state ="UNSET"
        }else{
            set_item.state ="SETTING"
        }
    }

    state:"UNSET"

    states: [
        State {
            name: "SETTING"
            PropertyChanges { target: set_solid; x: set_hollow.x+offset}
            PropertyChanges { target: set_solid; rotation: 180}
            PropertyChanges { target: list_set; opacity:1}
        },
        State {
            name: "UNSET"
            PropertyChanges { target: set_solid; x: set_hollow.x}
            PropertyChanges { target: set_solid; rotation: 0}
            PropertyChanges { target: list_set; opacity:0 }
        }
    ]

    transitions: [
        Transition {
            from: "SETTING"
            to: "UNSET"
            PropertyAnimation {target: set_solid; duration: 200;properties: "x"; easing.type: Easing.InOutQuad}
            PropertyAnimation {target: set_solid; duration: 200;properties: "rotation"; easing.type: Easing.Linear}
            PropertyAnimation {target: list_set; duration: 500;properties: "opacity"; easing.type: Easing.Linear}
        },
        Transition {
            from: "UNSET"
            to: "SETTING"
            PropertyAnimation { target: set_solid; duration: 200;properties: "x"; easing.type: Easing.InOutQuad}
            PropertyAnimation {target: set_solid; duration: 200;properties: "rotation"; easing.type: Easing.Linear}
            PropertyAnimation {target: list_set; duration: 500;properties: "opacity"; easing.type: Easing.Linear}
        }
    ]
}
