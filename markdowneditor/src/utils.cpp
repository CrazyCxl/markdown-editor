/***************************************************************************
 *                                                                         *
 *   Copyright (C) 2018 by eapil                                           *
 *   http://www.eapil.com/index.html                                       *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#include "utils.h"
#include <QFile>
#include <QDebug>
#include <QSettings>

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

QString Utils::filterPath(const QString &path_t)
{
    const QString filter = "file:///";

    QString path_r = path_t;
    if(path_t.startsWith(filter)){
        path_r = path_r.remove(0,filter.length());
    }

    return path_r;
}

QString Utils::readFile(const QString &file_dir)
{
    QString path = filterPath(file_dir);
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

void Utils::textAppendStyleSheet(QQuickTextDocument *qd, const QString &style_url)
{
    qInfo()<<"textAppendStyleSheet "<<style_url;
    auto td = qd->textDocument();
    td->setDefaultStyleSheet(readFile(style_url));
}

bool Utils::saveDocToFile(const QString &doc, const QString &file_path)
{
    bool ret = false;
    QFile file(filterPath(file_path));
    if(file.exists()){
        if(file.open(QFile::WriteOnly)){
            if(file.write(doc.toLatin1()) > 0){
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
