import std.stdio: writeln;

import harud;
void main() {
   try {

      Doc pdf = new Doc();   ///  New pdf document
      Font helvetica = pdf.getFont("Helvetica");
      writeln("build font");

      Page page = pdf.addPage(); /// Add a new page to the document

      writeln("page width:", page.width);

      auto status = page.setFontAndSize(helvetica, 60);   /// Set the current font and size for the page
      writeln("set font width:", 60, " status", status);

      status = page.beginText(); /// Begin text mode
      writeln("begin ", status);

      status = page.showText("Hello World"); /// Print text to the page
      writeln("show ", status);

      page.endText(); /// End text mode

      pdf.saveToFile("./hello.pdf"); /// Write to disk
   } catch(HarudException e) {
      writeln("exp:", e.msg, " num:", e.errCode);
   } catch (Exception e) {
      writeln("unknow error ", e.msg);
   }
}
