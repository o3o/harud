/**
 * Table support
 */
module harud.table;

import harud.page: Page;
import harud.types: Rect, HaruTextAlignment, HaruCMYKColor;


/**
 * Describe a table.
 *
 * A `Table` is a layout element that represents data in a two-dimensional grid
 */
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
   /**
    * Add a [Column] to table.
    */
   void addCol(Column col) {
      import harud.extension: addTextRect, addRect, setFillColor, setStrokeColor;
      import harud.util: createTopLeftRect;

      drawBorder(col);
      fillCell(col);

      page.beginText;
      float w = col.colSpan * _divSize;
      Rect r = createTopLeftRect(x + col.paddingLeft, y - col.paddingBottom, w - col.paddingLeft - col.paddingRight, currentHeight - col.paddingTop - col.paddingBottom);
      page.addTextRect(r, col.text, col.alignment);
      page.endText;

      x += col.colSpan * _divSize;
   }

   private void fillCell(Column col) {
      import harud.extension: addRect, setFillColor, setStrokeColor;
      import harud.util: createTopLeftRect;

      page.graphicSave();

      page.setFillColor(col.fillColor);
      Rect border = createTopLeftRect(x, y, col.colSpan * _divSize, currentHeight);
      page.addRect(border);
      page.fill;

      page.graphicRestore;
  }

   private void drawBorder(Column col) {
      import std.stdio;
      import harud.extension: addTextRect, addRect, setFillColor, setStrokeColor;

      page.graphicSave();

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

      page.graphicRestore;
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

/**
 * Describes a table colums (cell).
 *
 * Table divide horizontal space into indivisible units called "columns".
 * All columns in a table must specify their width as proportion of the total available row width.
 * harud uses 12 columns
 */
struct Column {
   /**
    * Specifies the column width
    */
   int colSpan;
   /**
    * Text
    */
   string text;
   HaruTextAlignment alignment = HaruTextAlignment.left;
   CellBorder border = CellBorder.none;

   /// padding left
   float paddingLeft    = 0;
   /// padding top
   float paddingTop     = 0;
   /// padding right
   float paddingRight   = 0;
   /// padding bottom
   float paddingBottom  = 0;

   HaruCMYKColor fillColor = HaruCMYKColor(0, 0, 0, 0); // white
   HaruCMYKColor borderColor = HaruCMYKColor(0, 0, 0, 1); // black
}

/**
 * Cell border
 */
enum CellBorder {
   none = 0x0,
   top = 0x01,
   right = 0x02,
   bottom = 0x04,
   left = 0x08,
   all = 0x0F
}
