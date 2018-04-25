#include "document.h"
#include <QFile>

Document::Document(QObject *parent)
    :QObject(parent)
{
}

void Document::setText(const QString &text)
{
    if (text == m_text)
        return;
    m_text = text;
    emit textChanged(m_text);
}
