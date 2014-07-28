module harud.c.error;

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


string getErrorDescription(uint errorNo) {
   switch (errorNo) {
      case ARRAY_COUNT_ERR: return "ARRAY_COUNT_ERR";
      case ARRAY_ITEM_NOT_FOUND: return "ARRAY_ITEM_NOT_FOUND";
      case ARRAY_ITEM_UNEXPECTED_TYPE: return
                                            "ARRAY_ITEM_UNEXPECTED_TYPE";
      case BINARY_LENGTH_ERR: return "BINARY_LENGTH_ERR";
      case CANNOT_GET_PALLET: return "CANNOT_GET_PALLET";
      case DICT_COUNT_ERR: return "DICT_COUNT_ERR";
      case DICT_ITEM_NOT_FOUND: return "DICT_ITEM_NOT_FOUND";
      case DICT_ITEM_UNEXPECTED_TYPE: return
                                           "DICT_ITEM_UNEXPECTED_TYPE";
      case DICT_STREAM_LENGTH_NOT_FOUND: return
                                              "DICT_STREAM_LENGTH_NOT_FOUND";
      case DOC_ENCRYPTDICT_NOT_FOUND: return
                                           "DOC_ENCRYPTDICT_NOT_FOUND";
      case DOC_INVALID_OBJECT: return "DOC_INVALID_OBJECT";
      case DUPLICATE_REGISTRATION: return "DUPLICATE_REGISTRATION";
      case EXCEED_JWW_CODE_NUM_LIMIT: return
                                           "EXCEED_JWW_CODE_NUM_LIMIT";
      case ENCRYPT_INVALID_PASSWORD: return
                                          "ENCRYPT_INVALID_PASSWORD";
      case ERR_UNKNOWN_CLASS: return "ERR_UNKNOWN_CLASS";
      case EXCEED_GSTATE_LIMIT: return "EXCEED_GSTATE_LIMIT";
      case FAILD_TO_ALLOC_MEM: return "FAILD_TO_ALLOC_MEM";
      case FILE_IO_ERROR: return "FILE_IO_ERROR";
      case FILE_OPEN_ERROR: return "FILE_OPEN_ERROR";
      case FONT_EXISTS: return "FONT_EXISTS";
      case FONT_INVALID_WIDTHS_TABLE: return
                                           "FONT_INVALID_WIDTHS_TABLE";
      case INVALID_AFM_HEADER: return "INVALID_AFM_HEADER";
      case INVALID_ANNOTATION: return "INVALID_ANNOTATION";
      case INVALID_BIT_PER_COMPONENT: return
                                           "INVALID_BIT_PER_COMPONENT";
      case INVALID_CHAR_MATRICS_DATA: return
                                           "INVALID_CHAR_MATRICS_DATA";
      case INVALID_COLOR_SPACE: return "INVALID_COLOR_SPACE";
      case INVALID_COMPRESSION_MODE: return
                                          "INVALID_COMPRESSION_MODE";
      case INVALID_DATE_TIME: return "INVALID_DATE_TIME";
      case INVALID_DESTINATION: return "INVALID_DESTINATION";
      case INVALID_DOCUMENT: return "INVALID_DOCUMENT";
      case INVALID_DOCUMENT_STATE: return "INVALID_DOCUMENT_STATE";
      case INVALID_ENCODER: return "INVALID_ENCODER";
      case INVALID_ENCODER_TYPE: return "INVALID_ENCODER_TYPE";
      case INVALID_ENCODING_NAME: return "INVALID_ENCODING_NAME";
      case INVALID_ENCRYPT_KEY_LEN: return
                                         "INVALID_ENCRYPT_KEY_LEN";
      case INVALID_FONTDEF_DATA: return "INVALID_FONTDEF_DATA";
      case INVALID_FONTDEF_TYPE: return "INVALID_FONTDEF_TYPE";
      case INVALID_FONT_NAME: return "INVALID_FONT_NAME";
      case INVALID_IMAGE: return "INVALID_IMAGE";
      case INVALID_JPEG_DATA: return "INVALID_JPEG_DATA";
      case INVALID_N_DATA: return "INVALID_N_DATA";
      case INVALID_OBJECT: return "INVALID_OBJECT";
      case INVALID_OBJ_ID: return "INVALID_OBJ_ID";
      case INVALID_OPERATION: return "INVALID_OPERATION";
      case INVALID_OUTLINE: return "INVALID_OUTLINE";
      case INVALID_PAGE: return "INVALID_PAGE";
      case INVALID_PAGES: return "INVALID_PAGES";
      case INVALID_PARAMETER: return "INVALID_PARAMETER";
      case INVALID_PNG_IMAGE: return "INVALID_PNG_IMAGE";
      case INVALID_STREAM: return "INVALID_STREAM";
      case MISSING_FILE_NAME_ENTRY: return
                                         "MISSING_FILE_NAME_ENTRY";
      case INVALID_TTC_FILE: return "INVALID_TTC_FILE";
      case INVALID_TTC_INDEX: return "INVALID_TTC_INDEX";
      case INVALID_WX_DATA: return "INVALID_WX_DATA";
      case ITEM_NOT_FOUND: return "ITEM_NOT_FOUND";
      case LIBPNG_ERROR: return "LIBPNG_ERROR";
      case NAME_INVALID_VALUE: return "NAME_INVALID_VALUE";
      case NAME_OUT_OF_RANGE: return "NAME_OUT_OF_RANGE";
      case PAGE_INVALID_PARAM_COUNT: return
                                          "PAGE_INVALID_PARAM_COUNT";
      case PAGES_MISSING_KIDS_ENTRY: return
                                          "PAGES_MISSING_KIDS_ENTRY";
      case PAGE_CANNOT_FIND_OBJECT: return
                                         "PAGE_CANNOT_FIND_OBJECT";
      case PAGE_CANNOT_GET_ROOT_PAGES: return
                                            "PAGE_CANNOT_GET_ROOT_PAGES";
      case PAGE_CANNOT_RESTORE_GSTATE: return
                                            "PAGE_CANNOT_RESTORE_GSTATE";
      case PAGE_CANNOT_SET_PARENT: return "PAGE_CANNOT_SET_PARENT";
      case PAGE_FONT_NOT_FOUND: return "PAGE_FONT_NOT_FOUND";
      case PAGE_INVALID_FONT: return "PAGE_INVALID_FONT";
      case PAGE_INVALID_FONT_SIZE: return "PAGE_INVALID_FONT_SIZE";
      case PAGE_INVALID_GMODE: return "PAGE_INVALID_GMODE";
      case PAGE_INVALID_INDEX: return "PAGE_INVALID_INDEX";
      case PAGE_INVALID_ROTATE_VALUE: return
                                           "PAGE_INVALID_ROTATE_VALUE";
      case PAGE_INVALID_SIZE: return "PAGE_INVALID_SIZE";
      case PAGE_INVALID_XOBJECT: return "PAGE_INVALID_XOBJECT";
      case PAGE_OUT_OF_RANGE: return "PAGE_OUT_OF_RANGE";
      case REAL_OUT_OF_RANGE: return "REAL_OUT_OF_RANGE";
      case STREAM_EOF: return "STREAM_EOF";
      case STREAM_READLN_CONTINUE: return "STREAM_READLN_CONTINUE";
      case STRING_OUT_OF_RANGE: return "STRING_OUT_OF_RANGE";
      case THIS_FUNC_WAS_SKIPPED: return "THIS_FUNC_WAS_SKIPPED";
      case TTF_CANNOT_EMBEDDING_FONT: return
                                           "TTF_CANNOT_EMBEDDING_FONT";
      case TTF_INVALID_CMAP: return "TTF_INVALID_CMAP";
      case TTF_INVALID_FOMAT: return "TTF_INVALID_FOMAT";
      case TTF_MISSING_TABLE: return "TTF_MISSING_TABLE";
      case UNSUPPORTED_FONT_TYPE: return "UNSUPPORTED_FONT_TYPE";
      case UNSUPPORTED_FUNC: return "UNSUPPORTED_FUNC";
      case UNSUPPORTED_JPEG_FORMAT: return
                                         "UNSUPPORTED_JPEG_FORMAT";
      case UNSUPPORTED_TYPE1_FONT: return "UNSUPPORTED_TYPE1_FONT";
      case XREF_COUNT_ERR: return "XREF_COUNT_ERR";
      case ZLIB_ERROR: return "ZLIB_ERROR";
      case INVALID_PAGE_INDEX: return "INVALID_PAGE_INDEX";
      case INVALID_URI: return "INVALID_URI";
      case PAGE_LAYOUT_OUT_OF_RANGE: return "PAGE_LAYOUT_OUT_OF_RANGE";
      case PAGE_MODE_OUT_OF_RANGE: return "PAGE_MODE_OUT_OF_RANGE";
      case PAGE_NUM_STYLE_OUT_OF_RANGE: return "PAGE_NUM_STYLE_OUT_OF_RANGE";
      case ANNOT_INVALID_ICON: return "ANNOT_INVALID_ICON";
      case ANNOT_INVALID_BORDER_STYLE: return "ANNOT_INVALID_BORDER_STYLE";
      case PAGE_INVALID_DIRECTION: return "PAGE_INVALID_DIRECTION";
      case INVALID_FONT: return "INVALID_FONT";
      case PAGE_INSUFFICIENT_SPACE: return "PAGE_INSUFFICIENT_SPACE";
      case PAGE_INVALID_DISPLAY_TIME: return "PAGE_INVALID_DISPLAY_TIME";
      case PAGE_INVALID_TRANSITION_TIME: return "PAGE_INVALID_TRANSITION_TIME";
      case INVALID_PAGE_SLIDESHOW_TYPE: return "INVALID_PAGE_SLIDESHOW_TYPE";
      case EXT_GSTATE_OUT_OF_RANGE: return "EXT_GSTATE_OUT_OF_RANGE";
      case INVALID_EXT_GSTATE: return "INVALID_EXT_GSTATE";
      case EXT_GSTATE_READ_ONLY: return "EXT_GSTATE_READ_ONLY";
      case INVALID_U3D_DATA: return "INVALID_U3D_DATA";
      case NAME_CANNOT_GET_NAMES: return "NAME_CANNOT_GET_NAMES";
      case INVALID_ICC_COMPONENT_NUM: return "INVALID_ICC_COMPONENT_NUM";


      default: return "Unknown";
   }
}

