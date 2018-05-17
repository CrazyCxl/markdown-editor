#include "document.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QtWebEngine/QtWebEngine>
#include <QIcon>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_UseDesktopOpenGL);
    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();

//    if(app.arguments().contains("--log")){
//        is_loged = true;
//    }

//    qInstallMessageHandler(FileMessageHandler);

    app.setWindowIcon(QIcon(":/logo/images/32x32/markdown-editor-logo.png"));

    QQmlApplicationEngine engine;
    qmlRegisterType<Document>("cxl.normal", 1, 0, "Document");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
