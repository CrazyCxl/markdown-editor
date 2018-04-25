#include "document.h"
#include "mainwindow.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
//    MainWindow window;
//    window.show();

    QGuiApplication app(argc, argv);

//    if(app.arguments().contains("--log")){
//        is_loged = true;
//    }

//    qInstallMessageHandler(FileMessageHandler);

    app.setWindowIcon(QIcon(":/logo/images/32x32/markdown-editor-logo.png"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
