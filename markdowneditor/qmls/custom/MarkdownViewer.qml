import QtWebChannel 1.0
import QtWebEngine 1.1

import cxl.normal 1.0

WebEngineView{
    url: "qrc:/index.html"
    property string text
    webChannel:WebChannel{
        registeredObjects:[m_content]
    }

    Document{
        id:m_content
        text:viewer.text
        WebChannel.id:"content"
    }
}
