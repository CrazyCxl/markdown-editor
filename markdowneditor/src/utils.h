/***************************************************************************
 *                                                                         *
 *   Copyright (C) 2018 by eapil                                           *
 *   http://www.eapil.com/index.html                                       *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QQuickItem>
#include <QQuickTextDocument>

#define VARIABLE_SETTINGS_GROUP "variable"

class Utils : public QQuickItem
{
    Q_OBJECT
public:
    explicit Utils(QQuickItem *parent = nullptr);

    static QString getSettingsFilePath();
    static QVariant getSettingsValue(const QString &group, const QString &key,const QVariant &defalutValue);
    static void     setSettingsValue(const QString &group, const QString &key,const QVariant &value);

    Q_INVOKABLE QString readFile(const QString &file_dir);
    Q_INVOKABLE void textAppendStyleSheet(QQuickTextDocument* qd,const QString &style_url);

signals:

public slots:
};

#endif // UTILS_H
