/***************************************************************************
 *                                                                         *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#include "dragarea.h"
#include <QMimeData>
#include <QCursor>
#include <QDir>

DragArea::DragArea(QQuickItem *parent)
    : QQuickItem(parent),
    m_accepting(true)
{
    setAcceptedMouseButtons(Qt::AllButtons);
    setFlag(QQuickItem::ItemAcceptsDrops, m_accepting);
}

void DragArea::dragEnterEvent(QDragEnterEvent *event)
{
    event->acceptProposedAction();
    setCursor(Qt::DragMoveCursor);
}

void DragArea::dragLeaveEvent(QDragLeaveEvent *event)
{
    Q_UNUSED(event)
    unsetCursor();
}

void DragArea::dropEvent(QDropEvent *event)
{
    qInfo()<<Q_FUNC_INFO;
    if (event->mimeData()->hasUrls())
    {
        QList<QUrl> urlList = event->mimeData()->urls();
        emit fileDrop(urlList.first().toLocalFile());
    }else if(event->mimeData()->hasText()){
        emit textDrop(event->mimeData()->text());
    }

    unsetCursor();
}

void DragArea::setAcceptingDrops(bool accepting)
{
    qInfo()<<Q_FUNC_INFO;
    if (accepting == m_accepting)
                return;

    m_accepting = accepting;
    setFlag(QQuickItem::ItemAcceptsDrops, m_accepting);
    emit acceptingDropsChanged();
}
