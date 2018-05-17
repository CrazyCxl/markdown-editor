import QtQuick 2.2
import QtQuick.Controls 1.2
import QtWebChannel 1.0
import QtWebEngine 1.1
import QtQml 2.2

import cxl.normal 1.0

Item {

    property string text
    Flickable {
        id: flick
        anchors.fill: parent
        WebEngineView{
            id:web_view
            anchors.fill: parent
            url: "qrc:/index.html"
            webChannel:WebChannel{
                registeredObjects:[m_content]
            }

            Document{
                id:m_content
                text:viewer.text
                WebChannel.id:"content"
            }

            onLoadingChanged: {
                if (web_view.loadProgress == 100) {
                    web_view.runJavaScript(
                        "document.documentElement.scrollHeight;",
                        function (i_actualPageHeight) {
                            flick.contentHeight = Math.max (
                                i_actualPageHeight, flick.height);
                        })
                    web_view.runJavaScript(
                        "document.documentElement.scrollWidth;",
                        function (i_actualPageWidth) {
                            flick.contentWidth = Math.max (
                                i_actualPageWidth, flick.width);
                        })
                }
            }
        }

        Connections {
            target:scroller
            onPositionChanged: {
                flick.contentY = scroller.position * (flick.contentHeight-height)
            }
        }
    }


}
