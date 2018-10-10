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

Utils::Utils(QQuickItem *parent) : QQuickItem(parent)
{

}

QString Utils::readFile(const QString &file_dir)
{
    QFile file(file_dir);
    if(!file.exists()){
        qWarning()<<"File not exist! "<<file_dir;
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
    auto td = qd->textDocument();
    td->setDefaultStyleSheet(readFile(style_url));
}
