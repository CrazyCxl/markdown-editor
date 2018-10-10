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

QString Utils::readFile(const QString &file_dir)
{
    const QString filter = "file:///";

    QString path = file_dir;
    if(file_dir.startsWith(filter)){
        path = path.remove(0,filter.length());
    }

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
    return QString(content);
}

void Utils::textAppendStyleSheet(QQuickTextDocument *qd, const QString &style_url)
{
    qInfo()<<"textAppendStyleSheet "<<style_url;
    auto td = qd->textDocument();
    td->setDefaultStyleSheet(readFile(style_url));
}
