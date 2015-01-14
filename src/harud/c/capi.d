module harud.c.capi;

import harud.types;
import harud.c.consts;

extern(C) {

   /**
    * Basic Functions
    */
   HPDF_Doc HPDF_New(void* error, void* user_data);

   void HPDF_Free(HPDF_Doc pdf);

   HPDF_STATUS HPDF_NewDoc(HPDF_Doc pdf);

   void HPDF_FreeDoc(HPDF_Doc pdf);

   void HPDF_FreeDocAll(HPDF_Doc pdf);

   HPDF_STATUS HPDF_SaveToFile(HPDF_Doc pdf, const(char)* file_name);

   HPDF_STATUS HPDF_SaveToStream(HPDF_Doc pdf);

   uint HPDF_GetStreamSize(HPDF_Doc pdf);

   HPDF_STATUS HPDF_ReadFromStream(HPDF_Doc pdf, ubyte* buf, uint* size);

   HPDF_STATUS HPDF_ResetStream(HPDF_Doc pdf);

   HPDF_BOOL HPDF_HasDoc(HPDF_Doc pdf);

   HPDF_STATUS HPDF_SetErrorHandler(HPDF_Doc pdf, void* error);

   HPDF_STATUS HPDF_GetError(HPDF_Doc pdf);

   void HPDF_ResetError(HPDF_Doc pdf);

   const(char)* HPDF_GetVersion();

   /*
    * Pages Handling
    */
   HPDF_STATUS HPDF_SetPagesConfiguration(HPDF_Doc pdf, uint page_per_pages);

   HPDF_STATUS HPDF_SetPageLayout(HPDF_Doc pdf, PageLayout layout);

   PageLayout HPDF_GetPageLayout(HPDF_Doc pdf);

   HPDF_STATUS HPDF_SetPageMode(HPDF_Doc pdf, PageMode mode);

   PageMode HPDF_GetPageMode(HPDF_Doc pdf);

   HPDF_STATUS HPDF_SetOpenAction(HPDF_Doc pdf, HPDF_Destination open_action);

   HPDF_Page HPDF_GetCurrentPage(HPDF_Doc pdf);

   HPDF_Page HPDF_AddPage(HPDF_Doc pdf);

   HPDF_Page HPDF_InsertPage(HPDF_Doc pdf, HPDF_Page target);


   /*
    * Font Handling
    */

   HPDF_Font HPDF_GetFont(HPDF_Doc pdf, const(char)* font_name, const(char)* encoding_name);

   const(char)* HPDF_LoadType1FontFromFile(HPDF_Doc pdf, const(char)* afmfilename, const(char)* pfmfilename);

   const(char)* HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const(char)* file_name, HPDF_BOOL embedding);

   const(char)* HPDF_LoadTTFontFromFile2(HPDF_Doc pdf, const(char)* file_name, uint index, HPDF_BOOL embedding);

   HPDF_STATUS HPDF_AddPageLabel(HPDF_Doc pdf,
         uint page_num,
         PageNumStyle style,
         uint first_page,
         const(char)* prefix);

   HPDF_STATUS HPDF_UseJPFonts(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseKRFonts(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseCNSFonts(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseCNTFonts(HPDF_Doc pdf);

   /*
    * Encodings
    */
   HPDF_Encoder HPDF_GetEncoder(HPDF_Doc pdf, const(char)* encoding_name);

   HPDF_Encoder HPDF_GetCurrentEncoder(HPDF_Doc pdf);

   HPDF_STATUS HPDF_SetCurrentEncoder(HPDF_Doc pdf, const(char)* encoding_name);

   HPDF_STATUS HPDF_UseJPEncodings(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseKREncodings(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseCNSEncodings(HPDF_Doc pdf);

   HPDF_STATUS HPDF_UseCNTEncodings(HPDF_Doc pdf);


   /*
    *Other Functions
    */

   HPDF_Outline HPDF_CreateOutline(HPDF_Doc pdf, HPDF_Outline parent, const(char)* title, HPDF_Encoder encoder);

   HPDF_Image HPDF_LoadPngImageFromFile(HPDF_Doc pdf, const(char)* filename);

   HPDF_Image HPDF_LoadPngImageFromFile2(HPDF_Doc pdf, const(char)* filename);

   HPDF_Image HPDF_LoadRawImageFromFile(HPDF_Doc pdf,
         const(char)* filename,
         uint width,
         uint height,
         ColorSpace color_space);

   HPDF_Image HPDF_LoadRawImageFromMem(HPDF_Doc pdf,
         ubyte* buf,
         uint width,
         uint height,
         ColorSpace color_space,
         uint bits_per_component);

   HPDF_Image HPDF_LoadJpegImageFromFile(HPDF_Doc pdf, const(char)* filename);

   HPDF_STATUS HPDF_SetInfoAttr(HPDF_Doc pdf, HaruInfoType type, const(char)* value);

   const(char)* HPDF_GetInfoAttr(HPDF_Doc pdf, HaruInfoType type);

   HPDF_STATUS HPDF_SetInfoDateAttr(HPDF_Doc pdf, HaruInfoType type, HaruDate value);

   HPDF_STATUS HPDF_SetPassword(HPDF_Doc pdf, const(char)* owner_passwd, const(char)* user_passwd);

   HPDF_STATUS HPDF_SetPermission(HPDF_Doc pdf, uint permission);

   HPDF_STATUS HPDF_SetEncryptionMode(HPDF_Doc pdf, HaruEncryptMode mode, uint key_len);

   HPDF_STATUS HPDF_SetCompressionMode(HPDF_Doc pdf, uint mode);



   /*
    * HPDF_Page
    */
   HPDF_STATUS HPDF_Page_SetWidth(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_SetHeight(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_SetSize(HPDF_Page page,
         PageSizes size,
         PageDirection direction);

   HPDF_STATUS HPDF_Page_SetRotate(HPDF_Page page,
         ushort angle);

   float HPDF_Page_GetWidth(HPDF_Page page);

   float HPDF_Page_GetHeight(HPDF_Page page);

   HPDF_Destination HPDF_Page_CreateDestination(HPDF_Page page);

   HPDF_Annotation HPDF_Page_CreateTextAnnot(HPDF_Page page,
         Rect rect,
         const(char)* text,
         HPDF_Encoder encoder);

   HPDF_Annotation HPDF_Page_CreateLinkAnnot(HPDF_Page page,
         Rect rect,
         HPDF_Destination dst);

   HPDF_Annotation HPDF_Page_CreateURILinkAnnot(HPDF_Page page,
         Rect rect,
         const(char)* uri);

   float HPDF_Page_TextWidth(HPDF_Page page, const(char)* text);

   uint HPDF_Page_MeasureText(HPDF_Page page,
         const(char)* text,
         float width,
         HPDF_BOOL wordwrap,
         float* real_width);

   ushort HPDF_Page_GetGMode(HPDF_Page page);

   Point HPDF_Page_GetCurrentPos(HPDF_Page page);

   Point HPDF_Page_GetCurrentTextPos(HPDF_Page page);

   HPDF_Font HPDF_Page_GetCurrentFont(HPDF_Page page);

   float HPDF_Page_GetCurrentFontSize(HPDF_Page page);

   TransMatrix HPDF_Page_GetTransMatrix(HPDF_Page page);

   float HPDF_Page_GetLineWidth(HPDF_Page page);

   HaruLineCap HPDF_Page_GetLineCap(HPDF_Page page);

   HaruLineJoin HPDF_Page_GetLineJoin(HPDF_Page page);

   float HPDF_Page_GetMiterLimit(HPDF_Page page);

   DashMode HPDF_Page_GetDash(HPDF_Page page);

   float HPDF_Page_GetFlat(HPDF_Page page);

   float HPDF_Page_GetCharSpace(HPDF_Page page);

   float HPDF_Page_GetWordSpace(HPDF_Page page);

   float HPDF_Page_GetHorizontalScalling(HPDF_Page page);

   float HPDF_Page_GetTextLeading(HPDF_Page page);

   HaruTextRenderingMode HPDF_Page_GetTextRenderingMode(HPDF_Page page);

   float HPDF_Page_GetTextRise(HPDF_Page page);

   HaruRGBColor HPDF_Page_GetRGBFill(HPDF_Page page);

   HaruRGBColor HPDF_Page_GetRGBStroke(HPDF_Page page);

   HaruCMYKColor HPDF_Page_GetCMYKFill(HPDF_Page page);

   HaruCMYKColor HPDF_Page_GetCMYKStroke(HPDF_Page page);

   float HPDF_Page_GetGrayFill(HPDF_Page page);

   float HPDF_Page_GetGrayStroke(HPDF_Page page);

   ColorSpace HPDF_Page_GetStrokingColorSpace(HPDF_Page page);

   ColorSpace HPDF_Page_GetFillingColorSpace(HPDF_Page page);

   TransMatrix HPDF_Page_GetTextMatrix(HPDF_Page page);

   uint HPDF_Page_GetGStateDepth(HPDF_Page page);

   HPDF_STATUS HPDF_Page_SetSlideShow(HPDF_Page page,
         HaruTransitionStyle type,
         float disp_time,
         float trans_time);


   /*
    * Graphics
    */
   HPDF_STATUS HPDF_Page_Arc(HPDF_Page page,
         float x,
         float y,
         float ray,
         float ang1,
         float ang2);

   HPDF_STATUS HPDF_Page_BeginText(HPDF_Page page);

   HPDF_STATUS HPDF_Page_Circle(HPDF_Page page,
         float x,
         float y,
         float ray);

   HPDF_STATUS HPDF_Page_Clip(HPDF_Page page);

   HPDF_STATUS HPDF_Page_ClosePath(HPDF_Page page);

   HPDF_STATUS HPDF_Page_ClosePathStroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_ClosePathEoillStroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_ClosePathFillStroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_Concat(HPDF_Page page,
         float a,
         float b,
         float c,
         float d,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_CurveTo(HPDF_Page page,
         float x1,
         float y1,
         float x2,
         float y2,
         float x3,
         float y3);

   HPDF_STATUS HPDF_Page_CurveTo2(HPDF_Page page,
         float x2,
         float y2,
         float x3,
         float y3);

   HPDF_STATUS HPDF_Page_CurveTo3(HPDF_Page page,
         float x1,
         float y1,
         float x3,
         float y3);

   HPDF_STATUS HPDF_Page_DrawImage(HPDF_Page page,
         HPDF_Image image,
         float x,
         float y,
         float width,
         float height);

   HPDF_STATUS HPDF_Page_Ellipse(HPDF_Page page,
         float x,
         float y,
         float xray,
         float yray);

   HPDF_STATUS HPDF_Page_EndPath(HPDF_Page page);

   HPDF_STATUS HPDF_Page_EndText(HPDF_Page page);

   HPDF_STATUS HPDF_Page_Eoclip(HPDF_Page page);

   HPDF_STATUS HPDF_Page_Eofill(HPDF_Page page);

   HPDF_STATUS HPDF_Page_EofillStroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_ExecuteXObject(HPDF_Page page, HPDF_XObject obj);

   HPDF_XObject HPDF_Page_CreateXObjectFromImage(HPDF_Doc pdf, HPDF_Page page,
         Rect rect, HPDF_Image image, HPDF_BOOL zoom);


   HPDF_STATUS HPDF_Page_Fill(HPDF_Page page);

   HPDF_STATUS HPDF_Page_FillStroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_GRestore(HPDF_Page page);

   HPDF_STATUS HPDF_Page_GSave(HPDF_Page page);

   HPDF_STATUS HPDF_Page_LineTo(HPDF_Page page,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_MoveTextPos(HPDF_Page page,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_MoveTextPos2(HPDF_Page page,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_MoveTo(HPDF_Page page,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_MoveToNextLine(HPDF_Page page);

   HPDF_STATUS HPDF_Page_Rectangle(HPDF_Page page,
         float x,
         float y,
         float width,
         float height);

   HPDF_STATUS HPDF_Page_SetCharSpace(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_SetCMYKFill(HPDF_Page page,
         float c,
         float m,
         float y,
         float k);

   HPDF_STATUS HPDF_Page_SetCMYKStroke(HPDF_Page page,
         float c,
         float m,
         float y,
         float k);

   HPDF_STATUS HPDF_Page_SetDash(HPDF_Page page,
         ushort* dash_ptn,
         uint num_param,
         uint phase);

   HPDF_STATUS HPDF_Page_SetExtGState(HPDF_Page page, HPDF_ExtGState ext_gstate);

   HPDF_STATUS HPDF_Page_SetGrayFill(HPDF_Page page, float gray);

   HPDF_STATUS HPDF_Page_SetGrayStroke(HPDF_Page page, float gray);

   HPDF_STATUS HPDF_Page_SetFontAndSize(HPDF_Page page,
         HPDF_Font font,
         float size);

   HPDF_STATUS HPDF_Page_SetHorizontalScalling(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_SetLineWidth(HPDF_Page page, float line_width);

   HPDF_STATUS HPDF_Page_SetLineCap(HPDF_Page page, HaruLineCap line_cap);

   HPDF_STATUS HPDF_Page_SetLineJoin(HPDF_Page page, HaruLineJoin line_join);

   HPDF_STATUS HPDF_Page_SetMiterLimit(HPDF_Page page, float miter_limit);

   HPDF_STATUS HPDF_Page_SetTextLeading(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_SetTextMatrix(HPDF_Page page,
         float a,
         float b,
         float c,
         float d,
         float x,
         float y);

   HPDF_STATUS HPDF_Page_SetTextRenderingMode(HPDF_Page page, HaruTextRenderingMode mode);

   HPDF_STATUS HPDF_Page_SetTextRise(HPDF_Page page,
         float value);

   HPDF_STATUS HPDF_Page_SetRGBFill(HPDF_Page page,
         float r,
         float g,
         float b);

   HPDF_STATUS HPDF_Page_SetRGBStroke(HPDF_Page page,
         float r,
         float g,
         float b);

   HPDF_STATUS HPDF_Page_SetWordSpace(HPDF_Page page, float value);

   HPDF_STATUS HPDF_Page_ShowText(HPDF_Page page, const(char)* text);

   HPDF_STATUS HPDF_Page_ShowTextNextLine(HPDF_Page page, const(char)* text);

   HPDF_STATUS HPDF_Page_ShowTextNextLineEx(HPDF_Page page,
         float word_space,
         float char_space,
         const(char)* text);

   HPDF_STATUS HPDF_Page_Stroke(HPDF_Page page);

   HPDF_STATUS HPDF_Page_TextOut(HPDF_Page page,
         float xpos,
         float ypos,
         const(char)* text);

   HPDF_STATUS HPDF_Page_TextRect(HPDF_Page page,
         float left,
         float top,
         float right,
         float bottom,
         const(char)* text,
         HaruTextAlignment alig,
         uint* len);

   /*
    * Font
    */
   const(char)* HPDF_Font_GetFontName(HPDF_Font font);

   const(char)* HPDF_Font_GetEncodingName(HPDF_Font font);

   int HPDF_Font_GetUnicodeWidth(HPDF_Font font, HPDF_UNICODE code);

   HaruBox HPDF_Font_GetBBox(HPDF_Font font);

   int HPDF_Font_GetAscent(HPDF_Font font);

   int HPDF_Font_GetDescent(HPDF_Font font);

   uint HPDF_Font_GetXHeight(HPDF_Font font);

   uint HPDF_Font_GetCapHeight(HPDF_Font font);

   TextWidth HPDF_Font_TextWidth(HPDF_Font font,
         const(char)* text,
         uint len);

   uint HPDF_Font_MeasureText(HPDF_Font font,
         const(char)* text,
         uint len,
         float width,
         float font_size,
         float char_space,
         float word_space,
         HPDF_BOOL wordwrap,
         float* real_width);

   /*
    * Encoding
    */


   HaruEncoderType HPDF_Encoder_GetType(HPDF_Encoder encoder);

   HaruByteType HPDF_Encoder_GetByteType(HPDF_Encoder encoder,
         const(char)* text,
         uint index);

   HPDF_UNICODE HPDF_Encoder_GetUnicode(HPDF_Encoder encoder,
         ushort code);

   HaruWritingMode HPDF_Encoder_GetWritingMode(HPDF_Encoder encoder);


   /*
    * Annotation
    */
   HPDF_STATUS HPDF_LinkAnnot_SetHighlightMode(HPDF_Annotation annot,
         HaruAnnotHighlightMode mode);

   HPDF_STATUS HPDF_LinkAnnot_SetBorderStyle(HPDF_Annotation annot,
         float width,
         ushort dash_on,
         ushort dash_off);

   HPDF_STATUS HPDF_TextAnnot_SetIcon(HPDF_Annotation annot,
         HaruAnnotIcon icon);

   HPDF_STATUS HPDF_TextAnnot_SetOpened(HPDF_Annotation annot,
         HPDF_BOOL open);

   /*
    * Outline
    */

   HPDF_STATUS HPDF_Outline_SetOpened(HPDF_Outline outline,
         HPDF_BOOL opened);

   HPDF_STATUS HPDF_Outline_SetDestination(HPDF_Outline outline,
         HPDF_Destination dst);

   /*
    * Destination
    */

   HPDF_STATUS HPDF_Destination_SetXYZ(HPDF_Destination dst,
         float left,
         float top,
         float zoom);

   HPDF_STATUS HPDF_Destination_SetFit(HPDF_Destination dst);

   HPDF_STATUS HPDF_Destination_SetFitH(HPDF_Destination dst,
         float top);

   HPDF_STATUS HPDF_Destination_SetFitV(HPDF_Destination dst,
         float left);

   HPDF_STATUS HPDF_Destination_SetFitR(HPDF_Destination dst,
         float left,
         float bottom,
         float right,
         float top);

   HPDF_STATUS HPDF_Destination_SetFitB(HPDF_Destination dst);

   HPDF_STATUS HPDF_Destination_SetFitBH(HPDF_Destination dst,
         float top);

   HPDF_STATUS HPDF_Destination_SetFitBV(HPDF_Destination dst,
         float top);

   /*
    * Image
    */
   Point HPDF_Image_GetSize(HPDF_Image image);

   uint HPDF_Image_GetWidth(HPDF_Image image);

   uint HPDF_Image_GetHeight(HPDF_Image image);

   uint HPDF_Image_GetBitsPerComponent(HPDF_Image image);

   const(char)* HPDF_Image_GetColorSpace(HPDF_Image image);

   HPDF_STATUS HPDF_Image_SetColorMask(HPDF_Image image,
         uint rmin,
         uint rmax,
         uint gmin,
         uint gmax,
         uint bmin,
         uint bmax);

   HPDF_STATUS HPDF_Image_SetMaskImage(HPDF_Image image,
         HPDF_Image mask_image);

}
