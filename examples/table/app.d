import std.stdio: writeln;

import harud;
void main() {
   try {
      Doc pdf = new Doc();   ///  New pdf document

      Page page = pdf.addPage(); /// Add a new page to the document
      page.setSize(PageSizes.A4, PageDirection.portrait);
      Font helvetica = pdf.getFont("Helvetica");
      Font helveticaBold = getFont(pdf, StandardFont.helveticaBold);
      helvetica.printFontInfo;
      auto status = page.setFontAndSize(helvetica, 10);
      helvetica.printFontInfo;

      // col size = 516 /12 = 43
      Table table = new Table(page, createTopLeftRect(50, 800, 528 , 200));

      table.addRow(18);
      page.setFontAndSize(helveticaBold, 12);

      //page.setCMYKFill(0.43, 0.07, 0.0, 0.01);

      table.addCol(Column(3, "Supply", HaruTextAlignment.left, CellBorder.all, 5, 0, 0, 0, HaruCMYKColor(0.47, 0., 0.47, 0.03)));

      page.setFontAndSize(helvetica, 12);
      //table.addCol(Column(1, "Set", HaruTextAlignment.center, CellBorder.all));
      Column c0 ={colSpan: 1, text:"Set", alignment: HaruTextAlignment.center, border:CellBorder.all, fillColor: HaruCMYKColor(0.47, 0.3, 0.47, 0.03)};
      table.addCol(c0);
      table.addCol(Column(2, "Measure", HaruTextAlignment.center, CellBorder.all));
      page.setFontAndSize(helveticaBold, 12);
      table.addCol(Column(4, "Compressor power supply", HaruTextAlignment.left, CellBorder.all, 5));
      page.setFontAndSize(helvetica, 12);
      table.addCol(Column(2, "Measure", HaruTextAlignment.center, CellBorder.all));
      page.setFontAndSize(helvetica, 10);

      table.addRow(15);
      table.addCol(Column(3, "Voltage", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "V", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Voltage", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "V", HaruTextAlignment.left, CellBorder.all, 5));

      table.addRow(15);
      table.addCol(Column(3, "Current", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "A", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Current", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "A", HaruTextAlignment.left, CellBorder.all, 5));

      table.addRow(15);
      table.addCol(Column(3, "Power", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "W", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Power", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "W", HaruTextAlignment.left, CellBorder.all, 5));

      table.addRow(15);
      table.addCol(Column(3, "Power factor", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Power factor", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "", HaruTextAlignment.left, CellBorder.all, 5));

      table.addRow(15);
      table.addCol(Column(3, "Frequency", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "Hz", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Frequency", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "Hz", HaruTextAlignment.left, CellBorder.all, 5));


      table.addRow(10);
      table.addCol(Column(12, "", HaruTextAlignment.left, CellBorder.none));

      table.addRow(18);
      page.setFontAndSize(helveticaBold, 12);
      table.addCol(Column(3, "Temperarure data", HaruTextAlignment.left, CellBorder.all, 5));

      page.setFontAndSize(helvetica, 12);
      table.addCol(Column(1, "Set", HaruTextAlignment.center, CellBorder.all));
      table.addCol(Column(2, "Measure", HaruTextAlignment.center, CellBorder.all));
      page.setFontAndSize(helveticaBold, 12);
      table.addCol(Column(4, "Pressure data", HaruTextAlignment.left, CellBorder.all, 5));
      page.setFontAndSize(helvetica, 12);
      table.addCol(Column(2, "Measure", HaruTextAlignment.center, CellBorder.all));
      page.setFontAndSize(helvetica, 10);

      table.addRow(15);
      table.addCol(Column(3, "Voltage", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(1, "", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "V", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(4, "Voltage", HaruTextAlignment.left, CellBorder.all, 5));
      table.addCol(Column(2, "V", HaruTextAlignment.left, CellBorder.all, 5));

      pdf.saveToFile("./table.pdf"); /// Write to disk
   } catch(HarudException e) {
      writeln("exp:", e.msg, " num:", e.errCode);
   } catch (Exception e) {
      writeln("unknow error ", e.msg);
   }
}

void printFontInfo(Font f) {
   import std.stdio;
   writefln("getAscent      : %s", f.getAscent       );// Gets the vertical ascent of the font.
   writefln("getBBox        : %s", f.getBBox         );// Gets the bounding box of the font.
   writefln("getCapHeight   : %s", f.getCapHeight    );// Gets the distance from the baseline of uppercase letters.
   writefln("getDescent     : %s", f.getDescent      );// Gets the vertical descent of the font.
   writefln("getEncodingName: %s", f.getEncodingName );// Gets the encoding name of the font.
   writefln("getFontName    : %s", f.getFontName     );// Gets the name of the font.
   //writefln("getUnicodeWidth: %s", f.getUnicodeWidth );// Gets the width of a Unicode character in a specific font.
   writefln("getXHeight     : %s pt", f.getXHeight      );// Gets the distance from the baseline of lowercase letters.
}
