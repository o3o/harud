/**
* This module defines error code and functions related to exceptions and general error handling. 
*/
module harud.error;

/* error-code */
enum uint ARRAY_COUNT_ERR = 0x1001;
enum uint ARRAY_ITEM_NOT_FOUND = 0x1002;
enum uint ARRAY_ITEM_UNEXPECTED_TYPE = 0x1003;
enum uint BINARY_LENGTH_ERR = 0x1004;
enum uint CANNOT_GET_PALLET = 0x1005;
enum uint DICT_COUNT_ERR = 0x1007;
enum uint DICT_ITEM_NOT_FOUND = 0x1008;
enum uint DICT_ITEM_UNEXPECTED_TYPE = 0x1009;
enum uint DICT_STREAM_LENGTH_NOT_FOUND = 0x100A;
enum uint DOC_ENCRYPTDICT_NOT_FOUND = 0x100B;
enum uint DOC_INVALID_OBJECT = 0x100C;
/* = 0x100D */
enum uint DUPLICATE_REGISTRATION = 0x100E;
enum uint EXCEED_JWW_CODE_NUM_LIMIT = 0x100F;
/* = 0x1010 */
enum uint ENCRYPT_INVALID_PASSWORD = 0x1011;
/* = 0x1012 */
enum uint ERR_UNKNOWN_CLASS = 0x1013;
enum uint EXCEED_GSTATE_LIMIT = 0x1014;
enum uint FAILD_TO_ALLOC_MEM = 0x1015;
enum uint FILE_IO_ERROR = 0x1016;
enum uint FILE_OPEN_ERROR = 0x1017;
/* = 0x1018 */
enum uint FONT_EXISTS = 0x1019;
enum uint FONT_INVALID_WIDTHS_TABLE = 0x101A;
enum uint INVALID_AFM_HEADER = 0x101B;
enum uint INVALID_ANNOTATION = 0x101C;
/* = 0x101D */
enum uint INVALID_BIT_PER_COMPONENT = 0x101E;
enum uint INVALID_CHAR_MATRICS_DATA = 0x101F;
enum uint INVALID_COLOR_SPACE = 0x1020;
enum uint INVALID_COMPRESSION_MODE = 0x1021;
enum uint INVALID_DATE_TIME = 0x1022;
enum uint INVALID_DESTINATION = 0x1023;
/* = 0x1024 */
enum uint INVALID_DOCUMENT = 0x1025;
enum uint INVALID_DOCUMENT_STATE = 0x1026;
enum uint INVALID_ENCODER = 0x1027;
enum uint INVALID_ENCODER_TYPE = 0x1028;
/* = 0x1029 */;
/* = 0x102A */
enum uint INVALID_ENCODING_NAME = 0x102B;
enum uint INVALID_ENCRYPT_KEY_LEN = 0x102C;
enum uint INVALID_FONTDEF_DATA = 0x102D;
enum uint INVALID_FONTDEF_TYPE = 0x102E;
enum uint INVALID_FONT_NAME = 0x102F;
enum uint INVALID_IMAGE = 0x1030;
enum uint INVALID_JPEG_DATA = 0x1031;
enum uint INVALID_N_DATA = 0x1032;
enum uint INVALID_OBJECT = 0x1033;
enum uint INVALID_OBJ_ID = 0x1034;
enum uint INVALID_OPERATION = 0x1035;
enum uint INVALID_OUTLINE = 0x1036;
enum uint INVALID_PAGE = 0x1037;
enum uint INVALID_PAGES = 0x1038;
enum uint INVALID_PARAMETER = 0x1039;
/* = 0x103A */
enum uint INVALID_PNG_IMAGE = 0x103B;
enum uint INVALID_STREAM = 0x103C;
enum uint MISSING_FILE_NAME_ENTRY = 0x103D;
/* = 0x103E */
enum uint INVALID_TTC_FILE = 0x103F;
enum uint INVALID_TTC_INDEX = 0x1040;
enum uint INVALID_WX_DATA = 0x1041;
enum uint ITEM_NOT_FOUND = 0x1042;
enum uint LIBPNG_ERROR = 0x1043;
enum uint NAME_INVALID_VALUE = 0x1044;
enum uint NAME_OUT_OF_RANGE = 0x1045;
/* = 0x1046 */
/* = 0x1047 */
enum uint PAGE_INVALID_PARAM_COUNT = 0x1048;
enum uint PAGES_MISSING_KIDS_ENTRY = 0x1049;
enum uint PAGE_CANNOT_FIND_OBJECT = 0x104A;
enum uint PAGE_CANNOT_GET_ROOT_PAGES = 0x104B;
enum uint PAGE_CANNOT_RESTORE_GSTATE = 0x104C;
enum uint PAGE_CANNOT_SET_PARENT = 0x104D;
enum uint PAGE_FONT_NOT_FOUND = 0x104E;
enum uint PAGE_INVALID_FONT = 0x104F;
enum uint PAGE_INVALID_FONT_SIZE = 0x1050;
enum uint PAGE_INVALID_GMODE = 0x1051;
enum uint PAGE_INVALID_INDEX = 0x1052;
enum uint PAGE_INVALID_ROTATE_VALUE = 0x1053;
enum uint PAGE_INVALID_SIZE = 0x1054;
enum uint PAGE_INVALID_XOBJECT = 0x1055;
enum uint PAGE_OUT_OF_RANGE = 0x1056;
enum uint REAL_OUT_OF_RANGE = 0x1057;
enum uint STREAM_EOF = 0x1058;
enum uint STREAM_READLN_CONTINUE = 0x1059;
/* = 0x105A */
enum uint STRING_OUT_OF_RANGE = 0x105B;
enum uint THIS_FUNC_WAS_SKIPPED = 0x105C;
enum uint TTF_CANNOT_EMBEDDING_FONT = 0x105D;
enum uint TTF_INVALID_CMAP = 0x105E;
enum uint TTF_INVALID_FOMAT = 0x105F;
enum uint TTF_MISSING_TABLE = 0x1060;
enum uint UNSUPPORTED_FONT_TYPE = 0x1061;
enum uint UNSUPPORTED_FUNC = 0x1062;
enum uint UNSUPPORTED_JPEG_FORMAT = 0x1063;
enum uint UNSUPPORTED_TYPE1_FONT = 0x1064;
enum uint XREF_COUNT_ERR = 0x1065;
enum uint ZLIB_ERROR = 0x1066;
enum uint INVALID_PAGE_INDEX = 0x1067;
enum uint INVALID_URI = 0x1068;
enum uint PAGE_LAYOUT_OUT_OF_RANGE = 0x1069;
enum uint PAGE_MODE_OUT_OF_RANGE = 0x1070;
enum uint PAGE_NUM_STYLE_OUT_OF_RANGE = 0x1071;
enum uint ANNOT_INVALID_ICON = 0x1072;
enum uint ANNOT_INVALID_BORDER_STYLE = 0x1073;
enum uint PAGE_INVALID_DIRECTION = 0x1074;
enum uint INVALID_FONT = 0x1075;
enum uint PAGE_INSUFFICIENT_SPACE = 0x1076;
enum uint PAGE_INVALID_DISPLAY_TIME = 0x1077;
enum uint PAGE_INVALID_TRANSITION_TIME = 0x1078;
enum uint INVALID_PAGE_SLIDESHOW_TYPE = 0x1079;
enum uint EXT_GSTATE_OUT_OF_RANGE = 0x1080;
enum uint INVALID_EXT_GSTATE = 0x1081;
enum uint EXT_GSTATE_READ_ONLY = 0x1082;
enum uint INVALID_U3D_DATA = 0x1083;
enum uint NAME_CANNOT_GET_NAMES = 0x1084;
enum uint INVALID_ICC_COMPONENT_NUM = 0x1085;

/**
* Returns a error description from error code
*
* Params:  errorNo = error number
*			 
*
* Returns: Error description value
*/
string getErrorDescription(uint errorNo) {
   switch (errorNo) {
      case ARRAY_COUNT_ERR: return "Array count err";
      case ARRAY_ITEM_NOT_FOUND: return "Array item not found";
      case ARRAY_ITEM_UNEXPECTED_TYPE: return "Array item unexpected type";
      case BINARY_LENGTH_ERR: return "Binary length error";
      case CANNOT_GET_PALLET: return "Cannot get pallet";
      case DICT_COUNT_ERR: return "Dict count err";
      case DICT_ITEM_NOT_FOUND: return "Dict item not found";
      case DICT_ITEM_UNEXPECTED_TYPE: return "Dict item unexpected type";
      case DICT_STREAM_LENGTH_NOT_FOUND: return "Dict stream length not found";
      case DOC_ENCRYPTDICT_NOT_FOUND: return "Doc encryptdict not found";
      case DOC_INVALID_OBJECT: return "Doc invalid object";
      case DUPLICATE_REGISTRATION: return "Duplicate registration";
      case EXCEED_JWW_CODE_NUM_LIMIT: return "Exceed JWW code num limit";
      case ENCRYPT_INVALID_PASSWORD: return "Encrypt invalid password";
      case ERR_UNKNOWN_CLASS: return "Err unknown class";
      case EXCEED_GSTATE_LIMIT: return "Exceed gstate limit";
      case FAILD_TO_ALLOC_MEM: return "Faild to alloc mem";
      case FILE_IO_ERROR: return "File IO error";
      case FILE_OPEN_ERROR: return "File open error";
      case FONT_EXISTS: return "Font exists";
      case FONT_INVALID_WIDTHS_TABLE: return "Font invalid widths table";
      case INVALID_AFM_HEADER: return "Invalid afm header";
      case INVALID_ANNOTATION: return "Invalid annotation";
      case INVALID_BIT_PER_COMPONENT: return "Invalid bit per component";
      case INVALID_CHAR_MATRICS_DATA: return "Invalid char matrics data";
      case INVALID_COLOR_SPACE: return "Invalid color space";
      case INVALID_COMPRESSION_MODE: return "Invalid compression mode";
      case INVALID_DATE_TIME: return "Invalid date time";
      case INVALID_DESTINATION: return "Invalid destination";
      case INVALID_DOCUMENT: return "Invalid document";
      case INVALID_DOCUMENT_STATE: return "Invalid document state";
      case INVALID_ENCODER: return "Invalid encoder";
      case INVALID_ENCODER_TYPE: return "Invalid encoder type";
      case INVALID_ENCODING_NAME: return "Invalid encoding name";
      case INVALID_ENCRYPT_KEY_LEN: return "Invalid encrypt key len";
      case INVALID_FONTDEF_DATA: return "Invalid fontdef data";
      case INVALID_FONTDEF_TYPE: return "Invalid fontdef type";
      case INVALID_FONT_NAME: return "Invalid font name";
      case INVALID_IMAGE: return "Invalid image";
      case INVALID_JPEG_DATA: return "Invalid JPEG data";
      case INVALID_N_DATA: return "Invalid n data";
      case INVALID_OBJECT: return "Invalid object";
      case INVALID_OBJ_ID: return "Invalid object id";
      case INVALID_OPERATION: return "Invalid operation";
      case INVALID_OUTLINE: return "Invalid outline";
      case INVALID_PAGE: return "Invalid page";
      case INVALID_PAGES: return "Invalid pages";
      case INVALID_PARAMETER: return "Invalid parameter";
      case INVALID_PNG_IMAGE: return "Invalid PNG image";
      case INVALID_STREAM: return "Invalid stream";
      case MISSING_FILE_NAME_ENTRY: return "Missing file name entry";
      case INVALID_TTC_FILE: return "Invalid TTC file";
      case INVALID_TTC_INDEX: return "Invalid TTC index";
      case INVALID_WX_DATA: return "Invalid wx data";
      case ITEM_NOT_FOUND: return "Item not found";
      case LIBPNG_ERROR: return "Libpng error";
      case NAME_INVALID_VALUE: return "Name invalid value";
      case NAME_OUT_OF_RANGE: return "Name out of range";
      case PAGE_INVALID_PARAM_COUNT: return "Page invalid param count";
      case PAGES_MISSING_KIDS_ENTRY: return "Pages missing kids entry";
      case PAGE_CANNOT_FIND_OBJECT: return "Page cannot find object";
      case PAGE_CANNOT_GET_ROOT_PAGES: return "Page cannot get root pages";
      case PAGE_CANNOT_RESTORE_GSTATE: return "Page cannot restore gstate";
      case PAGE_CANNOT_SET_PARENT: return "Page cannot set parent";
      case PAGE_FONT_NOT_FOUND: return "Page font not found";
      case PAGE_INVALID_FONT: return "Page invalid font";
      case PAGE_INVALID_FONT_SIZE: return "Page invalid font size";
      case PAGE_INVALID_GMODE: return "Page invalid gmode";
      case PAGE_INVALID_INDEX: return "Page invalid index";
      case PAGE_INVALID_ROTATE_VALUE: return "Page invalid rotate value";
      case PAGE_INVALID_SIZE: return "Page invalid size";
      case PAGE_INVALID_XOBJECT: return "Page invalid xobject";
      case PAGE_OUT_OF_RANGE: return "Page out of range";
      case REAL_OUT_OF_RANGE: return "Real out of range";
      case STREAM_EOF: return "Stream EOF";
      case STREAM_READLN_CONTINUE: return "Stream readln continue";
      case STRING_OUT_OF_RANGE: return "String out of range";
      case THIS_FUNC_WAS_SKIPPED: return "This function was skipped";
      case TTF_CANNOT_EMBEDDING_FONT: return "TTF cannot embedding font";
      case TTF_INVALID_CMAP: return "TTF invalid cmap";
      case TTF_INVALID_FOMAT: return "TTF invalid fomat";
      case TTF_MISSING_TABLE: return "TTF missing table";
      case UNSUPPORTED_FONT_TYPE: return "Unsupported font type";
      case UNSUPPORTED_FUNC: return "Unsupported func";
      case UNSUPPORTED_JPEG_FORMAT: return "Unsupported jpeg format";
      case UNSUPPORTED_TYPE1_FONT: return "Unsupported type1_font";
      case XREF_COUNT_ERR: return "Xref count err";
      case ZLIB_ERROR: return "ZLIB error";
      case INVALID_PAGE_INDEX: return "Invalid page index";
      case INVALID_URI: return "Invalid URI";
      case PAGE_LAYOUT_OUT_OF_RANGE: return "Page layout out of range";
      case PAGE_MODE_OUT_OF_RANGE: return "Page mode out of range";
      case PAGE_NUM_STYLE_OUT_OF_RANGE: return "Page num style out of range";
      case ANNOT_INVALID_ICON: return "Annot invalid icon";
      case ANNOT_INVALID_BORDER_STYLE: return "Annot invalid border style";
      case PAGE_INVALID_DIRECTION: return "Page invalid direction";
      case INVALID_FONT: return "Invalid font";
      case PAGE_INSUFFICIENT_SPACE: return "Page insufficient space";
      case PAGE_INVALID_DISPLAY_TIME: return "Page invalid display time";
      case PAGE_INVALID_TRANSITION_TIME: return "Page invalid transition time";
      case INVALID_PAGE_SLIDESHOW_TYPE: return "Invalid page slideshow type";
      case EXT_GSTATE_OUT_OF_RANGE: return "Ext gstate out of range";
      case INVALID_EXT_GSTATE: return "Invalid ext gstate";
      case EXT_GSTATE_READ_ONLY: return "Ext gstate read only";
      case INVALID_U3D_DATA: return "Invalid U3D data";
      case NAME_CANNOT_GET_NAMES: return "Name cannot get names";
      case INVALID_ICC_COMPONENT_NUM: return "Invalid ICc component num";

      default: return "Unknown";
   }
}

/**
* Thrown if errors that set errno occur.
*/
class HarudException: Exception {
   this(uint errCode) {
      this.errCode = errCode;
      super(getErrorDescription(errCode));
   }

   this(string msg, string file = __FILE__, int line = __LINE__) {
      super(msg, file, line);
   }
   
   private uint _errCode;
   @property uint errCode() const pure nothrow { return _errCode; }
   @property void errCode(uint rhs) pure nothrow { _errCode = rhs; }
}
