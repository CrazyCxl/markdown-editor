#ifndef FILEMODEL_H
#define FILEMODEL_H

#include <QWidget>
#include <QFileSystemModel>

class FileModel : public QFileSystemModel
{
    Q_OBJECT
public:
    explicit FileModel(QWidget *parent = nullptr);

    enum Roles  {
        SizeRole = Qt::UserRole + 4,
        DisplayableFilePermissionsRole = Qt::UserRole + 5,
        LastModifiedRole = Qt::UserRole + 6,
        UrlStringRole = Qt::UserRole + 7
    };
    Q_ENUM(Roles)

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;

    QHash<int,QByteArray> roleNames() const Q_DECL_OVERRIDE;
};

#endif // FILEMODEL_H
