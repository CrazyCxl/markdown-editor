import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQml 2.2
import QtWebEngine 1.6

import cxl.normal 1.0
import "../markdown-it.js" as MarkdownIt

Flickable {
    id: flick
    property string text
    //boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: scroller
    flickableDirection :Flickable.VerticalFlick
    TextArea.flickable:TextArea{
        id:markdown_text
        readOnly: true
        textFormat: TextEdit.RichText
        wrapMode: TextEdit.WordWrap
        font.pixelSize: 15
        font.family: "Microsoft YaHei UI"
        Component.onCompleted: {
            utils.textAppendStyleSheet(markdown_text.textDocument,":/3rdparty/simple-markdown.css")
        }
    }

    onTextChanged: {
        //var md = MarkdownIt.markdownit();
        var md = MarkdownIt.markdownit({
          html: true,
          linkify: true
        });
        var mdHtml = md.render(text);
        markdown_text.text ="<body class=\"markdown\">"+ mdHtml+"</body>";
    }
}


