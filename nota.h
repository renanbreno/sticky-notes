#ifndef FRUTA_H
#define FRUTA_H
#include <QString>

class Nota
{
public:
    Nota();
    Nota(const QString& title, const QString& author, const QString& text, const QString& date, const QString& color);
    QString title;
    QString author;
    QString text;
    QString date;
    QString color;
};

#endif // FRUTA_H
