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

      page.drawBorder();
      auto status = page.setFontAndSize(helvetica, 10);

      /* Draw verious widths of lines. */
      page.setLineWidth( 0);
      page.drawLine( 60, 770, "line width = 0");

      page.setLineWidth(1.0);
      page.drawLine(60, 740, "line width = 1.0");

      page.setLineWidth(2.0);
      page.drawLine(60, 710, "line width = 2.0");


      /* set big green line */
      page.setLineWidth(30);
      page.setRGBStroke(0.0, 0.5, 0.0);

      /* Line Cap Style */
      page.setLineCap( HaruLineCap.buttEnd);
      drawLine2(page, 60, 570, "PDF_BUTT_END");

      page.setLineCap(HaruLineCap.roundEnd);
      drawLine2(page, 60, 505, "PDF_ROUND_END");

      page.setLineCap(HaruLineCap.projectingScuareEnd);
      drawLine2(page, 60, 440, "PDF_PROJECTING_SCUARE_END");

      page.setLineWidth(30);
      page.setRGBStroke(0.0, 0.5, 0.0);

      /* Line dash pattern */
         testLineDashPattern(page);

      /* Line Join Style */
      page.setLineWidth(30);
      page.setRGBStroke(0.0, 0.0, 0.5);

      page.setLineJoin(HaruLineJoin.miterJoin);
      page.drawHat(120, 300);

      page.beginText();
      page.moveTextPos(60, 360);
      page.showText("PDF_MITER_JOIN");
      page.endText();

      page.setLineJoin(HaruLineJoin.roundJoin);
      writeln("LJ ", page.getLineJoin);

      page.drawHat(120, 195);

      page.beginText();
      page.moveTextPos(60, 255);
      page.showText("PDF_ROUND_JOIN");
      page.endText();


      page.setLineJoin(HaruLineJoin.bevelJoin);
      page.drawHat(120, 90);

      page.beginText();
      page.moveTextPos(60, 150);
      page.showText("PDF_BEVEL_JOIN");
      page.endText();

      /* Draw Rectangle */
      page.setLineWidth(2);
      page.setRGBStroke(0, 0, 0);
      page.setRGBFill(0.75, 0.0, 0.0);

      drawRect(page, 300, 770, "Stroke");
      page.stroke;

      drawRect(page, 300, 720, "Fill");
      page.fill;

      drawRect(page, 300, 670, "Fill then Stroke");
      page.fillStroke;


      pdf.saveToFile("./line.pdf");
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

   page.setDash(DASH_MODE1, 1);

   drawLine(page, 60, 680, "dash_ptn=[3], phase=1 -- 2 on, 3 off, 3 on...");

   page.setDash(DASH_MODE2,  2);
   drawLine(page, 60, 650, "dash_ptn=[7, 3], phase=2 -- 5 on 3 off, 7 on,...");

   page.setDash(DASH_MODE3, 0);
   drawLine(page, 60, 620, "dash_ptn=[8, 7, 2, 7], phase=0");
   page.setSolid();
}

void drawBorder(Page page) {
   page.setLineWidth(1);
   page.rectangle(50, 50, page.getWidth - 100, page.getHeight - 110);
   page.stroke();
}

void drawHat(Page page, float x, float y) {
   page.moveTo(x, y);
   page.lineTo(x + 40, y + 40);
   page.lineTo(x + 40 * 2, y);
   page.stroke();
}

void drawLine(Page page, float x, float y, string label) {
   writeln(label);

   page.beginText();
   page.moveTextPos( x, y - 10);
   page.showText(label);
   page.endText();

   page.moveTo(x, y - 15);
   page.lineTo(x + 220, y - 15);
   page.stroke();
}

void drawLine2(Page page, float x, float y, string label) {
   page.beginText();
   page.moveTextPos(x, y);
   page.showText(label);
   page.endText();

   page.moveTo(x + 30, y - 25);
   page.lineTo(x + 160, y - 25);
   page.stroke();
}

void drawRect(Page page, float x, float y, string label) {
   page.beginText();
   page.moveTextPos(x, y - 10);
   page.showText(label);
   page.endText();
   page.rectangle(x, y - 40, 220, 25);
}

