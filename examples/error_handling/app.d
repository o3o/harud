import harud.c;
import harud;
import std.stdio;

void main() {
   void errorCallback(uint error_number, uint detail_number) {
      writefln("err from callback %x, %s, (num %x)"
            , error_number
            , getErrorDescription(error_number),
            detail_number);
   }

   writeln("+++with try+++");

   Doc pdf0 = new Doc();
   Page page0 = pdf0.addPage();
   try {
      page0.setWidth(1);
   } catch(HarudException e) {
      writeln("exp:", e.msg, " num:", e.errCode);
   }
   writeln();

   writeln("+++with callback+++");

   Doc pdf1 = new Doc(&errorCallback);
   Page page1 = pdf1.addPage();
   page1.setWidth(1);
   writeln();

   writeln("+++without try+++");
   Doc pdf2 = new Doc();
   Page page2 = pdf2.addPage();
   page2.setWidth(1);
}
