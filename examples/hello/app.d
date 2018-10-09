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

   Doc pdf = new Doc(&errorCallback);   ///  New pdf document
   Font helvetica = pdf.getFont("Helvetica");
   writeln("build font");

   Page page = pdf.addPage(); /// Add a new page to the document

   writeln("page width:", page.getWidth());


   auto status = page.setFontAndSize(helvetica, 60);   /// Set the current font and size for the page
   writeln("set font width:", 60, " status", status);

   status = page.beginText(); /// Begin text mode
   writeln("begin ", status);

   status = page.showText("Hello World cul"); /// Print text to the page
   writeln("show ", status);

   page.endText(); /// End text mode

   pdf.saveToFile("./hello.pdf"); /// Write to disk
}
