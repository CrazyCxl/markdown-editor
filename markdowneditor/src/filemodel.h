/***************************************************************************
 *                                                                         *
 *   Copyright (C) 2018 by eapil                                           *
 *   http://www.eapil.com/index.html                                       *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#ifndef FILEMODEL_H
#define FILEMODEL_H

#include <QFileSystemModel>
#include <QUrl>
#include <QDateTime>

class FileModel : public QFileSystemModel
{
    Q_OBJECT
    Q_PROPERTY(QString dirPath READ getDirPath WRITE setDirPath NOTIFY dirPathChanged )
    Q_PROPERTY(QModelIndex rootIndex READ getRootIndex NOTIFY dirPathChanged )

public:
    explicit FileModel(QObject *parent = nullptr);
    ~FileModel();

    enum Roles  {
        SizeRole = Qt::UserRole + 4,
        LastModifiedRole = Qt::UserRole + 6,
        UrlStringRole = Qt::UserRole + 7,
        DirStringRole
    };

    Q_ENUM(Roles)

    QString getDirPath(){
        return rootPath();
    }

    void setDirPath(const QString &new_path);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;

    QHash<int,QByteArray> roleNames() const Q_DECL_OVERRIDE
    {
         QHash<int, QByteArray> result = QFileSystemModel::roleNames();
         result.insert(SizeRole, QByteArrayLiteral("size"));
         result.insert(LastModifiedRole, QByteArrayLiteral("lastModified"));
         return result;
    }

    static QString sizeString(const QFileInfo &fi);

    QModelIndex getRootIndex(){
        return index(getDirPath());
    }

Q_SIGNALS:
    void dirPathChanged();
    void rootIndexChanged();

public slots:
};

#endif // FILEMODEL_H
