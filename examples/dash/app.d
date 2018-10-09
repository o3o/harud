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


   try {
      Doc pdf = new Doc(&errorCallback);
      Font helvetica = pdf.getFont("Helvetica");

      Page page = pdf.addPage();
      page.rectangle(0, 0, 100, 100);
      page.rectangle(100, 100, 100, 100);
      page.stroke();

      auto status = page.setFontAndSize(helvetica, 10);

      /* Line dash pattern */
      testLineDashPattern(page);

      pdf.saveToFile("./dash.pdf");
   } catch (Exception exc) {
      writeln(exc);
   }
}

private void testLineDashPattern(Page page) {
   /* Line dash pattern */
   page.setLineWidth(1.0);

   enum ushort[] NN = [0, 0, 0, 0, 0, 0, 0, 0];
   enum ushort[] DASH_MODE1 = [3];
   enum ushort[] DASH_MODE2 = [3, 7];
   enum ushort[] DASH_MODE3 = [8, 7, 2, 7];
   enum ushort[] DOTTED = [2];
   enum ushort[] DASH_DASH_DOT = [2,2,2,2,8,2];
   enum ushort[] DASH_DOT = [2,2,8,2];
   enum ushort[] DASHED = [4];

   page.setDash(DASH_MODE1, 1);
   drawLine(page, 60, 680, "dash=[3], phase=1 -- 2 on, 3 off, 3 on...");

   page.setDash(DASH_MODE2,  2);
   drawLine(page, 60, 650, "dash=[7, 3], phase=2 -- 5 on 3 off, 7 on,...");

   page.setDash(DASH_MODE3, 0);
   drawLine(page, 60, 620, "dash=[8, 7, 2, 7], phase=0");

   page.setDash(DOTTED,  0);
   drawLine(page, 60, 590, "dash=[2], phase=0");

   page.setDash(DASH_DASH_DOT, 0);
   drawLine(page, 60, 560, "[2,2,2,2,8,2]");

   page.setDash(DASH_DASH_DOT, 5);
   drawLine(page, 300, 560, "[2,2,2,2,8,2] fase=4");

   page.setDash(DASH_DOT, 0);
   drawLine(page, 60, 530, "[2,2,8,2]");

   page.setDash(DASHED, 0);
   drawLine(page, 60, 500, "[4]");


   page.setDashDashDot();
   drawLine(page, 60,470, "DASH_DASH_DOT");

   page.setDashDot();
   drawLine(page, 60, 440, "DASH_DOT");

   page.setDashed();
   drawLine(page, 60, 410, "DASHED");
   page.setDotted();
   drawLine(page, 60, 380, "DOTTED");

   page.setSolid();
   drawLine(page, 60, 350, "SOLID");
}

void drawLine(Page page, float x, float y, string label) {
   page.beginText();
   page.moveTextPos(x, y - 10);
   page.showText(label);
   page.endText();

   page.moveTo(x, y - 15);
   page.lineTo(x + 220, y - 15);
   page.stroke();
}
