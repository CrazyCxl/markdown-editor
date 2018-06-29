TEMPLATE = app
DESTDIR = $$PWD/bin
PROJECT_DIR = $$[DESTDIR]

QT += webenginewidgets webchannel qml quick webengine
CONFIG += c++11

HEADERS += \
    document.h

SOURCES = \
    main.cpp \
    document.cpp

RESOURCES = \
    resources/markdowneditor.qrc \
    resources/images.qrc \
    qmls/base.qrc

FORMS +=

DISTFILES += \
    resources/3rdparty/MARKDOWN-LICENSE.txt \
    resources/3rdparty/MARKED-LICENSE.txt

# Copies the given files to the destination directory
defineTest(CopyToDestDir) {
    files = $$1

    for(FILE, files) {
        DDIR = $$DESTDIR

        # Replace slashes in paths with backslashes for Windows
        win32:FILE ~= s,/,\\,g
        win32:DDIR ~= s,/,\\,g

        QMAKE_POST_LINK += $$QMAKE_COPY $$quote($$FILE) $$quote($$DDIR) $$escape_expand(\\n\\t)
    }

    export(QMAKE_POST_LINK)
}

CONFIG(debug, debug|release){
    CONFIG += console

    win32:target.files += $$[QT_HOST_BINS]/Qt5Cored.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Guid.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Networkd.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Sqld.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Widgetsd.dll

    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qminimald.dll
    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qoffscreend.dll
    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qwindowsd.dll

    CopyToDestDir($$[QT_HOST_BINS]/Qt5Cored.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Guid.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Networkd.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Quickd.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Widgetsd.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebEngined.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebEngineCored.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Qmld.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebChanneld.dll)
}

CONFIG(release, debug|release){
    TARGET = EapilPCBAInstpectionTool
    CONFIG -= app_bundle
    CONFIG -= console
#    DEFINES += QT_NO_DEBUG_OUTPUT

    win32:target.files += $$[QT_HOST_BINS]/Qt5Core.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Gui.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Network.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Sql.dll
    win32:target.files += $$[QT_HOST_BINS]/Qt5Widgets.dll

    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qminimal.dll
    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qoffscreen.dll
    win32:plugins_platforms.files += $$[QT_INSTALL_PLUGINS]/platforms/qwindows.dll

    CopyToDestDir($$[QT_HOST_BINS]/Qt5Core.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Gui.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Network.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Quick.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Widgets.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebEngine.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebEngineCore.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5Qml.dll)
    CopyToDestDir($$[QT_HOST_BINS]/Qt5WebChannel.dll)
}

win32 {
    QML_IMPORT_PATH = D:\Qt\5.10.1\msvc2017_64\qml
}
# install
target.path = $$PWD/bin
plugins_platforms.path = $$PWD/bin/platforms

INSTALLS += target
INSTALLS += plugins_platforms

