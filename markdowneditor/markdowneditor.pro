TEMPLATE = app
DESTDIR = $$PWD/bin
PROJECT_DIR = $$[DESTDIR]

QT += webenginewidgets webchannel qml quick webengine
CONFIG += c++11

HEADERS += \
    src/document.h \
    src/filemodel.h \
    src/utils.h

SOURCES = \
    src/main.cpp \
    src/document.cpp \
    src/filemodel.cpp \
    src/utils.cpp

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
    DESTDIR = $$PWD/output/debug
}

CONFIG(release, debug|release){
    CONFIG -= app_bundle
    CONFIG -= console
    DESTDIR = $$PWD/output/release
}

win32 {
    QML_IMPORT_PATH = D:\Qt\5.10.1\msvc2017_64\qml
}
# install
target.path = $$PWD/bin
plugins_platforms.path = $$PWD/bin/platforms

INSTALLS += target
INSTALLS += plugins_platforms

