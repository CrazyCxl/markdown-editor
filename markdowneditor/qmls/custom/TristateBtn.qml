import QtQuick 2.2

Rectangle{
    radius: width/3
    color:root.color

    property string source
    signal clicked

    Image {
        width: parent.width*2/3
        height: width
        anchors.centerIn: parent
        source: parent.source
    }

    MouseArea{
        anchors.fill: parent
        property color normalColor: root.color
        property color hoverColor: "#ffffff"
        property color pressColor: "#e0e0e0"

        hoverEnabled: true
        onEntered: parent.color = hoverColor
        onExited: parent.color = normalColor
        onClicked: parent.clicked();
        onPressed:  parent.color = pressColor
        onReleased: {
            if (containsMouse)
              parent.color = hoverColor
            else
              parent.color = normalColor
        }
    }
}
