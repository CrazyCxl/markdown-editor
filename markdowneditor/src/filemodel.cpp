#include "filemodel.h"

FileModel::FileModel(QWidget *parent) : QFileSystemModel(parent)
{

}

QVariant FileModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && role >= SizeRole) {
        switch (role) {
        case SizeRole:
//            return QVariant(sizeString(fileInfo(index)));
        case DisplayableFilePermissionsRole:
//            return QVariant(permissionString(fileInfo(index)));
        case LastModifiedRole:
//            return QVariant(fileInfo(index).lastModified().toString(Qt::SystemLocaleShortDate));
        case UrlStringRole:
//            return QVariant(QUrl::fromLocalFile(filePath(index)).toString());
        default:
            break;
        }
    }
    return QFileSystemModel::data(index, role);
}

QHash<int, QByteArray> FileModel::roleNames() const
{
     QHash<int, QByteArray> result = QFileSystemModel::roleNames();
     result.insert(SizeRole, QByteArrayLiteral("size"));
     result.insert(DisplayableFilePermissionsRole, QByteArrayLiteral("displayableFilePermissions"));
     result.insert(LastModifiedRole, QByteArrayLiteral("lastModified"));
     return result;
}

