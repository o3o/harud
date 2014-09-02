module harud.doc;

import std.conv;
import std.string;

import harud.haruobject;
import harud.c;
import harud.page;
import harud.font;
import harud.encoder;
import harud.outline;
import harud.image;


class Doc: IHaruObject {
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
      //dlg = delegate void(HPDF_STATUS e, HPDF_STATUS d) { throw new HarudException(e); };
      //this._doc = HPDF_New(&errorHandler, cast(void*) this);
   }

   /**
    * Creates a new Doc instance with a delegate which is invoked when an
    * error occurred.
    *
    * The delegate must be in the form of void error_callback( uint error_no, uint detail_no ), where error_no it's the number's error and detail_no it's the detail's number
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
    *    }
    * Doc document = new Doc( &errorHandler );
    * ------------------------------------
    */

   this(void delegate(HPDF_STATUS error_no, HPDF_STATUS detail_no) _dlg) {
      dlg = _dlg;
      this._doc = HPDF_New(&errorHandler, cast(void*) this);
   }

   extern(C) static void errorHandler(HPDF_STATUS error_no, HPDF_STATUS detail_no, Doc doc) {
      doc.dlg(error_no, detail_no);
   }

   /**
    * Saves the document to a file
    *
    * Params:
    * filename = The name of the file to save
    */
   HPDF_STATUS saveToFile(string filename) {
      return HPDF_SaveToFile(this._doc, filename.toStringz());
   }

   /**
    * Saves the document to a temporary stream
    */
   HPDF_STATUS saveToStream() {
      return HPDF_SaveToStream(this._doc);
   }

   /**
    * Gets the size of the temporary stream of the document
    *
    * Returns: the size of the temporary stream
    */
   uint getStreamSize() {
      return HPDF_GetStreamSize(this._doc);
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
    * Checks if the document is valid
    *
    * Params:
    * document = The instance of Doc to check
    *
    * Returns: If the specified document handle is valid, it returns true. Otherwise, it returns false and error-handler is called
    */
   static bool hasDoc(Doc document) {
      return (HPDF_HasDoc(document._doc) != 0) ;
   }

   /**
    * Sets a user-defined error delegate. If a function call fails, the error delegate is called.
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
    * Returns the last error code of specified document object
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
    * In the default setting, a Doc object has one "Pages" object as root of pages. 
    * All "Page" objects are created as a kid of the "Pages" object. 
    * Since a "Pages" object can own only 8191 kids objects, the maximum number of pages are 8191 page. 
    * Additionally, the state that there are a lot of "Page" object under one "Pages" object is not good, because it causes performance degradation of a viewer application.
    *
    * An application can change the setting of a pages tree by invoking setPagesConfiguration(). 
    * If page_per_pages parameter is set to more than zero, a two-tier pages tree is created. 
    * A root "Pages" object can own 8191 "Pages" object, and each lower "Pages" object can own page_per_pages "Page" objects. 
    * As a result, the maximum number of pages becomes 8191 * page_per_pages page. 
    * An application cannot invoke setPageConfiguration() after a page is added to document
    *
    * Params:
    * page_per_pages = Specify the numbers of pages that a "Pages" object can own
    */
   HPDF_STATUS setPagesConfiguration(uint page_per_pages) {
      return HPDF_SetPagesConfiguration(this._doc, page_per_pages);
   }

   /**
    * Sets how the page should be displayed. If this attribute is not set, the setting of the viewer application is used
    *
    * Params:
    * layout = One of the following values:
    *
    * <li>PageLayout.SINGLE - Only one page is displayed.</li>
    * <li>PageLayout.ONE_COLUMN - Display the pages in one column.</li>
    * <li>PageLayout.TWO_COLUMN_LEFT - Display in two columns. Odd page number is displayed left</li>
    * <li>PageLayout.TWO_COLUMN_RIGHT - Display in two columns. Odd page number is displayed right</li>
    */
   HPDF_STATUS setPageLayout(PageLayout layout) {
      return HPDF_SetPageLayout(this._doc, layout);
   }

   /**
    * Returns the current setting for page layout
    *
    * Returns:
    * the current setting for page layout
    */
   PageLayout getPageLayout() {
      return HPDF_GetPageLayout(this._doc);
   }

   /**
    * Sets how the document should be displayed
    *
    * Params:
    * mode = The following values are available
    *
    * <li>PageMode.USE_NONE - Display the document with neither outline nor thumbnail.</li>
    * <li>PageMode.USE_OUTLINE - Display the document with outline pane.</li>
    * <li>PageMode.USE_THUMBS - Display the document with thumbnail pane.</li>
    * <li>PageMode.FULL_SCREEN - Display the document with full screen mode.</li>
    */
   @property void pageMode(PageMode mode) {
      HPDF_SetPageMode(this._doc, mode);
   }

   /**
    * Returns the current setting for page mode
    *
    * Returns:
    * the current setting for page mode.
    */
   @property PageMode pageMode() {
      return HPDF_GetPageMode(this._doc);
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
    * Returns the handle of current page object.
    *
    * Returns:
    * it returns the instance of a current Page object. Otherwise it returns NULL.
    */
   Page getCurrentPage() {
      return new Page(HPDF_GetCurrentPage(this._doc));
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

   Font getFont(string fontName) 
      in {
         assert(fontName.length > 0);
      } body {
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
    * when getFont() succeeds, it returns the instance of a Font object. Otherwise, it returns null and error-handler is called
    */
   Font getFont(string fontName, string encodingName) 
      in {
         assert(fontName.length > 0);
         assert(encodingName.length > 0);
      } body {
         return new Font(HPDF_GetFont(this._doc, fontName.toStringz(), encodingName.toStringz()));
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
      return to!string(
            HPDF_LoadType1FontFromFile(this._doc
               , afmfilename.toStringz()
               , pfmfilename.toStringz())
            );
   }

   /**
    * Loads a TrueType font from an external file and register it to a document object
    0*
    * Params:
    * filename = A path of a TrueType font file (.ttf)
    * embedding = if this parameter is true, the glyph data of the font is embedded, otherwise only the matrix data is included in PDF file
    *
    * Returns:
    * when loadTTFontFromFile() succeeds, it returns the name of a font. Otherwise, it returns null and error-handler is called
    */
   string loadTTFontFromFile(string filename, bool embedding = false) {
      return to!string(HPDF_LoadTTFontFromFile(this._doc
               , filename.toStringz()
               , embedding ? HPDF_TRUE : HPDF_FALSE));
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
      return to!string(HPDF_LoadTTFontFromFile2(this._doc
               , filename.toStringz()
               , index
               , embedding ? HPDF_TRUE : HPDF_FALSE));
   }

   /**
    * Adds a page labeling range for the document
    *
    * Params:
    * page_num = the first page that applies this labeling range
    * style = one of the following numbering styles:
    *
    * <li>PageNumStyle.DECIMAL - Arabic numerals (1 2 3 4)</li>
    * <li>PageNumStyle.UPPER_ROMAN - Uppercase roman numerals (I II III IV)</li>
    * <li>PageNumStyle.LOWER_ROMAN - Lowercase roman numerals (i ii iii iv)</li>
    * <li>PageNumStyle.UPPER_LETTERS - Uppercase letters (A B C D)</li>
    * <li>PageNumStyle,LOWER_LETTERS - Lowercase letters (a b c d)</li>
    *
    * first_page = the first page number to use
    * prefix - the prefix for the page label. (null is allowed.)
    */
   HPDF_STATUS addPageLabel(uint page_num,
         PageNumStyle style,
         uint first_page,
         string prefix = null) {
      return HPDF_AddPageLabel(this._doc
            , page_num
            , style
            , first_page
            , prefix.toStringz());
   }

   /**
    * Enables Japanese fonts. After useJPFonts() is involed, an application can use the following Japanese fonts
    *
    * <li>MS-Mincyo</li>
    * <li>MS-Mincyo,Bold</li>
    * <li>MS-Mincyo,Italic</li>
    * <li>MS-Mincyo,BoldItalic</li>
    * <li>MS-Gothic</li>
    * <li>MS-Gothic,Bold</li>
    * <li>MS-Gothic,Italic</li>
    * <li>MS-Gothic,BoldItalic</li>
    * <li>MS-PMincyo</li>
    * <li>MS-PMincyo,Bold</li>
    * <li>MS-PMincyo,Italic</li>
    * <li>MS-PMincyo,BoldItalic</li>
    * <li>MS-PGothic</li>
    * <li>MS-PGothic,Bold</li>
    * <li>MS-PGothic,Italic</li>
    * <li>MS-PGothic,BoldItalic</li>
    *
    */
   HPDF_STATUS useJPFonts() {
      return HPDF_UseJPFonts(this._doc);
   }

   /**
    * Enables Korean fonts. After useKRFonts() is involed, an application can use the following Korean fonts
    *
    * <li>DotumChe</li>
    * <li>DotumChe,Bold</li>
    * <li>DotumChe,Italic</li>
    * <li>DotumChe,BoldItalic</li>
    * <li>Dotum</li>
    * <li>Dotum,Bold</li>
    * <li>Dotum,Italic</li>
    * <li>Dotum,BoldItalic</li>
    * <li>BatangChe</li>
    * <li>BatangChe,Bold</li>
    * <li>BatangChe,Italic</li>
    * <li>BatangChe,BoldItalic</li>
    * <li>Batang</li>
    * <li>Batang,Bold</li>
    * <li>Batang,Italic</li>
    * <li>Batang,BoldItalic</li>
    *
    */
   HPDF_STATUS useKRFonts() {
      return HPDF_UseKRFonts(this._doc);
   }

   /**
    * Enables simplified Chinese fonts. After useCNSFonts() is involed, an application can use the following simplified Chinese fonts
    *
    * <li>SimSun</li>
    * <li>SimSun,Bold</li>
    * <li>SimSun,Italic</li>
    * <li>SimSun,BoldItalic</li>
    * <li>SimHei</li>
    * <li>SimHei,Bold</li>
    * <li>SimHei,Italic</li>
    * <li>SimHei,BoldItalic</li>
    *
    */
   HPDF_STATUS useCNSFonts() {
      return HPDF_UseCNSFonts(this._doc);
   }

   /**
    * Enables traditional Chinese fonts. After useCNTFonts() is involed, an application can use the following traditional Chinese fonts
    *
    * <li>MingLiU</li>
    * <li>MingLiU,Bold</li>
    * <li>MingLiU,Italic</li>
    * <li>MingLiU,BoldItalic</li>
    *
    */
   HPDF_STATUS useCNTFonts() {
      return HPDF_UseCNTFonts(this._doc);
   }

   /**
    * Gets an instance of a Encoder object by specified encoding name
    *
    * Params:
    * encodingName - a valid encoding name
    *
    * Returns:
    * when getEncoder() succeeds, it returns an instance of a Encoder object. Otherwise, it returns null and error-handler is called
    */
   Encoder getEncoder(string encodingName) {
      HPDF_Encoder encoder = HPDF_GetEncoder(this._doc ,
            encodingName.toStringz());
      return new Encoder(encoder);
   }

   /**
    * Gets the handle of the current encoder of the document object. 
    * The current encoder is set by invoking setCurrentEncoder() and it is used to processing a text when an application invokes setInfoAttr(). 
    * The default value of it is null.
    *
    * Returns:
    * it returns an instance of a Encoder object or null
    */
   @property Encoder currentEncoder() {
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
    * Enables Japanese encodings. After useJPEncodings() is invoked, an application can use the following Japanese encodings:
    *
    * <li>90ms-RKSJ-H</li>
    * <li>90ms-RKSJ-V</li>
    * <li>90msp-RKSJ-H</li>
    * <li>EUC-H</li>
    * <li>EUC-V</li>
    */
   HPDF_STATUS useJPEncodings() {
      return HPDF_UseJPEncodings(this._doc);
   }

   /**
    * Enables Korean encodings. 
    
    * After useKREncodings() is involed, an application can use the following Korean encodings:
    *
    * <li>KSC-EUC-H</li>
    * <li>KSC-EUC-V</li>
    * <li>KSCms-UHC-H</li>
    * <li>KSCms-UHC-HW-H</li>
    * <li>KSCms-UHC-HW-V</li>
    */
   HPDF_STATUS useKREncodings() {
      return HPDF_UseKREncodings(this._doc);
   }

   /**
    * Enables simplified Chinese encodings. 
    
    * After useCNSEncodings() is involed, an application can use the following simplified Chinese encodings
    *
    * <li>GB-EUC-H</li>
    * <li>GB-EUC-V</li>
    * <li>GBK-EUC-H</li>
    * <li>GBK-EUC-V</li>
    */
   HPDF_STATUS useCNSEncodings() {
      return HPDF_UseCNSEncodings(this._doc);
   }

   /**
    * Enables traditional Chinese encodings.
    *
    * After useCNTEncodings() is involed, an application can use the following traditional Chinese encodings.
    *
    * <li>GB-EUC-H</li>
    * <li>GB-EUC-V</li>
    * <li>GBK-EUC-H</li>
    * <li>GBK-EUC-V</li>
    */
   HPDF_STATUS useCNTEncodings() {
      return HPDF_UseCNTEncodings(this._doc);
   }

   /**
    * Creates an instance of HaruOutline object.
    *
    * Params:
    * parent = the instance of a HaruOutline object which comes to the parent of the created outline object. If null, the outline is created as a root outline.
    * title = the caption of the outline object.
    * encoder = the instance of a Encoding object applied to the title. If null, PDFDocEncoding is used.
    *
    * Returns:
    * when createOutline() succeeds, it returns a instance of HaruOutline object. Otherwise, it returns null and error-handler is invoked.
    */
   Outline createOutline(string title, Outline parent = null, Encoder encoder = null) {

      HPDF_Outline outline = HPDF_CreateOutline(this._doc
            , parent is null ? null : parent.getHandle()
            , title.toStringz()
            , encoder is null ? null : encoder.getHandle());
      return new Outline(outline);
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
    * when loadPngImageFromFile() succeeds, it returns an instance of a Image object. Otherwise, it returns null and error-handler is called.
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
    * Loads an image which has "raw" image format. This function loads the data without any conversion. So it is usually faster than the other functions.
    *
    * Params:
    * filename = A path to a image file.
    * width = The width of an image file.
    * height = The height of an image file.
    * color_space = the ColorSpace:
    *
    * <li>ColorSpace.DEVICE_GRAY</li>
    * <li>ColorSpace.DEVICE_RGB</li>
    * <li>HaruColor.DEVICE_CMYK</li>
    *
    * Returns:
    * When loadRawImageFromFile() succeeds, it returns an instance of a Image object. Otherwise, it returns null and error-handler is called
    */
   Image loadRawImageFromFile(string filename
         , uint width
         , uint height
         , ColorSpace color_space) {
      HPDF_Image image = HPDF_LoadRawImageFromFile(this._doc,
            filename.toStringz(),
            width,
            height,
            color_space);
      return new Image(image);
   }

   /**
    * Loads an image which has "raw" image format from buffer. This function loads the data without any conversion. So it is usually faster than the other functions.
    * The formats that loadRawImageFromMem() can load is the same as loadRawImageFromFile()
    *
    * Params:
    * buf = The pointer to the image data.
    * width = The width of an image file.
    * height = The height of an image file.
    * color_space = the ColorSpace:
    *
    * <li>ColorSpace.DEVICE_GRAY</li>
    * <li>ColorSpace.DEVICE_RGB</li>
    * <li>HaruColor.DEVICE_CMYK</li>
    *
    * bits_per_component = The bit size of each color component. The valid value is either 1, 2, 4, 8.
    *
    * Returns:
    * when loadRawImageFromMem() succeeds, it returns an instance of a Image object. Otherwise, it returns null and error-handler is called
    */
   Image loadRawImageFromMem(ubyte* buf,
         uint width,
         uint height,
         ColorSpace color_space,
         uint bits_per_component) {
      HPDF_Image image = HPDF_LoadRawImageFromMem(this._doc,
            buf,
            width,
            height,
            color_space,
            bits_per_component);
      return new Image(image);
   }

   /**
    * Loads an external JPEG image file
    *
    * Params:
    * filename = path to a JPEG image file
    *
    * Returns:
    * when loadJpegImageFromFile() succeeds, it returns an instance of Image object. Otherwise, it returns null and error-handler is called
    */
   Image loadJpegImageFromFile(string filename) {
      HPDF_Image image = HPDF_LoadJpegImageFromFile(this._doc, filename.toStringz());
      return new Image(image);
   }

   /**
    * Sets the text of an info dictionary attribute, using current encoding of the document
    *
    * Params:
    * type = one of the following:
    *
    * <li>HaruInfo.AUTHOR</li>
    * <li>HaruInfo.CREATOR</li>
    * <li>HaruInfo.TITLE</li>
    * <li>HaruInfo.SUBJECT</li>
    * <li>HaruInfo.KEYWORDS</li>
    *
    */
   HPDF_STATUS setInfoAttr(HaruInfoType type, string value) {
      return HPDF_SetInfoAttr(this._doc, type, value.toStringz());
   }

   /**
    * Gets an attribute value from info dictionary.
    *
    * Params:
    * type = one of the following:
    *
    * <li>HaruInfo.AUTHOR</li>
    * <li>HaruInfo.CREATOR</li>
    * <li>HaruInfo.TITLE</li>
    * <li>HaruInfo.SUBJECT</li>
    * <li>HaruInfo.KEYWORDS</li>
    *
    * Returns:
    * when getInfoAttr() succeeds, it returns the string value of the info dictionary. If the infomation has not been set or an error has occurred, it returns null
    */
   string getInfoAttr(HaruInfoType type) {
      return to!string(HPDF_GetInfoAttr(this._doc, type));
   }

   /**
    * Sets a datetime attribute in the info dictionary.
    * pdf = the handle of a document object.
    * type = one of the following attributes:
    *
    * <li>HaruInfo.CREATION_DATE</li>
    * <li>HaruInfo.MOD_DATE</li>
    *
    * value - The new value for the attribute.
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
    * ownerPassword = The password for the owner of the document. The owner can change the permission of the document. null, zero length string, and the same value as user password are not allowed.
    * userPassword = The password for the user of the document. The userPassword may be set to null or zero length string.
    *
    */
   HPDF_STATUS setPassword(string ownerPasswd, string userPasswd = null) {
      return HPDF_SetPassword(this._doc, ownerPasswd.toStringz(), userPasswd.toStringz());
   }

   /**
    * Set the permission flags for the document
    *
    * Params:
    * permission - One or more of the following, "ored" together:
    *
    * <li>HPDF_ENABLE_READ = user can read the document</li>
    * <li>HPDF_ENABLE_PRINT = user can print the document</li>
    * <li>HPDF_ENABLE_EDIT = user can edit the contents of the document other than annotations, form fields</li>
    * <li>HPDF_ENABLE_COPY = user can copy the text and the graphics of the document</li>
    * <li>HPDF_ENABLE_EDIT_ALL = user can add or modify the annotations and form fields of the document</li>
    */
   @property void permission(Permission permission) {
      HPDF_SetPermission(this._doc, permission);
   }

   /**
    * Set the encryption mode. As the side effect, ups the version of PDF to 1.4 when the mode is set to HaruEncryptMode.R3
    *
    * Params:
    * mode - One of the following:
    *
    * <li>HaruEncryptMode.R2 = Use "Revision 2" algorithm. "key_len" automatically set to 5 (40 bits).</li>
    * <li>HaruEncryptMode.R3 = Use "Revision 3" algorithm. "key_len" can be 5 (40 bits) to 16 (128bits).</li>
    *
    * key_len = Specify the byte length of encryption key. Only valid for HaruEncryptMode.R3. Between 5 (40 bits) and 16 (128 bits) can be specified
    *
    */
   HPDF_STATUS setEncryptionMode(HaruEncryptMode mode, uint keyLen) {
      return HPDF_SetEncryptionMode(this._doc, mode, keyLen);
   }

   /**
    * Set the mode of compression.
    *
    * Params:
    * mode - One or more of the following or'ed together:
    *
    * <li>CompressionMode.none - No compression.</li>
    * <li>CompressionMode.text - Compress the contents stream of the page.</li>
    * <li>CompressionMode.image - Compress the streams of the image objects.</li>
    * <li>CompressionMode.metadata - Other stream datas (fonts, cmaps and so on) are compressed.</li>
    * <li>CompressionMode.all - All stream datas are compressed (CompressionMode.text | CompressionMode.IMAGE | CompressionMode.METADATA).</li>
    */
   @property void compressionMode(CompressionMode mode) {
      HPDF_SetCompressionMode(this._doc, mode);
   }

   HPDF_HANDLE getHandle() {
      return this._doc;
   }
}

string getVersion() {
   return to!string(HPDF_GetVersion());
}

