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
            minimumX: file_view.width
            maximumX: root.width
        }

        onPressed: root_area.cursorShape = Qt.SplitHCursor
        onReleased: root_area.cursorShape = Qt.ArrowCursor
    }

    state:"EDITVIEW"

    states: [
        State {
            name: "EDIT"
            PropertyChanges { target: drog_line; x: root.width}
        },
        State {
            name: "VIEW"
            PropertyChanges { target: drog_line; x: file_view.width}
        },
        State {
            name: "EDITVIEW"
            PropertyChanges { target: drog_line; x: (root.width-drog_line.width+file_view.width)/2}
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation { properties: "x"; easing.type: Easing.InOutQuad }
        }
    ]
}
