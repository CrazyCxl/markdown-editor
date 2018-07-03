import QtQuick 2.2
import QtQuick.Controls 2.2
import QtWebChannel 1.0
import QtWebEngine 1.1
import QtQml 2.2
import QtWebEngine 1.6

import cxl.normal 1.0


Flickable {
    id: flick
    property string text
//    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: scroller
    onContentHeightChanged: console.log("onContentHeightChanged "+contentHeight)
    WebEngineView{
        id:web_view
        url: "qrc:/index.html"
        anchors.fill: parent
        settings.showScrollBars:false
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

    MouseArea{
        id:view_area
        width: web_view.width
        height: web_view.height
        property bool callScrollUp: false
        property double  scrollEnhance: 0
        onWheel: {
            scroll_run_timer.stop()
            scroll_stop_timer.stop()
            scroll_start_timer.stop()
            if(wheel.angleDelta.y > 0){
                callScrollUp = false
            }else{
                callScrollUp = true
            }
            scroller.stepSize = 0.02
            updateScroller()
            scroll_start_timer.start()
        }

        function updateScroller(){
            if(callScrollUp){
                scroller.increase()
            }else{
                scroller.decrease()
            }
        }

        Timer{
            id:scroll_run_timer
            interval: 10
            repeat: true
            onTriggered: {
                view_area.updateScroller()
                scroll_run_timer.interval++
                scroller.stepSize -= scroller.stepSize/5
            }
        }

        Timer{
            id:scroll_stop_timer
            interval: 500
            onTriggered: {
                scroll_run_timer.stop()
                scroll_run_timer.interval = 10
            }
        }

        Timer{
            id:scroll_start_timer
            interval: 20
            onTriggered: {
                scroll_run_timer.restart()
                scroll_stop_timer.restart()
            }
        }
    }

    Timer{
        id:reload_timer
        interval: 100
        onTriggered: web_view.reload()
    }

    onXChanged: {
        reload_timer.restart()
    }

//    Connections {
//        target:editor
//        onContentYChanged:  {
//            flick.contentY = editor.contentY/(editor.contentHeight-editor.height) * (flick.contentHeight-height)
//        }
//    }

    Component.onCompleted: {
        reload_timer.stop() //ignore first x change
    }
}


