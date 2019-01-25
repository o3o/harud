/**
 *
 * Uniform Function Call Syntax (UFCS) extensions
 *
 */
module harud.extension;

import harud.page : Page;
import harud.types : Rect, HaruTextAlignment, HaruCMYKColor;

uint addRect(Page page, Rect rect) {
   return page.rectangle(rect.left, rect.bottom, rect.right - rect.left, rect.top - rect.bottom);
}

uint addTextRect(Page page, Rect rect, string text, HaruTextAlignment alignment) {
   uint len;
   page.textRect(rect.left, rect.top, rect.right, rect.bottom, text, alignment, &len);
   return len;
}

uint setFillColor(Page page, HaruCMYKColor color) {
   if (color.isValidCMYKColor) {
      return page.setCMYKFill(color.cyan, color.magenta, color.yellow, color.key);
   } else {
      return -1;
   }
}

uint setStrokeColor(Page page, HaruCMYKColor color) {
   if (color.isValidCMYKColor) {
      return page.setCMYKStroke(color.cyan, color.magenta, color.yellow, color.key);
   } else {
      return -1;
   }
}

bool isValidCMYKColor(HaruCMYKColor color) {
   import std.math;
   return !color.cyan.isNaN && !color.magenta.isNaN && !color.yellow.isNaN && !color.key.isNaN && color.cyan >= 0
      && color.magenta >= 0 && color.yellow >= 0 && color.key >= 0 && color.cyan <= 1 && color.magenta <= 1
      && color.yellow <= 1 && color.key <= 1;
}

unittest {
   HaruCMYKColor color;
   assert(!color.isValidCMYKColor);
   HaruCMYKColor fillColor = HaruCMYKColor(0, 0, 0, 0);
   assert(fillColor.isValidCMYKColor);
}
