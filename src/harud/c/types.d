module harud.c.types;

extern(C) {
   alias void HPDF_Error_Handler(HPDF_STATUS error_no, HPDF_STATUS detail_no, void* user_data);

   /**
     alias void* function  (HPDF_STATUS error_no,
     HPDF_STATUS detail_no,
     void* user_data)
     HPDF_Error_Handler;
    */

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


   /* native OS integer types */
   alias HPDF_INT = int;
   alias HPDF_UINT = uint;


   /* 32bit integer types
    */
   alias HPDF_INT32 = int;
   alias HPDF_UINT32 = uint;


   /* 16bit integer types
    */
   alias HPDF_INT16 = short;
   alias HPDF_UINT16 = ushort;


   /* 8bit integer types
    */
   alias HPDF_INT8 = byte;
   alias HPDF_UINT8 = ubyte;


   /* 8bit binary types
    */
   alias HPDF_BYTE = ubyte;


   /* float type (32bit IEEE754)
    */
   alias HPDF_REAL = float;


   /* double type (64bit IEEE754)
    */
   alias HPDF_DOUBLE = double;


   /* boolean type (0: False, !0: True)
    */
   alias HPDF_BOOL = int;


   /* error-no type (32bit unsigned integer)
    */
   alias HPDF_STATUS = uint;


   /* charactor-code type (16bit)
    */
   alias HPDF_CID = HPDF_UINT16;
   alias HPDF_UNICODE = HPDF_UINT16;


   /* HPDF_Point struct
    */
   struct HaruPoint {
      HPDF_REAL x;
      HPDF_REAL y;
   }

   struct HaruRect {
      HPDF_REAL left;
      HPDF_REAL bottom;
      HPDF_REAL right;
      HPDF_REAL top;
   }

   alias HaruBox = HaruRect;

   /* HPDF_Date struct
    */
   struct HaruDate {
      HPDF_INT year;
      HPDF_INT month;
      HPDF_INT day;
      HPDF_INT hour;
      HPDF_INT minutes;
      HPDF_INT seconds;
      byte ind;
      HPDF_INT off_hour;
      HPDF_INT off_minutes;
   }


   enum HaruInfoType {
      /* date-time type parameters */
      CREATION_DATE = 0,
      MOD_DATE,

      /* string type parameters */
      AUTHOR,
      CREATOR,
      PRODUCER,
      TITLE,
      SUBJECT,
      KEYWORDS,
      EOF
   }


   enum HaruPdfVer {
      V12 = 0,
      V13,
      V14,
      V15,
      V16,
      V17,
      EOF
   }

   enum HaruEncryptMode {
      R2 = 2,
      R3 = 3
   }

   /**
     typedef void
     (HPDF_STDCALL *HPDF_Error_Handler)  (HPDF_STATUS error_no,
     HPDF_STATUS detail_no,
     void         *user_data);

     typedef void*
     (HPDF_STDCALL *HPDF_Alloc_Func)  (HPDF_UINT size);


     typedef void
     (HPDF_STDCALL *HPDF_Free_Func)  (void  *aptr);
    */

   /*------ text width struct --------------------------------------------------*/

   struct HaruTextWidth {
      HPDF_UINT numchars;

      /* don't use this value (it may be change in the feature).
         use numspace as alternated. */
      HPDF_UINT numwords;

      HPDF_UINT width;
      HPDF_UINT numspace;
   }


   /*------ dash mode ----------------------------------------------------------*/
   struct HaruDashMode {
      HPDF_UINT16 ptn[8];
      HPDF_UINT num_ptn;
      HPDF_UINT phase;
   }


   /*----- HPDF_TransMatrix struct ---------------------------------------------*/

   struct HaruTransMatrix {
      HPDF_REAL a;
      HPDF_REAL b;
      HPDF_REAL c;
      HPDF_REAL d;
      HPDF_REAL x;
      HPDF_REAL y;
   }

   enum HaruColorSpace {
      DEVICE_GRAY = 0,
      DEVICE_RGB,
      DEVICE_CMYK,
      CAL_GRAY,
      CAL_RGB,
      LAB,
      ICC_BASED,
      SEPARATION,
      DEVICE_N,
      INDEXED,
      PATTERN,
      EOF
   }

   /*----- HPDF_RGBColor struct ------------------------------------------------*/

   struct HaruRGBColor {
      HPDF_REAL r;
      HPDF_REAL g;
      HPDF_REAL b;
   }

   struct HaruCMYKColor {
      HPDF_REAL c;
      HPDF_REAL m;
      HPDF_REAL y;
      HPDF_REAL k;
   }

   /*------ The line cap style -------------------------------------------------*/
   enum HaruLineCap {
      BUTT_END = 0,
      ROUND_END,
      PROJECTING_SCUARE_END,
      LINECAP_EOF
   }

   /*------ The line join style -------------------------------------------------*/
   enum HaruLineJoin {
      MITER_JOIN = 0,
      ROUND_JOIN,
      BEVEL_JOIN,
      LINEJOIN_EOF
   }

   /*------ The text rendering mode ---------------------------------------------*/
   enum HaruTextRenderingMode {
      FILL = 0,
      STROKE,
      FILL_THEN_STROKE,
      INVISIBLE,
      FILL_CLIPPING,
      STROKE_CLIPPING,
      FILL_STROKE_CLIPPING,
      CLIPPING,
      RENDERING_MODE_EOF
   }


   enum HaruWritingMode {
      HORIZONTAL = 0,
      VERTICAL,
      EOF
   }

   enum PageLayout {
      SINGLE = 0,
      ONE_COLUMN,
      TWO_COLUMN_LEFT,
      TWO_COLUMN_RIGHT,
      EOF
   }

   enum CompressionMode: HPDF_UINT {
      none = 0x0,
      text = 0x01,
      image = 0x02,
      metadata = 0x04,
      all = 0x0F
   }

   enum PageMode: HPDF_UINT {
      useNone = 0,
      useOutline,
      useThumbs,
      fullScreen,
      modeEof
   }

   enum PageNumStyle {
      DECIMAL = 0,
      UPPER_ROMAN,
      LOWER_ROMAN,
      UPPER_LETTERS,
      LOWER_LETTERS,
      EOF
   }

   enum HaruDestinationType {
      XYZ = 0,
      FIT,
      FIT_H,
      FIT_V,
      FIT_R,
      FIT_B,
      FIT_BH,
      FIT_BV,
      DST_EOF
   }

   enum HaruAnnotType {
      TEXT_NOTES,
      LINK,
      SOUND,
      FREE_TEXT,
      STAMP,
      SQUARE,
      CIRCLE,
      STRIKE_OUT,
      HIGHTLIGHT,
      UNDERLINE,
      INK,
      FILE_ATTACHMENT,
      POPUP,
      _3D
   }

   enum HaruAnnotFlgs {
      INVISIBLE,
      HIDDEN,
      PRINT,
      NOZOOM,
      NOROTATE,
      NOVIEW,
      READONLY
   }

   enum HaruAnnotHighlightMode {
      NO_HIGHTLIGHT = 0,
      INVERT_BOX,
      INVERT_BORDER,
      DOWN_APPEARANCE,
      HIGHTLIGHT_MODE_EOF
   }

   enum HaruAnnotIcon {
      COMMENT = 0,
      KEY,
      NOTE,
      HELP,
      NEW_PARAGRAPH,
      PARAGRAPH,
      INSERT,
      EOF
   }

   /*------ border stype --------------------------------------------------------*/
   enum HaruBSSubtype {
      SOLID,
      DASHED,
      BEVELED,
      INSET,
      UNDERLINED
   }

   /*----- blend modes ----------------------------------------------------------*/
   enum HaruBlendMode {
      NORMAL,
      MULTIPLY,
      SCREEN,
      OVERLAY,
      DARKEN,
      LIGHTEN,
      COLOR_DODGE,
      COLOR_BUM,
      HARD_LIGHT,
      SOFT_LIGHT,
      DIFFERENCE,
      EXCLUSHON,
      EOF
   }

   /*----- slide show -----------------------------------------------------------*/
   enum HaruTransitionStyle {
      WIPE_RIGHT = 0,
      WIPE_UP,
      WIPE_LEFT,
      WIPE_DOWN,
      BARN_DOORS_HORIZONTAL_OUT,
      BARN_DOORS_HORIZONTAL_IN,
      BARN_DOORS_VERTICAL_OUT,
      BARN_DOORS_VERTICAL_IN,
      BOX_OUT,
      BOX_IN,
      BLINDS_HORIZONTAL,
      BLINDS_VERTICAL,
      DISSOLVE,
      GLITTER_RIGHT,
      GLITTER_DOWN,
      GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT,
      REPLACE,
      EOF
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
      eof
   }

   enum PageDirection {
      portrait = 0,
      landscape
   }

   enum HaruEncoderType {
      SINGLE_BYTE,
      DOUBLE_BYTE,
      UNINITIALIZED,
      UNKNOWN
   }

   enum HaruByteType {
      SINGLE = 0,
      LEAD,
      TRIAL,
      UNKNOWN
   }

   enum HaruTextAlignment {
      LEFT = 0,
      RIGHT,
      CENTER,
      JUSTIFY
   }
}
