import std.stdio;
import std.conv;

import harud;
import harud.c;

void main() {
   void  errorCallback(uint error_number, uint detail_number) {
      writefln("err %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number), 
            detail_number);
   }

   Doc pdf = new Doc(&errorCallback);   ///  New pdf document
   HaruFont helvetica = pdf.getFont("Helvetica"); 

   Page page = pdf.addPage(); /// Add a new page to the document

   page.setFontAndSize(helvetica, 5);   /// Set the current font and size for the page
   page.setSize(PageSizes.A4, PageDirection.portrait);
   printGrid(page);
   pdf.saveToFile("./grid_sheet.pdf"); /// Write to disk
}

void printGrid(Page page) {
   HPDF_REAL height = page.getHeight();
   HPDF_REAL width = page.getWidth();
   HPDF_UINT x, y;

   //page.setGrayFill(0.5);
   //page.setGrayStroke(0.8);
   y = 0;
   while (y < height) {
      page.setWidth(y);

      page.moveTo(0, y);
      page.lineTo(width, y);
      page.stroke();

      if (y % 10 == 0 && y > 0) {
         page.setGrayStroke(0.5);

         page.moveTo(0, y);
         page.lineTo(5, y);
         page.stroke();

         page.setGrayStroke(0.8);
      }
      y += 5;
   }
   /* Draw virtical lines */
   x = 0;
   while (x < width) {
      page.setWidth(x);

      page.moveTo(x, 0);
      page.lineTo(x, height);
      page.stroke();

      if (x % 50 == 0 && x > 0) {
         page.setGrayStroke(0.5);

         page.moveTo(x, 0);
         page.lineTo(x, 5);
         page.stroke();

         page.moveTo( x, height);
         page.lineTo( x, height - 5);
         page.stroke();

         page.setGrayStroke(0.8);
      }

      x += 5;
   }

   /* Draw horizontal text */
   y = 0;
   while (y < height) {
      if (y % 10 == 0 && y > 0) {
         page.beginText();
         page.moveTextPos(5, y - 2);

         page.showText(to!string(y));
         page.endText;
      }

      y += 5;
   }


   /* Draw virtical text */
   x = 0;
   while (x < width) {
      if (x % 50 == 0 && x > 0) {
         page.beginText();
         page.moveTextPos(x, 5);
         page.showText(to!string(x));
         page.endText;

         page.beginText;
         page.moveTextPos(x, height - 10);
         page.showText(to!string(x));
         page.endText();
      }
      x += 5;
   }

   page.setGrayFill(0);
   page.setGrayStroke(0);
}

private void setWidth(Page page, double y) {
   if (y % 10 == 0)
      page.setLineWidth(0.5);
   else {
      if (page.getLineWidth != 0.25) {
         page.setLineWidth(0.25);
      }
   }
}
