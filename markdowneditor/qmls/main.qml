import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.4

import "./custom"

ApplicationWindow {
    id:root
    visible: true
    width: 1340
    height: 820
    minimumWidth: 640
    minimumHeight: 480
    color:"#efefef"
//    flags: Qt.FramelessWindowHint | Qt.Window
    property int stepSize: 15

    MouseArea{
        id:root_area
        anchors.fill: parent
    }

    MarkdownEditor{
        id:editor
    }

    Rectangle {
      id: scroller
      anchors.right: drog_line.left
      width: 8
      height: 45
      radius: width/2
      color: "grey"
      property real position
      property bool scroll_lock: false

      onYChanged: {
          scroll_lock = true
          position = y / (root.height - height)
          scroll_lock = false
      }

      onPositionChanged: {
          if(!scroll_lock){
              position = position>1?1:position
              y= position * (root.height - height)
          }
      }

      MouseArea {
        anchors.fill: parent
        drag.target: parent
        drag.minimumY: 0
        drag.maximumY: root.height - height
        drag.axis: Drag.YAxis
      }
    }

    DragLine{
        id:drog_line
    }

    Rectangle{
        color:"#ffffff"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: viewer.left
    }

    MarkdownViewer{
        id:viewer
        anchors.top:parent.top
        anchors.left: drog_line.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.stepSize*3
        anchors.topMargin: root.stepSize*3

        text:editor.text
    }

//    TitleBar{
//        id:title_bar
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.margins: root.stepSize
//        anchors.topMargin: root.stepSize/2
//    }

    Component.onCompleted: {

    }
}
