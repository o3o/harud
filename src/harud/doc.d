/**
 * Describes main document
 */
module harud.doc;

import harud.c.capi;
import harud.c.consts;
import harud;
import std.conv;
import std.string;

/**
 *  PDF Document Class
 */
class Doc : IHaruObject {
   protected HPDF_Doc _doc;
   protected void delegate(HPDF_STATUS, HPDF_STATUS) dlg;
   public HPDF_Font fuente;

   /**
    * Creates a new Doc instance
    * Returns: the new Doc instance
    */
   this() {
      void delegate(uint, uint) stdErrorHandler = delegate void(uint e, uint d) { throw new HarudException(e); };
      this(stdErrorHandler);
   }

   /**
    * Creates a new Doc instance with a delegate which is invoked when an
    * error occurred.
    *
    * The delegate must be in the form of
    * ---
    * void error_callback(uint error_no, uint detail_no)
    * ---
    , where error_no it's the number's error and detail_no it's the detail's number
    *
    * Params:
    * _dlg = The delegate wich is invoked
    *
    * Returns:
    * the new Doc instance
    *
    * Examples:
    * ------------------------------------
    * void error_handler(uint error_no, uint detail_no) {
    *    writefln("error_no: %s, detail_no: %s", error_no, detail_no);
    * }
    * Doc document = new Doc( &errorHandler );
    * ------------------------------------
    */
   this(void delegate(HPDF_STATUS error_no, HPDF_STATUS detail_no) _dlg) {
      dlg = _dlg;
      this._doc = HPDF_New(&errorHandler, cast(void*)this);
   }

   extern (C) static void errorHandler(HPDF_STATUS error_no, HPDF_STATUS detail_no, Doc doc) {
      doc.dlg(error_no, detail_no);
   }

   /**
    * Creates a new page and adds it after the last page of a document.
    *
    * Returns:
    * a Page instance of the created page on success. Otherwise, it returns error-code and error-handler is called.
    */
   Page addPage() {
      return new Page(HPDF_AddPage(this._doc));
   }

   /**
    * Adds a page labeling range for the document
    *
    * Params:
    *  page_num = the first page that applies this labeling range
    *  style = one of the following numbering styles:
    *
    *  $(LI PageNumStyle.DECIMAL - Arabic numerals (1 2 3 4))
    *  $(LI PageNumStyle.UPPER_ROMAN - Uppercase roman numerals (I II III IV))
    *  $(LI PageNumStyle.LOWER_ROMAN - Lowercase roman numerals (i ii iii iv))
    *  $(LI PageNumStyle.UPPER_LETTERS - Uppercase letters (A B C D))
    *  $(LI PageNumStyle,LOWER_LETTERS - Lowercase letters (a b c d))
    *
    *  first_page = the first page number to use
    *  prefix = the prefix for the page label. (null is allowed.)
    */
   HPDF_STATUS addPageLabel(uint page_num, PageNumStyle style, uint first_page, string prefix = null) {
      return HPDF_AddPageLabel(this._doc, page_num, style, first_page, prefix.toStringz());
   }

   /**
    * Creates an instance of Outline object.
    *
    * Params:
    *  parent = the instance of a Outline object which comes to the parent of the created outline object. If null, the outline is created as a root outline.
    *  title = the caption of the outline object.
    *  encoder = the instance of a Encoding object applied to the title. If null, PDFDocEncoding is used.
    *
    * Returns:
    * when createOutline() succeeds, it returns a instance of Outline object. Otherwise, it returns null and error-handler is invoked.
    */
   Outline createOutline(string title, Outline parent = null, Encoder encoder = null) {
      HPDF_Outline outline = HPDF_CreateOutline(this._doc, parent is null ? null : parent.getHandle(), title.toStringz(),
            encoder is null ? null : encoder.getHandle());
      return new Outline(outline);
   }

   /**
    * Gets the handle of the current encoder of the document object.
    *
    * The current encoder is set by invoking currentEncoder setter and it is used to processing a text when an application invokes setInfoAttr().
    * The default value of it is null.
    *
    * Returns:
    * It returns an instance of a Encoder object or null
    */
   Encoder getCurrentEncoder() {
      HPDF_Encoder encoder = HPDF_GetCurrentEncoder(this._doc);
      return new Encoder(encoder);
   }

   /**
    * Sets the current encoder for the document
    *
    * Params:
    * encodingName = the name of an encoding
    */
   HPDF_STATUS setCurrentEncoderByName(string encodingName) {
      return HPDF_SetCurrentEncoder(this._doc, encodingName.toStringz());
   }

   /**
    * Returns current page object.
    *
    * Returns:
    * it returns the instance of a current Page object. Otherwise it returns NULL.
    */
   Page getCurrentPage() {
      return new Page(HPDF_GetCurrentPage(this._doc));
   }

   /**
    * Gets an instance of a Encoder object by specified encoding name
    *
    * Params:
    *  encodingName = a valid encoding name
    *
    * Returns:
    * when getEncoder() succeeds, it returns an instance of a Encoder object. Otherwise, it returns null and error-handler is called
    */
   Encoder getEncoder(string encodingName) {
      HPDF_Encoder encoder = HPDF_GetEncoder(this._doc, encodingName.toStringz());
      return new Encoder(encoder);
   }

   /**
    * Returns the last error code.
    */
   HPDF_STATUS getError() {
      return HPDF_GetError(this._doc);
   }

   /**
    * Once an error code is set, IO processing functions cannot be invoked.
    *
    * In the case of executing a function after the cause of the error is fixed, an application have to invoke resetError() to clear error-code before executing functions
    */
   void resetError() {
      HPDF_ResetError(this._doc);
   }

   /**
    * Sets a user-defined error delegate.
    *
    * If a function call fails, the error delegate is called.
    *
    * Params:
    * _dlg = The delegate to invoke
    *
    * See_Also:
    * this( void delegate( HPDF_STATUS error_no, HPDF_STATUS detail_no ) _dlg )
    */
   HPDF_STATUS setErrorHandler(void delegate(HPDF_STATUS, HPDF_STATUS) _dlg) {
      this.dlg = _dlg;
      return HPDF_SetErrorHandler(this._doc, &errorHandler);
   }

   /**
    * Gets a Font instance of the requested font
    *
    * Params:
    * fontName = a valid font name
    *
    * Returns:
    * when getFont() succeeds, it returns the instance of a Font object.
    * Otherwise, it returns null and error-handler is called.
    */
   Font getFont(string fontName)
   in {
      assert(fontName.length > 0);
   }
   do {
      return new Font(HPDF_GetFont(this._doc, fontName.toStringz(), null));
   }

   /**
    * Gets a Font instance of the requested font
    *
    * Params:
    * fontName = a valid font name
    * encodingName = a valid encoding name
    *
    * Returns:
    * when getFont() succeeds, it returns the instance of a Font object.
    * Otherwise, it returns null and error-handler is called
    */
   Font getFont(string fontName, string encodingName)
   in {
      assert(fontName.length > 0);
      assert(encodingName.length > 0);
   }
   do {
      return new Font(HPDF_GetFont(this._doc, fontName.toStringz(), encodingName.toStringz()));
   }

   /**
    * Gets an attribute value from info dictionary.
    *
    * Params:
    * type = one of the following:
    *
    * $(UL
    * $(LI HaruInfo.author)
    * $(LI HaruInfo.creator)
    * $(LI HaruInfo.title)
    * $(LI HaruInfo.subject)
    * $(LI HaruInfo.keywords)
    * )
    *
    * Returns:
    * when succeeds, it returns the string value of the info dictionary.
    * If the infomation has not been set or an error has occurred, it returns
    * null.
    */
   string getInfoAttr(HaruInfoType type) {
      return to!string(HPDF_GetInfoAttr(this._doc, type));
   }

   /**
    * Sets the text of an info dictionary attribute, using current encoding of the document
    *
    * Params:
    *  type = one of the following:
    *  $(UL
    *  $(LI HaruInfo.author)
    *  $(LI HaruInfo.creator)
    *  $(LI HaruInfo.title)
    *  $(LI HaruInfo.subject)
    *  $(LI HaruInfo.keywords)
    *  )
    *  value = text
    */
   HPDF_STATUS setInfoAttr(HaruInfoType type, string value) {
      return HPDF_SetInfoAttr(this._doc, type, value.toStringz());
   }

   /**
    * Gets the size of the temporary stream of the document.
    *
    * Returns: the size of the temporary stream
    */
   uint getStreamSize() {
      return HPDF_GetStreamSize(this._doc);
   }

   /**
    * Creates a new page and inserts it just before the specified page.
    *
    * Params:
    * target = the instance of a Page. Insert new page just before.
    *
    * Returns:
    * a Page instance of the created page on success. Otherwise, it returns NULL and error-handler is called.
    */
   Page insertPage(Page target) {
      return new Page(HPDF_InsertPage(this._doc, target.getHandle()));
   }

   /**
    * Returns the current setting for page layout
    *
    * Returns:
    * the current setting for $(LINK2 harud/c/types/PageLayout.html, PageLayout)
    */
   PageLayout getPageLayout() {
      return HPDF_GetPageLayout(this._doc);
   }

   /**
    * Sets how the page should be displayed.
    *
    * If this attribute is not set, the setting of the viewer application is used
    *
    * Params:
    * layout = $(LINK2 harud/c/types/PageLayout.html, PageLayout) value
    */
   void setPageLayout(PageLayout layout) {
      HPDF_SetPageLayout(this._doc, layout);
   }

   /**
    * Returns the current setting for page mode
    *
    * Returns:
    * the current setting for $(LINK2 harud/c/types/PageMode.html, PageMode)
    */
   PageMode getPageMode() {
      return HPDF_GetPageMode(this._doc);
   }

   /**
    * Sets how the document should be displayed
    *
    * Params:
    * mode = Page mode $(LINK2 harud/c/types/PageMode.html, PageMode)
    */
   void setPageMode(PageMode mode) {
      HPDF_SetPageMode(this._doc, mode);
   }

   /**
    * Copies the data from the temporary stream of the document into a buffer.
    *
    * Params:
    * buf = Pointer to the buffer
    * size = Size of the buffer
    */
   HPDF_STATUS readFromStream(ubyte* buf, uint* size) {
      return HPDF_ReadFromStream(this._doc, buf, size);
   }

   /**
    * Rewinds the temporary stream of the document
    */
   HPDF_STATUS resetStream() {
      return HPDF_ResetStream(this._doc);
   }

   /**
    * Saves the document to a file.
    *
    * Params:
    * filename = The name of the file to save
    */
   HPDF_STATUS saveToFile(string filename) {
      return HPDF_SaveToFile(this._doc, filename.toStringz());
   }

   /**
    * Saves the document to a temporary stream.
    */
   HPDF_STATUS saveToStream() {
      return HPDF_SaveToStream(this._doc);
   }

   /**
    * In the default setting, a Doc object has one "Pages" object as root of pages.
    *
    * All "Page" objects are created as a kid of the "Pages" object.
    * Since a "Pages" object can own only 8191 kids objects, the maximum number of pages are 8191 page.
    * Additionally, the state that there are a lot of "Page" object under
    * one"Pages" object is not good, because it causes performance degradation of a viewer application.
    *
    * An application can change the setting of a pages tree by invoking setPagesConfiguration().
    * If pagePerPages parameter is set to more than zero, a two-tier pages tree is created.
    * A root "Pages" object can own 8191 "Pages" object, and each lower "Pages" object can own pagePerPages "Page" objects.
    * As a result, the maximum number of pages becomes 8191 * pagePerPages page.
    * An application cannot invoke setPageConfiguration() after a page is added to document
    *
    * Params:
    * pagePerPages = Specify the numbers of pages that a "Pages" object can own
    */
   HPDF_STATUS setPagesConfiguration(uint pagePerPages) {
      return HPDF_SetPagesConfiguration(this._doc, pagePerPages);
   }

   /**
    * Set the first page to appear when a document is opened.
    *
    * Params:
    * open_action = a valid destination object.
    */
   HPDF_STATUS setOpenAction(HPDF_Destination open_action) {
      return HPDF_SetOpenAction(this._doc, open_action);
   }

   /**
    * Loads a Type1 font from an external file and registers it in the document object
    *
    * Params:
    * afmfilename = a path of an AFM file
    * pfmfilename = a path of a PFA/PFB file. If null, the glyph data of font file is not embedded to a PDF file
    *
    * Returns:
    * it returns the name of a font. Otherwise, it returns null and error-handler is called
    */
   string loadType1FontFromFile(string afmfilename, string pfmfilename = null) {
      return to!string(HPDF_LoadType1FontFromFile(this._doc, afmfilename.toStringz(), pfmfilename.toStringz()));
   }

   /**
    * Loads a TrueType font from an external file and register it to a document object
    *
    * Params:
    * filename = A path of a TrueType font file (.ttf)
    * embedding = if this parameter is true, the glyph data of the font is embedded, otherwise only the matrix data is included in PDF file
    *
    * Returns:
    * when loadTTFontFromFile() succeeds, it returns the name of a font.
    * Otherwise, it returns null and error-handler is called
    */
   string loadTTFontFromFile(string filename, bool embedding = false) {
      return to!string(HPDF_LoadTTFontFromFile(this._doc, filename.toStringz(), embedding ? HPDF_TRUE : HPDF_FALSE));
   }

   /**
    * Loads a TrueType font from an external file (at the selected index) and register it to a document object
    *
    * Params:
    * filename = A path of a TrueType font file (.ttf)
    * embedding = if this parameter is true, the glyph data of the font is embedded, otherwise only the matrix data is included in PDF file
    * index = the index of font to be loaded.
    *
    * Returns:
    * when loadTTFontFromFile() succeeds, it returns the name of a font. Otherwise, it returns null and error-handler is called
    */
   string loadTTFontFromFile(string filename, uint index, bool embedding) {
      return to!string(HPDF_LoadTTFontFromFile2(this._doc, filename.toStringz(), index, embedding ? HPDF_TRUE : HPDF_FALSE));
   }

   /**
    * Enables Japanese fonts. After useJPFonts() is involed, an application can use the following Japanese fonts
    *
    * $(LI MS-Mincyo)
    * $(LI MS-Mincyo,Bold)
    * $(LI MS-Mincyo,Italic)
    * $(LI MS-Mincyo,BoldItalic)
    * $(LI MS-Gothic)
    * $(LI MS-Gothic,Bold)
    * $(LI MS-Gothic,Italic)
    * $(LI MS-Gothic,BoldItalic)
    * $(LI MS-PMincyo)
    * $(LI MS-PMincyo,Bold)
    * $(LI MS-PMincyo,Italic)
    * $(LI MS-PMincyo,BoldItalic)
    * $(LI MS-PGothic)
    * $(LI MS-PGothic,Bold)
    * $(LI MS-PGothic,Italic)
    * $(LI MS-PGothic,BoldItalic)
    *
    */
   HPDF_STATUS useJPFonts() {
      return HPDF_UseJPFonts(this._doc);
   }

   /**
    * Enables Korean fonts. After useKRFonts() is involed, an application can use the following Korean fonts
    *
    * $(LI DotumChe)
    * $(LI DotumChe,Bold)
    * $(LI DotumChe,Italic)
    * $(LI DotumChe,BoldItalic)
    * $(LI Dotum)
    * $(LI Dotum,Bold)
    * $(LI Dotum,Italic)
    * $(LI Dotum,BoldItalic)
    * $(LI BatangChe)
    * $(LI BatangChe,Bold)
    * $(LI BatangChe,Italic)
    * $(LI BatangChe,BoldItalic)
    * $(LI Batang)
    * $(LI Batang,Bold)
    * $(LI Batang,Italic)
    * $(LI Batang,BoldItalic)
    *
    */
   HPDF_STATUS useKRFonts() {
      return HPDF_UseKRFonts(this._doc);
   }

   /**
    * Enables simplified Chinese fonts.
    *
    * After useCNSFonts() is involed, an application can use the following simplified Chinese fonts
    *
    * $(LI SimSun)
    * $(LI SimSun,Bold)
    * $(LI SimSun,Italic)
    * $(LI SimSun,BoldItalic)
    * $(LI SimHei)
    * $(LI SimHei,Bold)
    * $(LI SimHei,Italic)
    * $(LI SimHei,BoldItalic)
    *
    */
   HPDF_STATUS useCNSFonts() {
      return HPDF_UseCNSFonts(this._doc);
   }

   /**
    * Enables traditional Chinese fonts.
    *
    * After useCNTFonts() is involed, an application can use the following traditional Chinese fonts
    *
    * $(LI MingLiU)
    * $(LI MingLiU,Bold)
    * $(LI MingLiU,Italic)
    * $(LI MingLiU,BoldItalic)
    *
    */
   HPDF_STATUS useCNTFonts() {
      return HPDF_UseCNTFonts(this._doc);
   }

   /**
    * Enables Japanese encodings.
    *
    * After useJPEncodings() is invoked, an application can use the following Japanese encodings:
    * $(UL
    * $(LI 90ms-RKSJ-H)
    * $(LI 90ms-RKSJ-V)
    * $(LI 90msp-RKSJ-H)
    * $(LI EUC-H)
    * $(LI EUC-V)
    * )
    */
   HPDF_STATUS useJPEncodings() {
      return HPDF_UseJPEncodings(this._doc);
   }

   /**
    * Enables Korean encodings.
    *
    * After useKREncodings() is involed, an application can use the following Korean encodings:
    *
    * $(UL
    * $(LI KSC-EUC-H)
    * $(LI KSC-EUC-V)
    * $(LI KSCms-UHC-H)
    * $(LI KSCms-UHC-HW-H)
    * $(LI KSCms-UHC-HW-V)
    * )
    */
   HPDF_STATUS useKREncodings() {
      return HPDF_UseKREncodings(this._doc);
   }

   /**
    * Enables simplified Chinese encodings.
    *
    * After useCNSEncodings() is involed, an application can use the following simplified Chinese encodings
    * $(UL
    * $(LI GB-EUC-H)
    * $(LI GB-EUC-V)
    * $(LI GBK-EUC-H)
    * $(LI GBK-EUC-V)
    * )
    */
   HPDF_STATUS useCNSEncodings() {
      return HPDF_UseCNSEncodings(this._doc);
   }

   /**
    * Enables traditional Chinese encodings.
    *
    * After useCNTEncodings() is involed, an application can use the following traditional Chinese encodings.
    *
    * $(UL
    * $(LI GB-EUC-H)
    * $(LI GB-EUC-V)
    * $(LI GBK-EUC-H)
    * $(LI GBK-EUC-V)
    * )
    */
   HPDF_STATUS useCNTEncodings() {
      return HPDF_UseCNTEncodings(this._doc);
   }

   /**
    * Loads an external PNG image file.
    * If deferred is true. then does not load all the data immediately (only size and color properties are loaded).
    * The main data are loaded just before the image object is written to PDF, and the loaded data are deleted immediately.
    *
    * Params:
    * filename = a path to a PNG image file
    * deferred = if the load of the image must be referred
    *
    * Returns:
    * when loadPngImageFromFile() succeeds, it returns an instance of a Image object.
    * Otherwise, it returns null and error-handler is called.
    */
   Image loadPngImageFromFile(string filename, bool deferred = false) {
      HPDF_Image image = null;
      if (deferred) {
         image = HPDF_LoadPngImageFromFile2(this._doc, filename.toStringz());
      } else {
         image = HPDF_LoadPngImageFromFile(this._doc, filename.toStringz());
      }
      return new Image(image);
   }

   /**
    * Loads an image which has "raw" image format.
    *
    * This function loads the data without any conversion. So it is usually faster than the other functions.
    *
    * Params:
    * filename = A path to a image file.
    * width = The width of an image file.
    * height = The height of an image file.
    * colorSpace = the $(LINK2 harud/c/types/ColorSpace.html, ColorSpace).
    * `deviceGrey`, `deviceRGB` or `deviceCMYK` are allowed.
    *
    * Returns:
    * When loadRawImageFromFile() succeeds, it returns an instance of a $(LINK2 harud/image/Image.html,Image) object.
    * Otherwise, it returns `null` and error-handler is called.
    */
   Image loadRawImageFromFile(string filename, uint width, uint height, ColorSpace colorSpace) {
      HPDF_Image image = HPDF_LoadRawImageFromFile(this._doc, filename.toStringz(), width, height, colorSpace);
      return new Image(image);
   }

   /**
    * Loads an image which has $(I raw) image format from buffer.
    *
    * This function loads the data without any conversion. So it is usually faster than the other functions.
    * The formats that loadRawImageFromMem() can load is the same as loadRawImageFromFile()
    *
    * Params:
    * buf = The pointer to the image data.
    * width = The width of an image file.
    * height = The height of an image file.
    * colorSpace = the $(LINK2 harud/c/types/ColorSpace.html, ColorSpace).
    * `deviceGrey`, `deviceRGB` or `deviceCMYK` are allowed.
    * bitsPerComponent = The bit size of each color component. The valid value is either 1, 2, 4, 8.
    *
    * Returns:
    * When loadRawImageFromMem() succeeds,
    * it returns an instance of a $(LINK2 harud/image/Image.html,Image) object.
    * Otherwise, it returns `null` and error-handler is called.
    */
   Image loadRawImageFromMem(ubyte* buf, uint width, uint height, ColorSpace colorSpace, uint bitsPerComponent) {
      HPDF_Image image = HPDF_LoadRawImageFromMem(this._doc, buf, width, height, colorSpace, bitsPerComponent);
      return new Image(image);
   }

   /**
    * Loads an external JPEG image file
    *
    * Params:
    * filename = path to a JPEG image file
    *
    * Returns:
    * when loadJpegImageFromFile() succeeds,
    * it returns an instance of a $(LINK2 harud/image/Image.html,Image) object.
    * Otherwise, it returns `null` and error-handler is called.
    */
   Image loadJpegImageFromFile(string filename) {
      HPDF_Image image = HPDF_LoadJpegImageFromFile(this._doc, filename.toStringz());
      return new Image(image);
   }

   /**
    * Sets a datetime attribute in the info dictionary.
    *
    * Params:
    *  type = one of the following attributes:
    *  $(UL
    *  $(LI HaruInfo.CREATION_DATE)
    *  $(LI HaruInfo.MOD_DATE)
    *  )
    *
    *  value = The new value for the attribute.
    *
    * See_Also:
    * HaruDate
    */
   HPDF_STATUS setInfoDateAttr(HaruInfoType type, HaruDate value) {
      return HPDF_SetInfoDateAttr(this._doc, type, value);
   }

   /**
    * Sets a password for the document. If the password is set, document contents are encrypted
    *
    * Params:
    *  ownerPasswd = The password for the owner of the document. The owner can change the permission of the document. null, zero length string, and the same value as user password are not allowed.
    *  userPasswd = The password for the user of the document. The userPassword may be set to null or zero length string.
    *
    */
   HPDF_STATUS setPassword(string ownerPasswd, string userPasswd = null) {
      return HPDF_SetPassword(this._doc, ownerPasswd.toStringz(), userPasswd.toStringz());
   }

   /**
    * Set the permission flags for the document
    *
    * Params:
    * permission = One or more of the $(LINK2 harud/c/types/HaruPermission.html, HaruPermission) "ored" together
    *
    */
   HPDF_STATUS setPermission(HaruPermission permission) {
      return HPDF_SetPermission(this._doc, permission);
   }

   /**
    * Set the encryption mode. As the side effect, ups the version of PDF to 1.4 when the mode is set to HaruEncryptMode.R3
    *
    * Params:
    * mode = One  of the $(LINK2
    * harud/c/types/HaruEncryptMode.html, HaruEncryptMode)
    * keyLen = Specify the byte length of encryption key.
    * Only valid for HaruEncryptMode.R3. Between 5 (40 bits) and 16 (128 bits) can be specified
    *
    */
   HPDF_STATUS setEncryptionMode(HaruEncryptMode mode, uint keyLen) {
      return HPDF_SetEncryptionMode(this._doc, mode, keyLen);
   }

   /**
    * Set the mode of compression.
    *
    * Params:
    * mode = Compression mode $(LINK2 harud/c/types/CompressionMode.html, CompressionMode)
    */
   HPDF_STATUS setCompressionMode(CompressionMode mode) {
      return HPDF_SetCompressionMode(this._doc, mode);
   }

   HPDF_HANDLE getHandle() {
      return this._doc;
   }
}

/**
 * Get version
 */
string getVersion() {
   return to!string(HPDF_GetVersion());
}

/**
 * Checks if the document is valid.
 *
 * Params:
 * document = The instance of Doc to check
 *
 * Returns:
 * If the specified document handle is valid, it returns true.
 * Otherwise, it returns false and error-handler is called.
 */
static bool hasDoc(Doc document) {
   return (HPDF_HasDoc(document._doc) != 0);
}
