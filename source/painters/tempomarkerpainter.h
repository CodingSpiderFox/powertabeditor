/*
  * Copyright (C) 2011 Cameron White
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
  
#ifndef TEMPOMARKERPAINTER_H
#define TEMPOMARKERPAINTER_H

#include "painterbase.h"

#include <boost/shared_ptr.hpp>
#include <QFont>
#include <QStaticText>

class TempoMarker;

class TempoMarkerPainter : public PainterBase
{
public:
    TempoMarkerPainter(boost::shared_ptr<const TempoMarker> tempoMarker);

    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);

private:
    boost::shared_ptr<const TempoMarker> tempoMarker;
    QFont displayFont;
    QStaticText displayText;
    QRectF beatTypeRect;

    QString getBeatTypeImage() const;

    static const int HEIGHT_OFFSET = 2;
};

#endif // TEMPOMARKERPAINTER_H
