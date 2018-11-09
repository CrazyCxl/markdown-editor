import QtQuick 2.0

Item {
    property int offset:0
    x:0
    y:0

    Image{
        id:set_solid
        width: 30
        height: width
        x:set_hollow.x + offset
        y:set_hollow.y
        source: "qrc:/item/images/svg/sets/set_solid.svg"
    }

    Image{
        x:set_hollow.width
        y:root.height - set_hollow.height*2

        id:set_hollow
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
        }
    }
}
