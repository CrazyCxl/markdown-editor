import QtQuick 2.0

Canvas {
    id:canvas
    implicitWidth: 10
    implicitHeight: 10
    height: width
    property color color:"#a0a0a0"
    property int rightTop: 0
    property int rightBottom: 1
    property int leftTop: 2
    property int leftBottom: 3

    property int trianglePosition:rightBottom
    signal clicked()

    onPaint: {
        var ctx = getContext("2d");
        ctx.fillStyle = color

        var sWidth = canvas.width;
        var sHeight = canvas.height;
        ctx.beginPath();
        if(trianglePosition === rightTop){
            ctx.moveTo(0,0);
            ctx.lineTo(sWidth,sHeight);
            ctx.lineTo(sWidth,0);
        }else if(trianglePosition === leftBottom){
            ctx.moveTo(0,0);
            ctx.lineTo(sWidth,sHeight);
            ctx.lineTo(0,height);
        }else if(trianglePosition === leftTop){
            ctx.moveTo(sWidth,0);
            ctx.lineTo(0,sHeight);
            ctx.lineTo(0,0);
        }else if(trianglePosition === rightBottom){
            ctx.moveTo(sWidth,0);
            ctx.lineTo(0,sHeight);
            ctx.lineTo(sWidth,sHeight);
        }

        ctx.closePath();
        ctx.fill();
    }
    MouseArea{
        id:_triangle_area
        anchors.fill: parent
        cursorShape:Qt.PointingHandCursor
        onClicked: parent.clicked()
    }
}

