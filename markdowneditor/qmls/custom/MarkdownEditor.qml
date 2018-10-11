import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Flickable{
    anchors.leftMargin: root.stepSize*3
//    anchors.bottomMargin: root.stepSize*3
//    anchors.topMargin: root.stepSize*3
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: scroller
    property string text
    TextArea.flickable:  TextArea{
        id:text_area
        selectByMouse: true
        text: editor.text
        font.pixelSize: 15
        font.family: "Microsoft YaHei UI"
        onTextChanged: {
            if(editor.text !== text_area.text){
                editor.text = text_area.text
            }
        }
    }
}


