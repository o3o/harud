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
   //HaruDoc pdf = new HaruDoc();   ///  New pdf document
   HaruFont helvetica = pdf.getFont("Helvetica"); 
   writeln("build font");

   Page page = pdf.addPage(); /// Add a new page to the document

   writeln("wid:", page.width);
   try {
      page.width = 1;
   } catch(Exception e) {
      writeln(e.msg);
   }
   
   page.setFontAndSize(helvetica, 60);   /// Set the current font and size for the page

   page.beginText(); /// Begin text mode
   page.showText("Hello World cul"); /// Print text to the page
   page.endText(); /// End text mode

   pdf.saveToFile("./hello.pdf"); /// Write to disk
}
