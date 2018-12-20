/***************************************************************************
 *                                                                         *
 *   Copyright (C) 2018 by eapil                                           *
 *   http://www.eapil.com/index.html                                       *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#include "utils.h"
#include <QFile>
#include <QUrl>
#include <QFileDialog>
#include <QDebug>
#include <QSettings>
#include <QStandardPaths>

Utils::Utils(QQuickItem *parent) : QQuickItem(parent)
{

}

QString Utils::getSettingsFilePath()
{
    QString fileName = "./settings.ini";

    QFile file(fileName);
    if(!file.exists(fileName)){
        file.open(QFile::WriteOnly);
        file.close();
    }

    return fileName;
}

QVariant Utils::getSettingsValue(const QString &group, const QString &key, const QVariant &defalutValue)
{
    QVariant result = defalutValue;

    QString fileName = getSettingsFilePath();
    if (QFile::exists(fileName))
    {
        QSettings settings(fileName, QSettings::IniFormat);
        settings.beginGroup(group);
        result = settings.value(key,defalutValue);
        settings.endGroup();
    }

    return result;
}

void Utils::setSettingsValue(const QString &group, const QString &key, const QVariant &value)
{
    QString fileName = getSettingsFilePath();
    if (QFile::exists(fileName))
    {
        QSettings settings(fileName, QSettings::IniFormat);
        settings.beginGroup(group);
        settings.setValue(key,value);
        settings.endGroup();
    }
}

QString Utils::readFile(const QString &file_dir)
{
    QUrl url(file_dir);

    QString path = QDir::toNativeSeparators(url.toLocalFile());

    QFile file(path);
    if(!file.exists()){
        qWarning()<<"File not exist! "<<path;
        return "";
    }
    if(!file.open(QIODevice::ReadOnly|QIODevice::Text)){
        qWarning()<<"Cannot open the file!";
        return "";
    }
    auto content = file.readAll();

    file.close();

    return QString(content);
}

QString Utils::getBaseNameFromPath(const QString &file_path)
{
    QUrl url(file_path);
    QString path = QDir::toNativeSeparators(url.toLocalFile());
    return QFileInfo(path).baseName();
}

void Utils::textAppendStyleSheet(QQuickTextDocument *qd, const QString &style_url)
{
    qInfo()<<"textAppendStyleSheet "<<style_url;
    auto td = qd->textDocument();
    td->setDefaultStyleSheet(readFile(style_url));
}

bool Utils::saveDocToFile(const QString &doc, const QString &file_path)
{
    bool ret = false;
    QUrl url(file_path);
    QString file_path_t = QDir::toNativeSeparators(url.toLocalFile());
    qInfo()<<Q_FUNC_INFO<<file_path_t;
    QFile file(file_path_t);
    if(file.exists()){
        if(file.open(QFile::WriteOnly|QFile::Text)){
            if(file.write(doc.toUtf8()) > 0){
                ret = true;
            }else{
                qCritical()<<"save file but write to file failed!";
            }
            file.close();
        }else{
            qCritical()<<"save file but open failed";
        }
    }else{
        qCritical()<<"save file but file is not exit!";
    }

    return ret;
}
