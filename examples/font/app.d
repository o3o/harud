import std.stdio;

import harud;
import harud.c;

void main() {
   void  errorCallback(uint error_number, uint detail_number) {
      writefln("err %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number),
            detail_number);
   }

   string[] fontList = [
      "Courier",
      "Courier-Bold",
      "Courier-Oblique",
      "Courier-BoldOblique",
      "Helvetica",
      "Helvetica-Bold",
      "Helvetica-Oblique",
      "Helvetica-BoldOblique",
      "Times-Roman",
      "Times-Bold",
      "Times-Italic",
      "Times-BoldItalic",
      "Symbol",
      "ZapfDingbats"
         ];
   writeln("libhpdf-", getVersion());

   try {
      enum string TITLE = "FontDemo";

      Doc pdf = new Doc(&errorCallback);
      Page page = pdf.addPage();

      float height = page.height;
      float width = page.width;
      /* Print the lines of the page. */
      page.lineWidth = 1;
      page.rectangle(50, 50, width - 100, height - 110);
      page.stroke();

      /* Print the title of the page (with positioning center). */
      Font helvetica = pdf.getFont("Helvetica");
      page.setFontAndSize(helvetica, 24);

      float tw = page.getTextWidth(TITLE);
      page.beginText();
      page.textOut((width - tw) / 2, height - 50, TITLE);
      page.endText();

      /* output subtitle. */
      page.beginText();
      page.setFontAndSize(helvetica, 16);
      page.textOut(60, height - 80, "<Standerd Type1 fonts samples>");
      page.endText();

      page.beginText();
      page.moveTextPos(60, height - 105);

      for (int i = 0; i < fontList.length -1 ; i++) {
         enum string samp_text = "abcdefgABCDEFG12345!#$%&+-@?";
         Font font = pdf.getFont(fontList[i]);

         /* print a label of text */
         page.setFontAndSize(helvetica, 9);
         page.showText(fontList[i]);
         page.moveTextPos(0, -18);

         /* print a sample text. */
         page.setFontAndSize(font, 20);
         page.showText(samp_text);
         page.moveTextPos(0, -20);
      }
      pdf.useCNSFonts();
      pdf.useCNSEncodings();
      page.setFontAndSize(helvetica, 9);
      page.showText("simsun");
      page.moveTextPos(0, -18);

      Font cfont = pdf.getFont("SimSun", "GB-EUC-H");
      page.setFontAndSize(cfont, 20);
      page.showText("奥菲欧");

      page.endText();

      pdf.saveToFile("./font.pdf");
   } catch (Exception exc) {
      writeln(exc);
   }
}
