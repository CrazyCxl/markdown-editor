#include "filemodel.h"
#include "utils.h"

#include <QUrl>
#include <QDateTime>
#include <QDir>
#include <QDebug>
#include <QVariant>

FileModel::FileModel(QObject *parent) : QFileSystemModel(parent)
{
    setDirPath( Utils::getSettingsValue(VARIABLE_SETTINGS_GROUP,"selectDir",
                                        QVariant::fromValue(QDir::currentPath())).toString() );
    connect(this,&FileModel::rootPathChanged,[this](QString){
        emit dirPathChanged();
    });
}

FileModel::~FileModel()
{
    Utils::setSettingsValue(VARIABLE_SETTINGS_GROUP,"selectDir",QVariant::fromValue(getDirPath()));
}

void FileModel::setDirPath(const QString &new_path)
{
    qInfo()<<"set dir path "<<new_path;
    const QString filter = "file:///";

    QString path = new_path;
    if(new_path.startsWith(filter)){
        path = path.remove(0,filter.length());
    }

    setRootPath(path);
    emit rootIndexChanged();
}

QVariant FileModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && role >= SizeRole) {
        switch (role) {
        case SizeRole:
            return QVariant(sizeString(fileInfo(index)));
        case LastModifiedRole:
            return QVariant(fileInfo(index).lastModified().toString(Qt::SystemLocaleShortDate));
        case UrlStringRole:
            return QVariant(QUrl::fromLocalFile(filePath(index)).toString());
        case DirStringRole:{
            QString dir_str;

            if(isDir(index)){
                dir_str = filePath(index);
            }else{
                dir_str = fileInfo(index).absoluteDir().absolutePath();
            }

            return QVariant(QUrl::fromLocalFile(dir_str).toString());
        }
        case BaseNameStringRole:{
            QString base_name = fileInfo(index).baseName();
            if(base_name.isEmpty()){
                base_name = fileInfo(index).fileName();
            }
            return QVariant(base_name);
        }
        case IsDirRole:
            return QVariant(fileInfo(index).isDir());
        case IsMarkdownFileRole:
            return QVariant(fileInfo(index).suffix() == "md");
        default:
            break;
        }
    }
    return QFileSystemModel::data(index, role);
}

QString FileModel::sizeString(const QFileInfo &fi)
{
    if (!fi.isFile())
        return QString();
    const qint64 size = fi.size();
    if (size > 1024 * 1024 * 1024)
        return QString::number(size / (1024 * 1024 *1024)) + 'G';
    if (size > 1024 * 1024)
        return QString::number(size / (1024 * 1024)) + 'M';
    if (size > 1024)
        return QString::number(size / 1024) +'K';
    return QString::number(size)+ 'B';
}

