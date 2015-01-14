module harud.c.types;

alias HPDF_HANDLE = void*; 
alias HPDF_Doc = HPDF_HANDLE; 
alias HPDF_Page = HPDF_HANDLE;
alias HPDF_Pages = HPDF_HANDLE;
alias HPDF_Stream = HPDF_HANDLE;
alias HPDF_Image = HPDF_HANDLE;
alias HPDF_Font = HPDF_HANDLE;
alias HPDF_Outline = HPDF_HANDLE;
alias HPDF_Encoder = HPDF_HANDLE;
alias HPDF_Destination = HPDF_HANDLE;
alias HPDF_XObject = HPDF_HANDLE;
alias HPDF_Annotation = HPDF_HANDLE;
alias HPDF_ExtGState = HPDF_HANDLE;


/* boolean type (0: False, !0: True) */
alias HPDF_BOOL = int;

/** errorNo type (32bit unsigned integer) */
alias HPDF_STATUS = uint;


/** charactor-code type (16bit) */
alias HPDF_CID = ushort;
alias HPDF_UNICODE = ushort;


/** HPDF_Point struct */
struct Point {
   float x;
   float y;
}

struct Rect {
   float left;
   float bottom;
   float right;
   float top;
}

alias HaruBox = Rect;

/**
* Datetime attribute in the info dictionary. 
*/
struct HaruDate {
   int year;
   int month;
   int day;
   int hour;
   int minutes;
   int seconds;
   byte ind;
   int offHour;
   int offMinutes;
}

/**
* Info dictionary types
*/
enum HaruInfoType {
   /** date-time type parameters */
   creationDate = 0,
   modDate,

   /* string type parameters */
   author,
   creator,
   producer,
   title,
   subject,
   keywords,
   eof
}


enum PdfVer {
   V12 = 0,
   V13,
   V14,
   V15,
   V16,
   V17,
   eof
}

/**
  Encrypt mode
*/
enum HaruEncryptMode {
   /// Use "Revision 2" algorithm. "keyLen" automatically set to 5 (40 bits).
   R2 = 2,
   /// Use "Revision 3" algorithm. "keyLen" can be 5 (40 bits) to 16 (128bits).
   R3 = 3
}

struct TextWidth {
   uint numchars;

   /** don't use this value (it may be change in the feature).
     use numspace as alternated. */
   uint numwords;

   uint width;
   uint numspace;
}


struct DashMode {
   ushort ptn[8];
   uint numPtn;
   uint phase;
}


struct TransMatrix {
   float a;
   float b;
   float c;
   float d;
   float x;
   float y;
}

enum ColorSpace {
   deviceGray = 0,
   deviceRgb,
   deviceCmyk,
   calGray,
   calRgb,
   lab,
   iccBased,
   separation,
   deviceN,
   indexed,
   pattern,
   eof
}

struct HaruRGBColor {
   float r;
   float g;
   float b;
}

struct HaruCMYKColor {
   float c;
   float m;
   float y;
   float k;
}

/// The line cap style
enum HaruLineCap {
   buttEnd = 0,
   roundEnd,
   projectingScuareEnd,
   lineCapEof
}

/// The line join style 
enum HaruLineJoin {
   miterJoin = 0,
   roundJoin,
   bevelJoin,
}

/// The text rendering mode 
enum HaruTextRenderingMode {
   fill = 0,
   stroke,
   fillThenStroke,
   invisible,
   fillClipping,
   strokeClipping,
   fillStrokeClipping,
   clipping
}

enum HaruWritingMode {
   horizontal = 0,
   vertical,
   eof
}

enum PageLayout {
   single = 0,
   oneColumn,
   twoColumnLeft,
   twoColumnRight,
   eof
}


/**
 * Compression mode
 */
enum CompressionMode: uint {
   /// No compression.
   none = 0x0,
   /// Compress the contents stream of the page.
   text = 0x01,
   /// Compress the streams of the image objects.
   image = 0x02,
   /// Other stream datas (fonts, cmaps and so on) are compressed.
   metadata = 0x04,
   /// All stream datas are compressed
   all = 0x0F
}

enum PageMode: uint {
   useNone = 0,
   useOutline,
   useThumbs,
   fullScreen,
   modeEof
}

enum PageNumStyle {
   decimal = 0,
   upperRoman,
   lowerRoman,
   upperLetters,
   lowerLetters,
   eof
}

enum DestinationType {
   xyz = 0,
   fit,
   fitH,
   fitV,
   fitR,
   fitB,
   fitBh,
   fitBv,
   eof
}

enum HaruAnnotType {
   textNotes,
   link,
   sound,
   freeText,
   stamp,
   square,
   circle,
   strikeOut,
   hightlight,
   underline,
   ink,
   fileAttachment,
   popup,
   _3D
}

enum HaruAnnotFlgs {
   invisible,
   hidden,
   print,
   nozoom,
   norotate,
   noview,
   readonly
}

enum HaruAnnotHighlightMode {
   noHightlight = 0,
   invertBox,
   invertBorder,
   downAppearance,
   hightlightModeEof
}

enum HaruAnnotIcon {
   comment = 0,
   key,
   note,
   help,
   newParagraph,
   paragraph,
   insert,
   eof
}

// border stype 
enum HaruBSSubtype {
   solid,
   dashed,
   beveled,
   inset,
   underlined
}

// blend modes 
enum HaruBlendMode {
   normal,
   multiply,
   screen,
   overlay,
   darken,
   lighten,
   colorDodge,
   colorBum,
   hardLight,
   softLight,
   difference,
   exclushon,
   eof
}

/// slide show 
enum HaruTransitionStyle {
   wipeRight = 0,
   wipeUp,
   wipeLeft,
   wipeDown,
   barnDoorsHorizontalOut,
   barnDoorsHorizontalIn,
   barnDoorsVerticalOut,
   barnDoorsVerticalIn,
   boxOut,
   boxIn,
   blindsHorizontal,
   blindsVertical,
   dissolve,
   glitterRight,
   glitterDown,
   glittertoplefttobottomright,
   replace,
   eof
}

enum PageSizes {
   letter = 0,
   legal,
   A3,
   A4,
   A5,
   B4,
   B5,
   executive,
   us4x6,
   us4x8,
   us5x7,
   comm10,
}

enum PageDirection {
   portrait = 0,
   landscape
}

enum HaruEncoderType {
   singleByte,
   doubleByte,
   uninitialized,
   unknown
}

enum HaruByteType {
   single = 0,
   lead,
   trial,
   unknown
}

enum HaruTextAlignment {
   left = 0,
   right,
   center,
   justify
}

/**
  Permission flags (only Revision 2 is supported)
 */
enum HaruPermission: uint {
   ///  user can read the document
   read = 0, 
   /// user can print the document
   print = 4,
   /// user can add or modify the annotations and form fields of the document
   editAll = 8,
   /// user can copy the text and the graphics of the document
   copy = 16,
   /// user can edit the contents of the document other than annotations, form fields
   edit = 32
}

/**
 * Graphics mode
 */
enum GMode: ushort {
   unknown = 0,
   pageDescription = 0x0001,
   pathObject = 0x0002,
   textObject = 0x0004,
   clippingPath = 0x0008,
   shading = 0x0010,
   inlineImage = 0x0020,
   externalObject = 0x0040
}
