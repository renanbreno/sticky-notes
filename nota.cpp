#include "nota.h"

Nota::Nota()
{

}

Nota::Nota(const QString &title, const QString &author, const QString &text, const QString &date, const QString &color)
{
    this->title = title;
    this->author = author;
    this->text = text;
    this->date = date;
    this->color = color;
}
