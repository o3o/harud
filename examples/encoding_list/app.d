import std.stdio;
import std.conv;
import std.string;

import harud;
import harud.c;


enum int PAGE_WIDTH = 420;
enum int PAGE_HEIGHT = 400;
enum int CELL_WIDTH = 20;
enum int CELL_HEIGHT = 20;
enum int CELL_HEADER = 10;

void main() {
   Doc pdf = new Doc();
   pdf.setCompressionMode(CompressionMode.all);
   pdf.pageMode = PageMode.useOutline;

   Font helvetica = pdf.getFont("Helvetica"); 
   string font_name 
      = pdf.loadType1FontFromFile("type1/a010013l.afm", "type1/a010013l.pfb"); 

   Outline root = pdf.createOutline("Encoding list");
   root.setOpened(true);

   string[] encodings = [
      "StandardEncoding",
      "MacRomanEncoding",
      "WinAnsiEncoding",
      "ISO8859-2",
      "ISO8859-3",
      "ISO8859-4",
      "ISO8859-5",
      "ISO8859-9",
      "ISO8859-10",
      "ISO8859-13",
      "ISO8859-14",
      "ISO8859-15",
      "ISO8859-16",
      "CP1250",
      "CP1251",
      "CP1252",
      "CP1254",
      "CP1257",
      "KOI8-R",
      "Symbol-Set",
      "ZapfDingbats-Set",
      ];


   foreach (enc; encodings) {
      Page page = pdf.addPage(); /// Add a new page to the document
      page.width = PAGE_WIDTH;
      page.height = PAGE_HEIGHT;

      Outline outline = pdf.createOutline(enc, root);

      Destination dest = page.createDestination();
      dest.setXYZ(0, page.height, 1);
      outline.setDestination(dest);
      page.setFontAndSize(helvetica, 15);
      drawGraph(page);

      page.beginText();
      page.setFontAndSize(helvetica, 20);
      page.moveTextPos (40, PAGE_HEIGHT - 50);
      page.showText(enc);
      page.showText(" Encoding");
      page.endText();

      Font font2;
      if (enc == "Symbol-Set") {
         font2 = pdf.getFont("Symbol");
      } else if (enc == "ZapfDingbats-Set") {
         font2 = pdf.getFont("ZapfDingbats");
      } else {
         font2 = pdf.getFont(font_name, enc);
      }
      page.setFontAndSize(font2, 14);
      drawFonts(page);
   }
   pdf.saveToFile("./encoding_list.pdf");
}

void drawGraph(Page page) {
   string buf;
   int i;

   /* Draw 16 X 15 cells */

   /* Draw vertical lines. */
   page.lineWidth = 0.5f;

   for (i = 0; i <= 17; i++) {
      int x = i * CELL_WIDTH + 40;

      page.moveTo(x, PAGE_HEIGHT - 60);
      page.lineTo(x, 40);
      page.stroke();

      if (i > 0 && i <= 16) {
         page.beginText();
         page.moveTextPos(x + 5, PAGE_HEIGHT - 75);
         buf = format("%X", i - 1); 

         page.showText(buf);
         page.endText();
      }
   }

   /* Draw horizontal lines. */
   for (i = 0; i <= 15; i++) {
      int y = i * CELL_HEIGHT + 40;

      page.moveTo(40, y);
      page.lineTo(PAGE_WIDTH - 40, y);
      page.stroke();

      if (i < 14) {
         page.beginText();
         page.moveTextPos(45, y + 5);
         buf = format("%X", 15 - i); 
         page.showText(buf);
         page.endText();
      }
   }
}

void drawFonts(Page page) {
   int i;
   int j;

   page.beginText();

   /* Draw all character from 0x20 to 0xFF to the canvas. */
   for (i = 1; i < 17; i++) {
      for (j = 1; j < 17; j++) {
         int y = PAGE_HEIGHT - 55 - ((i - 1) * CELL_HEIGHT);
         int x = j * CELL_WIDTH + 50;

         char buf[2];
         buf[1] = 0x00;
         buf[0] = to!(char)((i - 1) * 16 + (j - 1));
         if (buf[0] >= 32) {
            double d;
            string s = to!string(buf);
            d  = x - page.textWidth(s) / 2;
            page.textOut(d, y, s);
         }
      }
   }

   page.endText();
}

