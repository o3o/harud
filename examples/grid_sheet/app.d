import std.stdio;
import std.conv;

import harud;
import harud.c;

void main() {
   void errorCallback(uint error_number, uint detail_number) {
      writefln("err %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number),
            detail_number);
   }

   Doc pdf = new Doc(&errorCallback);
   Font helvetica = pdf.getFont("Helvetica");

   Page page = pdf.addPage();

   /// Set the current font and size for the page
   page.setFontAndSize(helvetica, 10);
   page.setSize(PageSizes.A4, PageDirection.portrait);
   printGrid(page);
   pdf.saveToFile("./grid_sheet.pdf"); /// Write to disk
}

void printGrid(Page page) {
   float height = page.height();
   writeln("h:", height);
   float width = page.width();
   uint x, y;

   //page.setGrayFill(0.5);
   page.grayStroke= 0.8;
   y = 0;
   while (y < height) {
      setLineWidth(page, y);
      page.moveTo(0, y);
      page.lineTo(width, y);
      page.stroke();

      if (y % 10 == 0 && y > 0) {
         page.grayStroke = 0.5;

         page.moveTo(0, y);
         page.lineTo(25, y);
         page.stroke();

         page.grayStroke = 0.8;
      }
      y += 5;
   }
   /* Draw virtical lines */
   x = 0;
   while (x < width) {
      page.setLineWidth(x);

      page.moveTo(x, 0);
      page.lineTo(x, height);
      page.stroke();

      if (x % 50 == 0 && x > 0) {
         page.grayStroke = 0.5;

         page.moveTo(x, 0);
         page.lineTo(x, 5);
         page.stroke();

         page.moveTo(x, height);
         page.lineTo(x, height - 25);
         page.stroke();

         page.grayStroke = 0.8;
      }

      x += 5;
   }

   /* Draw horizontal text */
   y = 0;
   while (y < height) {
      if (y % 10 == 0 && y > 0) {
         page.beginText();
         page.moveTextPos(25, y - 2);

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
         page.moveTextPos(x, height - 30);
         page.showText(to!string(x));
         page.endText();
      }
      x += 5;
   }

   page.grayFill = 0;
   page.grayStroke = 0;
}

private void setLineWidth(Page page, double y) {
   if (y % 10 == 0)
      page.lineWidth = 0.5;
   else {
      if (page.lineWidth != 0.25) {
         page.lineWidth = 0.25;
      }
   }
}
