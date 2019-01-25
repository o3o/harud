module harud.table;

import harud.page: Page;
import harud.types: Rect, HaruTextAlignment, HaruCMYKColor;


class Table {
   private Page page;
   this(Page page, Rect rect) {
      assert(page !is null);
      this.page = page;
      x0 = x = rect.left;
      y0 = y = rect.top;
      width = rect.right - rect.left;
      height = rect.top - rect.bottom;
      _divSize = width / 12;
      currentHeight = 0.;
   }

   private float x0;
   private float y0;
   private float x;
   private float y;
   private float height;
   private float width;
   void addCol(Column col) {
      import harud.extension: addTextRect, addRect, setFillColor, setStrokeColor;
      import harud.util: createRect;

      float w = col.colSpan * _divSize;
      /+
      Rect r = createRect(x, y, w, currentRow.height);
      page.addRect(r);
      page.stroke;
      +/
      drawBorder(col);

      page.beginText;
      Rect r = createRect(x + col.paddingLeft, y - col.paddingTop, w - col.paddingTop - col.paddingRight, currentHeight - col.paddingTop - col.paddingBottom);
      page.addTextRect(r, col.text, col.alignment);
      page.endText;


      x += col.colSpan * _divSize;
   }

   private void fillCell(Column col) {
      import harud.extension: addTextRect, addRect, setFillColor, setStrokeColor;
      import harud.util: createRect;
      float w = col.colSpan * _divSize;

      HaruCMYKColor baseFill = page.getCMYKStroke();
      page.setFillColor(col.fillColor);
      Rect border = createRect(x, y, w, currentHeight);
      page.addRect(border);
      page.fill;
      page.setFillColor(baseFill);
  }

   private void drawBorder(Column col) {
      import std.stdio;
      import harud.extension: addTextRect, addRect, setFillColor, setStrokeColor;

      HaruCMYKColor baseStroke = page.getCMYKStroke();
      page.setStrokeColor(col.borderColor);
      float w = col.colSpan * _divSize;
      float h = currentHeight;
      if (col.border & CellBorder.top) {
         page.moveTo(x, y);
         page.lineTo(x + w, y);
      }
      if (col.border & CellBorder.right) {
         page.moveTo(x + w, y);
         page.lineTo(x + w, y - h);
      }
      if (col.border & CellBorder.bottom) {
         page.moveTo(x + w, y - h);
         page.lineTo(x, y - h);
      }
      if (col.border & CellBorder.left) {
         page.moveTo(x, y - h);
         page.lineTo(x, y);
      }
      page.moveTo(x, y);
      page.stroke;
      page.setStrokeColor(baseStroke);
   }

   private float currentHeight;
   void addRow(float height) {
      x = x0;
      y -= currentHeight;
      currentHeight = height;
   }

   private float _divSize;
   float divSize() {
      return _divSize;
   }
}

/+
struct Row {
   float height;
}
+/

struct Column {
   int colSpan;
   string text;
   HaruTextAlignment alignment = HaruTextAlignment.left;
   CellBorder border = CellBorder.none;

   float paddingLeft    = 0;
   float paddingTop     = 0;
   float paddingRight   = 0;
   float paddingBottom  = 0;

   //HaruCMYKColor fillColor = HaruCMYKColor(0, 0, 0, 0);
   //HaruCMYKColor borderColor = HaruCMYKColor(0, 0, 0, 0);
   HaruCMYKColor fillColor;
   HaruCMYKColor borderColor;
}

enum CellBorder {
   none = 0x0,
   top = 0x01,
   right = 0x02,
   bottom = 0x04,
   left = 0x08,
   all = 0x0F
}
