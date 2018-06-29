import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Flickable{
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: drog_line.left
    anchors.bottom: parent.bottom
    anchors.leftMargin: root.stepSize*3
    anchors.bottomMargin: root.stepSize*3
    anchors.topMargin: root.stepSize*3
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: scroller
    property string text:text_area.text
    TextArea.flickable:  TextArea{
        id:text_area
        Component.onCompleted: {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "/default.md");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var response =
                    // use file contents as required
                    text_area.text = xhr.responseText
                }
            };
            xhr.send();
        }
    }
}


