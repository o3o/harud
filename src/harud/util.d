/**
 * This module contains some common utilities used by harud
 */
module harud.util;

import harud.doc : Doc;
import harud.font : Font;
import harud.types : Rect, HaruCMYKColor;

/**
 * Creates a rectangle starting from the top left corner.
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
Rect createTopLeftRect(float xLeft, float yTop, float width, float height) {
   return Rect(xLeft, yTop - height, xLeft + width, yTop);
}

unittest {
   Rect r = createTopLeftRect(25, 500, 150, 50);
   assert(r.left == 25);
   assert(r.top == 500);
   assert(r.right == 25 + 150);
   assert(r.bottom == 500 - 50);
}

/**
 * Creates a rectangle with the pdf convention.
 *
 * When describing a rectangle in PDF syntax, an array of four numbers is used.
 * The order of the numbers is: left, bottom, width, height.
 *
 *
 * Params:
 *  xLeft = X coordinates of left up corner
 *  yBottom = Y coordinates of left bottom corner
 *  width = Width of rectangle
 *  height = Height of rectangle
 *
 * Examples:
 * --------------------
 *             width
 *         +----------+
 *         |          | height
 *         *----------+
 * (left, bottom)
 * --------------------
 */
Rect createPdfRect(float xLeft, float yBottom, float width, float height) {
   return Rect(xLeft, yBottom, xLeft + width, yBottom + height);
}

unittest {
   Rect r = createPdfRect(25, 200, 150, 50);
   assert(r.left == 25);
   assert(r.bottom == 200);
   assert(r.right == 25 + 150);
   assert(r.top == 200 + 50);
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

enum MaterializeColor {
   red
}

HaruCMYKColor getColor(string c)() {
   switch (c) {
      case "red":
         return HaruCMYKColor(0, 0.73, 0.78, 0.04);
      case "pink":
         return HaruCMYKColor(0, 0.87, 0.58, 0.09); //#e91e63":
      case "purple":
         return HaruCMYKColor(0.11, 0.78, 0., 0.31); //#9c27b0":
      case "grey":
         return HaruCMYKColor(0., 0., 0., 0.38);
      case "grey-lighten-5":
         return HaruCMYKColor(0., 0., 0., 0.02);
      case "grey-lighten-4":
         return HaruCMYKColor(0., 0., 0., 0.04);
      case "grey-lighten-3":
         return HaruCMYKColor(0., 0., 0., 0.07);
      case "grey-lighten-2":
         return HaruCMYKColor(0., 0., 0., 0.12);
      case "grey-lighten-1":
         return HaruCMYKColor(0., 0., 0., 0.26);
      case "grey-darken-1":
         return HaruCMYKColor(0., 0., 0., 0.54);
      case "grey-darken-2":
         return HaruCMYKColor(0., 0., 0., 0.62);
      case "grey-darken-3":
         return HaruCMYKColor(0., 0., 0., 0.74);
      case "grey-darken-4":
         return HaruCMYKColor(0., 0., 0., 0.87);
      case "blue":
         return HaruCMYKColor(0.86, 0.71, 0.0, 0.05); //#2196F3,
      case "blue-lighten-5":
         return HaruCMYKColor(0.10, 0.04, 0.0, 0.01); //#E3F2FD,
      case "blue-lighten-4":
         return HaruCMYKColor(0.25, 0.12, 0.0, 0.02); //#BBDEFB,
      case "blue-lighten-3":
         return HaruCMYKColor(0.42, 0.19, 0.0, 0.02); //#90CAF9,
      case "blue-lighten-2":
         return HaruCMYKColor(0.59, 0.26, 0.0, 0.04); //#64B5F6,
      case "blue-lighten-1":
         return HaruCMYKColor(0.73, 0.33, 0.0, 0.04); //#42A5F5,
      case "blue-darken-1":
         return HaruCMYKColor(0.87, 0.41, 0.0, 0.10); //#1E88E5,
      case "blue-darken-2":
         return HaruCMYKColor(0.88, 0.44, 0.0, 0.18); //#1976D2,
      case "blue-darken-3":
         return HaruCMYKColor(0.89, 0.47, 0.0, 0.25); //#1565C0,
      case "blue-darken-4":
         return HaruCMYKColor(0.92, 0.56, 0.0, 0.37); //#0D47A1,
      case "blue-accent-1":
         return HaruCMYKColor(0.49, 0.31, 0.0, 0.0); //#82B1FF,
      case "blue-accent-2":
         return HaruCMYKColor(0.73, 0.46, 0.0, 0.0); //#448AFF
      case "blue-accent-3":
         return HaruCMYKColor(0.85, 0.53, 0.0, 0.0); //#2979FF
      case "blue-accent-4":
         return HaruCMYKColor(0.84, 0.62, 0.0, 0.0); //#2962FF

      default:
         assert(false);
   }
}

unittest {
   assert(getColor!("red").yellow == cast(float)0.78);
   assert(getColor!("grey-darken-2").key == cast(float)0.62);
}
