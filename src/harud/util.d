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
 *  yTop = Y coordinates of left up corner
 *  width = Width of rectangle
 *  height = Height of rectangle
 *
 * Examples:
 * --------------------
 * (x, y)
 *    *----------+
 *    |          | height
 *    *----------+
 *       width
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
         case "#e91e63":
         return HaruCMYKColor(0, 0.87, 0.58, 0.09);
      case "purple":
         case "#9c27b0":
         return HaruCMYKColor(0.11, 0.78, 0., 0.31);

      case "grey":
         goto case;
      case "#9e9e9e":
         return HaruCMYKColor(0., 0., 0., 0.38);
      case "grey-lighten-5":
         goto case;
      case "#fafafa":
         return HaruCMYKColor(0., 0., 0., 0.02);
      case "grey-lighten-4":
         goto case;
      case "#f5f5f5":
         return HaruCMYKColor(0., 0., 0., 0.04);
      case "grey-lighten-3":
         goto case;
      case "#eeeeee":
         return HaruCMYKColor(0., 0., 0., 0.07);
      case "grey-lighten-2":
         goto case;
      case "#e0e0e0":
         return HaruCMYKColor(0., 0., 0., 0.12);
      case "grey-lighten-1":
         goto case;
      case "#bdbdbd":
         return HaruCMYKColor(0., 0., 0., 0.26);
      case "grey-darken-1":
         goto case;
      case "#757575":
         return HaruCMYKColor(0., 0., 0., 0.54);
      case "grey-darken-2":
         goto case;
      case "#616161":
         return HaruCMYKColor(0., 0., 0., 0.62);
      case "grey-darken-3":
         goto case;
      case "#424242":
         return HaruCMYKColor(0., 0., 0., 0.74);
      case "grey-darken-4":
         goto case;
      case "#212121":
         return HaruCMYKColor(0., 0., 0., 0.87);
      default:
         assert(false);
   }
}

unittest {
   assert(getColor!("red").yellow == cast(float)0.78);
   assert(getColor!("grey-darken-2").key == cast(float)0.62);
   assert(getColor!("#616161").key == cast(float)0.62);
}
