import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4

TextArea{
    id:editor
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: drog_line.left
    anchors.bottom: parent.bottom
    anchors.leftMargin: root.stepSize*3
    anchors.bottomMargin: root.stepSize*3
    anchors.topMargin: root.stepSize*3
    backgroundVisible:false
    property bool scroll_lock: false

    Connections {
        target:scroller
        onPositionChanged: {
            scroll_lock = true
            flickableItem.contentY = scroller.position * (flickableItem.contentHeight-height)
            scroll_lock = false
        }
    }

    Connections {
        target:flickableItem
        onContentYChanged: {
            if(!scroll_lock){
               scroller.position= flickableItem.contentY /(flickableItem.contentHeight-height)
            }
        }
    }

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "/default.md");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var response =
                // use file contents as required
                editor.text = xhr.responseText
            }
        };
        xhr.send();
    }

    style: TextAreaStyle {
        frame:null
        decrementControl:null
        incrementControl:null
        handle:null
        scrollBarBackground:null
//        handle: Item {
//            implicitWidth: 14
//            implicitHeight: 26
//            Rectangle {
//                color: "#aaaaaa"
//                anchors.fill: parent
//                anchors.topMargin: 6
//                anchors.leftMargin: 4
//                anchors.rightMargin: 4
//                anchors.bottomMargin: 6
//                radius: width/2
//            }
//        }
//        scrollBarBackground: Item {
//            implicitWidth: 14
//            implicitHeight: 26
//        }
    }

}
