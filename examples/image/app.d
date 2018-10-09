import harud;
import std.conv;
import std.math;
import std.stdio;
import std.string;

void main() {
 void  errorCallback(uint error_number, uint detail_number) {
      writefln("err %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number),
            detail_number);
   }

   try {
      Doc pdf = new Doc(&errorCallback);
      pdf.setCompressionMode(CompressionMode.all);
      Font helvetica = pdf.getFont("Helvetica");

      Page page = pdf.addPage();
      page.setWidth(550);
      page.setHeight(500);
      Destination dst = page.createDestination();
      writeln(hasDoc(pdf));

      pdf.setOpenAction(dst.destinationHandle());

      page.beginText();
      page.setFontAndSize(helvetica, 20);
      page.moveTextPos(220, page.getHeight - 70);
      page.showText("ImageDemo");
      page.endText();

      Image image =  pdf.getPngImage("basn3p02.png");
      Image image1 = pdf.getPngImage("basn3p02.png");
      Image image2 = pdf.getPngImage("basn0g01.png");
      Image image3 = pdf.getPngImage("maskimage.png");

      double iw = image.getWidth;
      double ih = image.getHeight;
      page.setLineWidth(0.5);

      double x = 100;
      double y = page.getHeight - 150;

      page.drawImage(image, x, y, iw, ih);
      showDescription(page, x, y, "Actual Size");

      x += 150;

      /* Scalling image (X direction) */
      page.drawImage(image, x, y, iw * 1.5, ih);
      showDescription(page, x, y, "Scalling image (X direction)");

      x += 150;
      /* Scalling image (Y direction). */
      page.drawImage(image, x, y, iw, ih * 1.5);
      showDescription(page, x, y, "Scalling image (Y direction)");

      x = 100;
      y -= 120;

      /* Skewing image. */
      double angle1 = 10;
      double angle2 = 20;
      double rad1 = angle1 / 180 * 3.141592;
      double rad2 = angle2 / 180 * 3.141592;

      page.graphicSave();
      page.concat(iw, tan(rad1) * iw, tan(rad2) * ih, ih, x, y);

      page.executeXObject(image);
      page.graphicRestore();
      showDescription(page, x, y, "Skewing image");

      x += 150;
      /* Rotating image */
      double angle = 30;     /* rotation of 30 degrees. */
      double rad = angle / 180 * 3.141592; /* Calcurate the radian value. */

      page.graphicSave();
      page.concat(iw * cos(rad),
            iw * sin(rad),
            ih * -sin(rad),
            ih * cos(rad),
            x, y);

      page.executeXObject( image);
      page.graphicRestore();
      showDescription (page, x, y, "Rotating image");

      x += 150;
      /* draw masked image. */
      /* Set image2 to the mask image of image1 */
      image1.setMaskImage(image2);

      page.setRGBFill(0, 0, 0);

      page.beginText();
      page.moveTextPos(x - 6, y + 14);
      page.showText("MASKMASK");
      page.endText();

      page.drawImage(image1, x - 3, y - 3, iw + 6, ih + 6);

      showDescription(page, x, y, "masked image");

      x = 100;
      y -= 120;
      /* color mask. */
      page.setRGBFill(0, 0, 0);
      page.beginText();
      page.moveTextPos(x - 6, y + 14);
      page.showText("MASKMASK");
      page.endText();

      image3.setColorMask(0, 255, 0, 0, 0, 255);
      page.drawImage(image3, x, y, iw, ih);
      showDescription(page, x, y, "Color Mask");

      pdf.saveToFile("./image.pdf");
   } catch (Exception exc) {
      writeln(exc);
   }
}

private Image getPngImage(Doc pdf, string fn) {
   version (Windows) {
      return pdf.loadPngImageFromFile("pngsuite\\" ~ fn);
   } else {
      return pdf.loadPngImageFromFile("pngsuite/" ~ fn);
   }
}

void showDescription(Page page, float x, float y, string text) {
   page.moveTo(x, y - 10);
   page.lineTo(x, y + 10);
   page.moveTo(x - 10, y);
   page.lineTo(x + 10, y);
   page.stroke();

   page.setFontAndSize(page.getCurrentFont, 8);
   page.setRGBFill(0, 0, 0);

   page.beginText();
   string coor = "(x=%s, y=%s)".format(x, y);
   page.moveTextPos (x - page.getTextWidth(coor) - 5, y - 10);
   page.showText(coor);
   page.endText();

   page.beginText();
   page.moveTextPos(x - 20, y - 25);
   page.showText(text);
   page.endText();
}
