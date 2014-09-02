import std.stdio;

import harud;
import harud.c;
void main() {
   void errorCallback(uint error_number, uint detail_number) {
      writefln("err from callback %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number), 
            detail_number);
   }

   writeln("+++with try+++"); 

   Doc pdf0 = new Doc();   ///  New pdf document
   Page page0 = pdf0.addPage(); /// Add a new page to the document
   try {
      page0.width = 1;

   } catch(HarudException e) {
      writeln("exp:", e.msg, " num:", e.errCode);
   }

   writeln();
   writeln("+++with callback+++"); 

   Doc pdf1 = new Doc(&errorCallback);
   Page page1 = pdf1.addPage(); /// Add a new page to the document
   page1.width = 1;

   writeln();
   writeln("+++without try+++"); 
   Doc pdf2 = new Doc();   ///  New pdf document
   Page page2 = pdf2.addPage(); /// Add a new page to the document
   page2.width = 1;



}
