import QtQuick 2.4

Rectangle {
    x: (parent.width-width+file_view.width)/2
    width: 2
    height: parent.height

    MouseArea {
        anchors.fill: parent
        cursorShape : Qt.SplitHCursor
        drag{
            target: parent
            axis: Drag.XAxis
            minimumX: root.width/3
            maximumX: root.width*2/3
        }

        onPressed: root_area.cursorShape = Qt.SplitHCursor
        onReleased: root_area.cursorShape = Qt.ArrowCursor
    }
}
