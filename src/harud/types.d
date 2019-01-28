///
module harud.types;

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

/** Point struct */
struct Point {
   /// x coordinate
   float x;
   /// y coordinate
   float y;
}

/**
 * Rectangle
 *
 * --------------------
 *        ^
 * top    |   +--------+
 *        |   |        |
 * bottom |   +--------+
 *        +-------------->
 *           left     right
 *
 * --------------------
 */
struct Rect {
   /**
    * The x-coordinates of bottom left corner
    */
   float left;
   /**
    * The y-coordinates of bottom left corner
    */
   float bottom;
   /**
    * The x-coordinates of top right corner
    */
   float right;

   /**
    * The y-coordinates of top right corner
    */
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
   keywords
}

enum PdfVer {
   V12 = 0,
   V13,
   V14,
   V15,
   V16,
   V17
}

/**
 * Encrypt mode
 */
enum HaruEncryptMode {
   /// Use "Revision 2" algorithm. "keyLen" automatically set to 5 (40 bits).
   R2 = 2,
   /// Use "Revision 3" algorithm. "keyLen" can be 5 (40 bits) to 16 (128bits).
   R3 = 3
}

/**
 * Describes a text width
 */
struct TextWidth {
   uint numchars;

   /** don't use this value (it may be change in the feature).
     use numspace as alternated. */
   uint numwords;

   uint width;
   uint numspace;
}

struct DashMode {
   ushort[8] ptn;
   uint numPtn;
   uint phase;
}


/**
* For certain types of drawing operations you may want to adjust (or transform, which is the proper term) the coordinates in some way
* The part of the graphic state that tracks this is called the current transformation matrix (CTM).
*
* To apply a transformation, you use the cm operator, which takes six operands
* that represent a standard 3x2 matrix.
*
* --------------
* | Transformation | Operand                  |
* | ---            | ---                      |
* | Translation    | 1 0 0 1 tx ty            |
* | Rotation       | cosQ sinQ -sinQ cosQ 0 0 |
* | Skew           | 1 tanA tabB 1 0 0        |
* --------------
*/

struct TransMatrix {
   float a;
   float b;
   float c;
   float d;
   float x;
   float y;
}

/**
 * The color space of the image.
 */
enum ColorSpace {
   /**
    * 8 bit gray scale image.$(BR)
    * The gray scale describes each pixel with one byte. $(BR)
    * For each byte, 0X00 is maximum dark, 0XFF maximum light. The size of the
    * image data is (width * height) bytes.$(BR)
    * The sequence of bytes for an 8-pixel 8-bit image with 2 rows and 4 columns would be:
    * -----
    * 1   2   3   4
    * 5   6   7   8
    * ----
    */
   deviceGray = 0,

   /**
    * The RGB color model is an additive color model in which red, green, and
    * blue light are added together in various ways to reproduce a broad array
    * of colors. $(BR)
    * The 24 bit RGB color image describes each pixel with three bytes (Red,
    * Green, Blue). $(BR)
    * For each byte, 0X00 is maximum dark, 0XFF maximum light. The size of the image data is (width * height * 3) bytes.
    * The sequence of bytes for an 8-pixel 24-bit image with 2 rows and 4 columns would be:
    * ---
    * 1R 1G 1B  2R 2G 2B  3R 3G 3B  4R 4G 4B
    * 5R 5G 5B  6R 6G 6B  7R 7G 7B  8R 8G 8B
    * ---
    */
   deviceRGB,
   /**
    * The CMYK color model (process color, four color) is a subtractive color
    * model, used in color printing, and is also used to describe the printing
    * process itself. $(BR)
    * The 32 bit CMYK color image describes each pixel with four bytes (Cyan,
    * Magenta, Yellow, Black). $(BR)
    * The size of the image data is (width * height * 4) bytes. For each byte,
    * 0X00 is maximum dark, 0XFF maximum light.$(BR)
    * The sequence of bytes for an 8-pixel 32-bit image with 2 rows and 4 columns would be:
    * ---
    * 1C 1M 1Y 1K  2C 2M 2Y 2K  3C 3M 3Y 3K  4C 4M 4Y 4K
    * 5C 5M 5Y 5K  6C 6M 6Y 6K  7C 7M 7Y 7K  8C 8M 8Y 8K
    * ---
    */
   deviceCMYK,
   calGray,
   calRGB,
   lab,
   iccBased,
   separation,
   deviceN,
   indexed,
   pattern
}

struct HaruRGBColor {
   float red;
   float green;
   float blue;
}

struct HaruCMYKColor {
   float cyan;
   float magenta;
   float yellow;
   float key;
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

/// Writing mode
enum HaruWritingMode {
   horizontal = 0,
   vertical,
}

/**
 * The page layout enum
 */
enum PageLayout {
   /// Only one page is displayed.
   single = 0,
   /// Display the pages in one column.
   oneColumn,
   /// Display in two columns. Odd page number is displayed left
   twoColumnLeft,
   /// Display in two columns. Odd page number is displayed right
   twoColumnRight,
}

/**
 * Compression mode
 */
enum CompressionMode : uint {
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

/**
 * PageMode enum
 */
enum PageMode : uint {
   /// Display the document with neither outline nor thumbnail.
   useNone = 0,
   /// Display the document with outline pane.
   useOutline,
   /// Display the document with thumbnail pane.
   useThumbs,
   /// Display the document with full screen mode.
   fullScreen
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
   insert
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
   exclushon
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
   replace
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
   comm10
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

/**
 * Byte type enum
 */
enum HaruByteType {
   single = 0,
   lead,
   trial,
   unknown
}

/**
 * Text alignment
 */
enum HaruTextAlignment {
   left = 0,  /** The text is aligned to left. */
   right,     /** The text is aligned to right. */
   center,    /** The text is aligned to center. */
   justify    /** Add spaces between the words to justify both left and right side. */
}

/**
 * Permission flags (only Revision 2 is supported)
 */
enum HaruPermission : uint {
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
 *
 * Each page object maintains a flag named "graphics mode".
 * The graphics mode corresponds to the graphics-object of the PDF specification.
 * The graphics mode is changed by invoking particular functions.
 * The functions that can be invoked are decided by the value of the graphics mode.
 *
 */
enum GMode : ushort {
   unknown = 0,
   /**
    * Allowed operators:
    * $(UL
    *   $(LI General graphic state)
    *   $(LI Special graphic state)
    *   $(LI Color)
    *   $(LI Text state)
    * )
    */
   pageDescription = 0x0001,
   /**
    * Allowed operators:
    * $(UL
    *   $(LI Path construction)
    * )
    */
   pathObject = 0x0002,
   /**
    * Allowed operators:
    * $(UL
    *   $(LI Graphic state)
    *   $(LI Color)
    *   $(LI Text state)
    *   $(LI Text-shadowing)
    *   $(LI Text-positioning)
    * )
    */
   textObject = 0x0004,

   clippingPath = 0x0008,
   shading = 0x0010,
   inlineImage = 0x0020,
   externalObject = 0x0040
}
