module harud.util;

import harud.doc : Doc;
import harud.font : Font;
import harud.types : Rect;

/**
 * Creates a rectangle.
 *
 * Params:
 *  xLeft = X coordinates of left up corner
 *  yTop = Y coordinates of left up corner
 *  width = Width of rectangle
 *  height = Height of rectangle
 *
 * Examples:
 * --------------------
 * (x, y)
 *    *----------+
 *    |          | height
 *    +----------+
 *       width
 * --------------------
 */
Rect createRect(float xLeft, float yTop, float width, float height) {
   return Rect(xLeft, yTop - height, xLeft + width, yTop);
}

unittest {
   Rect r = createRect(25, 500, 150, 50);
   assert(r.left == 25);
   assert(r.top == 500);
   assert(r.right == 25 + 150);
   assert(r.bottom == 500 - 50);
}

Font getFont(Doc pdf, StandardFont font) {
   final switch (font) with (StandardFont) {
      case courier:
         return pdf.getFont("Courier");
      case courierBold:
         return pdf.getFont("Courier-Bold");
      case courierOblique:
         return pdf.getFont("Courier-Oblique");
      case courierBoldOblique:
         return pdf.getFont("Courier-BoldOblique");
      case helvetica:
         return pdf.getFont("Helvetica");
      case helveticaBold:
         return pdf.getFont("Helvetica-Bold");
      case helveticaOblique:
         return pdf.getFont("Helvetica-Oblique");
      case helveticaBoldOblique:
         return pdf.getFont("Helvetica-BoldOblique");
      case timesRoman:
         return pdf.getFont("Times-Roman");
      case timesBold:
         return pdf.getFont("Times-Bold");
      case timesItalic:
         return pdf.getFont("Times-Italic");
      case timesBoldItalic:
         return pdf.getFont("Times-BoldItalic");
      case symbol:
         return pdf.getFont("Symbol");
      case zapfDingbats:
         return pdf.getFont("ZapfDingbats");

   }
}

enum StandardFont {
   courier,
   courierBold,
   courierOblique,
   courierBoldOblique,
   helvetica,
   helveticaBold,
   helveticaOblique,
   helveticaBoldOblique,
   timesRoman,
   timesBold,
   timesItalic,
   timesBoldItalic,
   symbol,
   zapfDingbats
}
