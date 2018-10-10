import QtQuick 2.2
import QtQuick.Controls 2.2
import QtWebChannel 1.0
import QtWebEngine 1.1
import QtQml 2.2
import QtWebEngine 1.6

import cxl.normal 1.0
import "../markdown-it.js" as MarkdownIt

ScrollView {
    id: flick
    property string text
    //boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: scroller
    TextArea{
        id:markdown_text
        readOnly: true
        textFormat: TextEdit.RichText
        wrapMode: TextEdit.WordWrap
        font.pixelSize: 15
        font.family: "Microsoft YaHei UI"
        Component.onCompleted: {
            utils.textAppendStyleSheet(markdown_text.textDocument,":/3rdparty/markdown.css")
        }
    }

    onTextChanged: {
        var md = MarkdownIt.markdownit();
        var mdHtml = md.render(text);
        markdown_text.text = mdHtml;
    }
}


