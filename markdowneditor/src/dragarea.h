/***************************************************************************
 *                                                                         *
 *   author cxl                                                            *
 *                                                                         *
 ***************************************************************************/


#ifndef DRAPAREA_H
#define DRAPAREA_H

#include <QQuickItem>

class DragArea : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool acceptingDrops READ isAcceptingDrops WRITE setAcceptingDrops NOTIFY acceptingDropsChanged)

public:
    DragArea(QQuickItem *parent=nullptr);
    bool isAcceptingDrops() const { return m_accepting; }
    void setAcceptingDrops(bool accepting);

signals:
    void textDrop(QString text);
    void fileDrop(QString file_path);
    void acceptingDropsChanged();

protected:
    void dragEnterEvent(QDragEnterEvent *event);
    void dragLeaveEvent(QDragLeaveEvent *event);
    void dropEvent(QDropEvent *event);

private:
    bool m_accepting;

};

#endif // DRAPAREA_H
