import QtQuick 2.4

Rectangle{
    id:_rect
    property color normalColor
    property color hoverColor
    property url   imageSource

    signal clicked()

    radius: width/5
    color: _rect_area.containsMouse?hoverColor:normalColor
    Image{
        anchors.fill: parent
        anchors.margins: parent.width/6
        mipmap:true
        source: imageSource
        MouseArea{
            id:_rect_area
            anchors.fill: parent
            hoverEnabled: true
            onClicked: _rect.clicked()
        }
    }
}
