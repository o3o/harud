module harud.page;

import std.conv;
import std.stdio;
import std.string;
import std.exception; // for ErrNoException

import harud.annotation;
import harud.c;
import harud.destination;
import harud.encoder;
import harud.font;
import harud.haruobject;
import harud.image;
import harud.types;

/**
 * The Page class.
 *
 * The Page class is used to manipulate an individual page.
 * To create new pages use $(LINK2 harud/doc/Doc.addPage.html, `addPage()`) or
 * $(LINK2 harud/doc/Doc.insertPage.html, `insertPage()`) methods of $(LINK2 harud/doc/Doc.html, Doc)  class
 */
class Page : IHaruObject {
   protected HPDF_Page _page;

   this(HPDF_Page page) {
      _page = page;
   }

   /**
    * Gets the width of a page.
    *
    * Returns:
    * When succeed, it returns the width of a page. Otherwise it returns 0.
    */
   float getWidth() {
      return HPDF_Page_GetWidth(this._page);
   }

   /**
    * Changes the width of a page
    *
    * Params:
    *  value = the new page width. Valid value are between 3 and 14400
    */
   void setWidth(float value) {
      HPDF_Page_SetWidth(this._page, value);
   }

   /**
    * Gets the height of a page.
    *
    * Returns:
    * when succeed, it returns the height of a page. Otherwise it returns 0.
    */
   float getHeight() {
      return HPDF_Page_GetHeight(this._page);
   }

   /**
    * Changes the height of a page
    *
    * Params:
    *  value = the new page height. Valid value are between 3 and 14400
    */
   void setHeight(float value) {
      HPDF_Page_SetHeight(this._page, value);
   }

   /**
    * Changes the size and direction of a page to a predefined size
    *
    * Params:
    * size = Specify a predefined page-size value. The following values are available:
    *
    * <li>PageSizes.LETTER</li>
    * <li>PageSizes.LEGAL</li>
    * <li>PageSizes.A3</li>
    * <li>PageSizes.A4</li>
    * <li>PageSizes.A5</li>
    * <li>PageSizes.B4</li>
    * <li>PageSizes.B5</li>
    * <li>PageSizes.EXECUTIVE</li>
    * <li>PageSizes.US4x6</li>
    * <li>PageSizes.US4x8</li>
    * <li>PageSizes.US5x7</li>
    * <li>PageSizes.COMM10</li>
    *
    * direction = specify the direction of the page
    *
    * <li>PageDirection.PORTRAIT</li>
    * <li>PageDirection.LANDSCAPE</li>
    */
   HPDF_STATUS setSize(PageSizes size, PageDirection direction) {
      return HPDF_Page_SetSize(this._page, size, direction);
   }

   /**
    * Sets rotation angle of the page.
    *
    * Params:
    * angle = Specify the rotation angle of the page. It must be a multiple of 90 Degrees.
    */
   HPDF_STATUS setRotate(ushort angle) {
      return HPDF_Page_SetRotate(this._page, angle);
   }

   /**
    * Creates a new Destination instance for the page
    *
    * Returns:
    * Returns an instance of a Destination object. If it failed, it returns null.
    */
   Destination createDestination() {
      HPDF_Destination destination = HPDF_Page_CreateDestination(this._page);
      return new Destination(destination);
   }

   /**
    * Creates a new Annotation instance for the page.
    *
    * Params:
    * rect = A Rectangle where the annotation is displayed.
    * text = The text to be displayed.
    * encoder = An Encoder instance which is used to encode the text. If it is null, PDFDocEncoding is used.
    *
    * Returns:
    * returns an instance of a Annotation object. If it failed, it returns null.
    */
   Annotation createTextAnnot(Rect rect, string text, Encoder encoder = null) {
      HPDF_Encoder _encoder = null;
      if (encoder !is null) {
         _encoder = encoder.getHandle();
      }

      HPDF_Annotation annotation = HPDF_Page_CreateTextAnnot(this._page, rect,
         text.toStringz(), _encoder);
      return new Annotation(annotation);
   }

   /**
    * Creates a new link Annotation instance object for the page.
    *
    * Params:
    * rect = A rectangle of clickable area.
    * dst = A handle of destination object to jump to.
    *
    * Returns:
    * returns an instance of a Annotation object. If it failed, it returns null.
    */
   Annotation createLinkAnnot(Rect rect, Destination dst) {
      HPDF_Annotation annotation = HPDF_Page_CreateLinkAnnot(this._page, rect,
         dst.destinationHandle);
      return new Annotation(annotation);
   }

   /**
    * Creates a new web link Annotation instance object for the page.
    *
    * Params:
    * rect = A rectangle of clickable area.
    * dst = A handle of destination object to jump to.
    *
    * Returns:
    * returns an instance of a Annotation object. If it failed, it returns null.
    */
   Annotation createURILinkAnnot(Rect rect, string uri) {
      HPDF_Annotation annotation = HPDF_Page_CreateURILinkAnnot(this._page, rect, uri.toStringz());
      return new Annotation(annotation);
   }

   /**
    * Gets the width of the text in current fontsize, character spacing and word spacing.
    *
    * Params:
    * text = the text to get width.
    *
    * Returns:
    * When  succeed, it returns the width of the text in current fontsize,
    * character spacing and word spacing.
    * Otherwise it returns ZERO and error-handler is called.
    */
   float getTextWidth(string text) {
      return HPDF_Page_TextWidth(this._page, text.toStringz());
   }

   /**
    * Calculates the byte length which can be included within the specified width.
    *
    * Params:
    * text = The text to get width.
    * width = The width of the area to put the text.
    * wordwrap = When there are three words of "ABCDE", "FGH", and "IJKL", and the substring until "J" can be included within the width,
    * if word_wrap parameter is false it returns 12, and if word_wrap parameter is true, it returns 10 (the end of the previous word).
    * real_width = If this parameter is not null, the real widths of the text is set. An application can set it to null, if it is unnecessary.
    *
    * Returns:
    * When succeed it returns the byte length which can be included within the specified width in current fontsize, character spacing and word spacing.
    * Otherwise it returns ZERO and error-handler is called.
    */
   uint measureText(string text, float width, bool wordwrap, float* real_width) {
      return HPDF_Page_MeasureText(this._page, text.toStringz(), width,
         cast(uint) wordwrap, real_width);
   }

   /**
    * Gets the current graphics mode.
    *
    * Returns:
    * when succeed, it returns the current graphics mode of the page. Otherwise
    * it returns GMode.unknown.
    */
   GMode getGMode() {
      return to!GMode(HPDF_Page_GetGMode(this._page));
   }

   /**
    * Gets the current position for path painting.
    * An application can invoke `currentPos` only when graphics mode is GMode.pathObject.
    *
    * Returns:
    * when succeed, it returns a Point struct indicating the current position for path painting of the page.
    * Otherwise it returns a Point struct of {0, 0}.
    */
   Point getCurrentPos() {
      return HPDF_Page_GetCurrentPos(this._page);
   }

   /**
    * Gets the current position for text showing.
    *
    * An application can invoke getCurrentTextPos() only when graphics mode is
    * GMode.textObject
    *
    * Returns:
    * when succeed, it returns a Point struct indicating the current position for text showing of the page.
    * Otherwise it returns a Point struct of {0, 0}.
    */
   Point getCurrentTextPos() {
      return HPDF_Page_GetCurrentTextPos(this._page);
   }

   /**
    * Gets a Font instance of the page's current font.
    *
    * Returns:
    * when  succeed, it returns a Font instance of the page's current font.
    * Otherwise it returns null.
    */
    Font getCurrentFont() {
      HPDF_Font font = HPDF_Page_GetCurrentFont(this._page);
      return new Font(font);
   }

   /**
    * Gets the size of the page's current font.
    *
    * Returns:
    * when  succeed, it returns the size of the page's current font.
    * Otherwise it returns 0.
    */
   float getCurrentFontSize() {
      return HPDF_Page_GetCurrentFontSize(this._page);
   }

   /**
    * Gets the current transformation matrix of the page.
    *
    * Returns:
    * when succeed, it returns a TransMatrix struct of current transformation matrix of the page
    */
   TransMatrix getTransMatrix() {
      return HPDF_Page_GetTransMatrix(this._page);
   }

   /**
    * Gets the current line cap style of the page.
    *
    * Returns:
    * when getLineCap() succeed, it returns the current line cap style of the
    * page.
    * Otherwise it returns HaruLineCap.buttEnd
    */
   HaruLineCap getLineCap() {
      return HPDF_Page_GetLineCap(this._page);
   }

   /**
    * Sets the shape to be used at the ends of lines.
    *
    * Params:
    *  lineCap - The line cap style.
    *
    */
    void setLineCap(HaruLineCap lineCap) {
      HPDF_Page_SetLineCap(this._page, lineCap);
   }

   /**
    * Gets the current line join style of the page.
    *
    * Returns:
    * when succeed, it returns the current line join style of the page.
    * Otherwise it returns HaruLineJoin.miterJoin
    */
   HaruLineJoin getLineJoin() {
      return HPDF_Page_GetLineJoin(this._page);
   }

   /**
    * Sets the line join style in the page.
    *
    * Params:
    *  join = The line join style.
    *
    */
   void setLineJoin(HaruLineJoin join) {
      HPDF_Page_SetLineJoin(this._page, join);
   }

   unittest {
      import harud.doc;

      Doc pdf = new Doc();
      Page page = pdf.addPage();
      writeln("lineJoin: ", page.getLineJoin);
      page.setLineJoin(HaruLineJoin.roundJoin);
      writeln("lineJoin: ", page.getLineJoin);
   }

   /**
    * Gets the current value of the page's miter limit.
    *
    * Returns:
    * when succeed, it returns the current value of the page's miter limit.
    * Otherwise it returns HPDF_DEF_MITERLIMIT.
    */
    float getMiterLimit() {
      return HPDF_Page_GetMiterLimit(this._page);
   }

   /**
    * Sets the miter limit
    */
    void setMiterLimit(float miterLim) {
      HPDF_Page_SetMiterLimit(this._page, miterLim);
   }

   /**
    * Gets the current pattern of the page.
    *
    * Returns:
    * when  succeeds, it returns a DashMode struct of the current pattern of the page.
    */
   DashMode getDash() {
      return HPDF_Page_GetDash(this._page);
   }

   /**
    * Sets the dash pattern for lines in the page.
    *
    *
    * Params:
    * dashPattern = Pattern of dashes and gaps used to stroke paths. It's a
    * repeating sequence of dash length, gap length, dash length etc, which are
    * cycled through when stroking the line.
    * phase = Initial offset in which the pattern begins (default is 0).
    */
   HPDF_STATUS setDash(ushort[] dashPattern, uint phase)
   in {
      assert(dashPattern !is null);
      assert(dashPattern.length < 9, "numElem should be lesser than 9");
   }
   do {
      return HPDF_Page_SetDash(this._page, dashPattern.ptr, to!(uint)(dashPattern.length),
         phase);
   }

   /**
   * Sets the dash pattern to solid line
   */
   HPDF_STATUS setSolid() {
      enum ushort[] NN = [0, 0, 0, 0, 0, 0, 0, 0];
      return HPDF_Page_SetDash(this._page, NN.ptr, 0, 0);
   }

   /**
   * Sets the dash pattern to dotted line
   */
   HPDF_STATUS setDotted() {
      enum ushort[] DOTTED = [2];
      return setDash(DOTTED, 0);
   }

   /**
   * Sets the dash pattern to dash-dash-dot line
   */
   HPDF_STATUS setDashDashDot() {
      enum ushort[] DASH_DASH_DOT = [2, 2, 2, 2, 8, 2];
      return setDash(DASH_DASH_DOT, 0);
   }

   /**
   * Sets the dash pattern to dash-dot line
   */
   HPDF_STATUS setDashDot() {
      enum ushort[] DASH_DOT = [2, 2, 8, 2];
      return setDash(DASH_DOT, 0);
   }

   /**
   * Sets the dash pattern to dashed line
   */
   HPDF_STATUS setDashed() {
      enum ushort[] DASHED = [4];
      return setDash(DASHED, 0);
   }

   /**
    * Gets the current value of the page's flatness.
    *
    * Returns:
    * when  succeed, it returns the current value of the page's miter limit.
    * Otherwise it returns HPDF_DEF_FLATNESS.
    */
   float getFlat() {
      return HPDF_Page_GetFlat(this._page);
   }

   /**
    * Gets the current value of the page's character spacing.
    *
    * Returns:
    * when  succeed, it returns the current value of the page's character spacing.
    * Otherwise it returns 0.
    */
   float getCharSpace() {
      return HPDF_Page_GetCharSpace(this._page);
   }

   /**
    * Sets the character spacing for text.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    *
    * Params:
    * value = The character spacing (initial value is 0).
    */
   void setCharSpace(float value) {
      HPDF_Page_SetCharSpace(this._page, value);
   }

   /**
    * Get the current value of the page's word spacing.
    *
    * Returns:
    * when succeed, it returns the current value of the page's word spacing.
    * Otherwise it returns 0.
    */
   float getWordSpace() {
      return HPDF_Page_GetWordSpace(this._page);
   }

   /**
    * Sets the word spacing for text.
    *
    * Params:
    * value = The value of word spacing (initial value is 0).
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   void setWordSpace(float value) {
      HPDF_Page_SetWordSpace(this._page, value);
   }

   /**
    * Gets the current value of the page's horizontal scalling for text showing.
    *
    * Returns:
    * when  succeed, it returns the current value of the page's horizontal scalling.
    * Otherwise it returns HPDF_DEF_HSCALING.
    */
   float getHorizontalScalling() {
      return HPDF_Page_GetHorizontalScalling(this._page);
   }

   /**
    * Sets the horizontal scalling (scaling) for text showing.
    *
    * Params:
    * value = The value of horizontal scalling (scaling) (initially 100).
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   void setHorizontalScalling(float value) {
      HPDF_Page_SetHorizontalScalling(this._page, value);
   }

   /**
    * Gets the current value of the page's line spacing.
    *
    * Returns:
    * when succeed, it returns the current value of the line spacing.
    * Otherwise it returns 0.
    */
   float getTextLeading() {
      return HPDF_Page_GetTextLeading(this._page);
   }

   /**
    * Sets the text leading (line spacing) for text showing.
    *
    * Params:
    * value = The value of text leading (initial value is 0).
    */
   void setTextLeading(float value) {
      HPDF_Page_SetTextLeading(this._page, value);
   }

   /**
    * Gets the current value of the page's text rendering mode.
    *
    * Returns:
    * when succeed, it returns the current value of the text rendering mode.
    * Otherwise it returns 0.
    */
   HaruTextRenderingMode getTextRenderingMode() {
      return HPDF_Page_GetTextRenderingMode(this._page);
   }

   /**
    * Sets the text rendering mode. The initial value of text rendering mode is HPDF_FILL.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    *
    * Params:
    * mode = The text rendering mode (one of the following values)
    */
   void setTextRenderingMode(HaruTextRenderingMode mode) {
      HPDF_Page_SetTextRenderingMode(this._page, mode);
   }

   unittest {
      import harud.doc;

      Doc pdf = new Doc();
      Page page = pdf.addPage();
      writeln(page.getTextRenderingMode());
      page.setTextRenderingMode(HaruTextRenderingMode.stroke);
      writeln(page.getTextRenderingMode);
      assert(page.getTextRenderingMode == HaruTextRenderingMode.stroke);
      page.setTextRenderingMode(HaruTextRenderingMode.clipping);
      assert(page.getTextRenderingMode == HaruTextRenderingMode.clipping);
      writeln(page.getTextRenderingMode);
   }

   /**
    * Gets the current value of the page's text rising.
    *
    * Returns:
    * when succeed, it returns the current value of the text rising.
    * Otherwise it returns 0.
    */
   float getTextRise() {
      return HPDF_Page_GetTextRise(this._page);
   }

   /**
    * Moves the text position in vertical direction by the amount of value. Useful for making subscripts or superscripts.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    *
    * Params:
    * value = Text rise, in user space units.
    *
    */
   void setTextRise(float value) {
      HPDF_Page_SetTextRise(this._page, value);
   }

   /**
    * Gets the current value of the page's filling color.

    * getRGBFill() is valid only when the page's filling color space is HPDF_CS_DEVICE_RGB.
    *
    * Returns:
    * when getRGBFill() succeed, it returns the current value of the page's filling color. Otherwise it returns {0, 0, 0}.
    */
   HaruRGBColor getRGBFill() {
      return HPDF_Page_GetRGBFill(this._page);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * r, g, b = The level of each color element. They must be between 0 and 1. (See "Colors")
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   HPDF_STATUS setRGBFill(float r, float g, float b) {
      return HPDF_Page_SetRGBFill(this._page, r, g, b);
   }

   /**
    * Gets the current value of the page's stroking color.
    *
    * getRGBStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_RGB.
    *
    * Returns:
    * when getRGBStroke() succeed, it returns the current value of the page's stroking color.
    * Otherwise it returns {0, 0, 0}.
    */
   HaruRGBColor getRGBStroke() {
      return HPDF_Page_GetRGBStroke(this._page);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * r = The level of red color element. They must be between 0 and 1. (See "Colors")
    * g = The level of green color element. They must be between 0 and 1. (See "Colors")
    * b = The level of blue color element. They must be between 0 and 1. (See "Colors")
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   HPDF_STATUS setRGBStroke(float r, float g, float b) {
      return HPDF_Page_SetRGBStroke(this._page, r, g, b);
   }

   /**
    * Gets the current value of the page's filling color.
    *
    * getCMYKFill() is valid only when the page's filling color space is HPDF_CS_DEVICE_CMYK.
    *
    * Returns:
    * when getCMYKFill() succeed, it returns the current value of the page's filling color.
    * Otherwise it returns {0, 0, 0, 0}.
    */
   HaruCMYKColor getCMYKFill() {
      return HPDF_Page_GetCMYKFill(this._page);
   }

   /**
    * Gets the current value of the page's stroking color.
    *
    * getCMYKStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_CMYK.
    *
    * Returns:
    * when getCMYKStroke() succeed, it returns the current value of the page's stroking color.
    * Otherwise it returns {0, 0, 0, 0}.
    */
   HaruCMYKColor getCMYKStroke() {
      return HPDF_Page_GetCMYKStroke(this._page);
   }

   /**
    * Gets the current value of the page's filling color.
    *
    * grayFill() is valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY.
    *
    * Returns:
    * when getGrayFill() succeed, it returns the current value of the page's filling color.
    * Otherwise it returns 0.
    */
   float getGrayFill() {
      return HPDF_Page_GetGrayFill(this._page);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * value = The value of the gray level between 0 and 1.
    *
    * ## Graphics Mode
    * Before and after - GMode.pagedescription or GMode.textObject.
    */
   void setGrayFill(float gray) {
      HPDF_Page_SetGrayFill(this._page, gray);
   }

   /**
    * Gets the current value of the page's stroking color.
    *
    * grayStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY.
    *
    * Returns:
    * when succeed, it returns the current value of the page's stroking color.
    * Otherwise it returns 0.
    */
   float getGrayStroke() {
      return HPDF_Page_GetGrayStroke(this._page);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * value = The value of the gray level between 0 and 1.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   void setGrayStroke(float gray) {
      HPDF_Page_SetGrayStroke(this._page, gray);
   }

   /**
    * Gets the current value of the page's stroking color space.
    *
    * Returns:
    * when getStrokingColorSpace() succeed, it returns the current value of the page's stroking color space. Otherwise it returns HPDF_CS_EOF.
    */
   ColorSpace getStrokingColorSpace() {
      return HPDF_Page_GetStrokingColorSpace(this._page);
   }

   /**
    * Gets the current value of the page's stroking color space.
    *
    * Returns:
    * when getFillingColorSpace() succeed, it returns the current value of the page's stroking color space.
    * Otherwise it returns HPDF_CS_EOF.
    */
   ColorSpace getFillingColorSpace() {
      return HPDF_Page_GetFillingColorSpace(this._page);
   }

   /**
    * Gets the current text transformation matrix of the page.
    *
    * Returns:
    * when getTextMatrix() succeed, it returns a TransMatrix struct of current text transformation matrix of the page.
    */
   TransMatrix getTextMatrix() {
      return HPDF_Page_GetTextMatrix(this._page);
   }

   /**
    * Gets the number of the page's graphics state stack.
    *
    * Returns:
    * when getGStateDepth() succeed, it returns the number of the page's graphics state stack.
    * Otherwise it returns 0.
    */
   uint getGStateDepth() {
      return HPDF_Page_GetGStateDepth(this._page);
   }

   /**
    * Configures the setting for slide transition of the page.
    *
    * Params:
    * type = The transition style. The following values are available.
    *
    * <li>HaruTransitionStyle.WIPE_RIGHT</li>
    * <li>HaruTransitionStyle.WIPE_UP</li>
    * <li>HaruTransitionStyle.WIPE_LEFT</li>
    * <li>HaruTransitionStyle.WIPE_DOWN</li>
    * <li>HaruTransitionStyle.BARN_DOORS_HORIZONTAL_OUT</li>
    * <li>HaruTransitionStyle.BARN_DOORS_HORIZONTAL_IN</li>
    * <li>HaruTransitionStyle.BARN_DOORS_VERTICAL_OUT</li>
    * <li>HaruTransitionStyle.BARN_DOORS_VERTICAL_IN</li>
    * <li>HaruTransitionStyle.BOX_OUT</li>
    * <li>HaruTransitionStyle.BOX_IN</li>
    * <li>HaruTransitionStyle.BLINDS_HORIZONTAL</li>
    * <li>HaruTransitionStyle.BLINDS_VERTICAL</li>
    * <li>HaruTransitionStyle.DISSOLVE</li>
    * <li>HaruTransitionStyle.GLITTER_RIGHT</li>
    * <li>HaruTransitionStyle.GLITTER_DOWN</li>
    * <li>HaruTransitionStyle.GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT</li>
    * <li>HaruTransitionStyle.REPLACE</li>
    *
    * disp_time = The display duration of the page. (in seconds)
    * trans_time = The duration of the transition effect. Default value is 1(second).
    *
    */
   HPDF_STATUS setSlideShow(HaruTransitionStyle type, float disp_time, float trans_time) {
      return HPDF_Page_SetSlideShow(this._page, type, disp_time, trans_time);
   }

   /**
    * Appends a circle arc to the current path.
    *
    * ## Graphics Mode
    * Before - GMode.pageDescription or GMode.pathObject.
    * After - GMode.pathObject.
    *
    * Params:
    * x, y = The center point of the circle.
    * radius = The radius of the circle.
    * ang1 = The angle of the begining of the arc.
    * ang2 = The angle of the end of the arc. It must be greater than ang1.
    *
    */
   HPDF_STATUS arc(float x, float y, float ray, float ang1, float ang2) {
      return HPDF_Page_Arc(this._page, x, y, ray, ang1, ang2);
   }

   /**
    * Begins a text object and sets the text position to (0, 0).
    *
    * ## Graphics Mode
    * Before - GMode.pageDescription.
    * After - GMode.textObject.
    */
   HPDF_STATUS beginText() {
      return HPDF_Page_BeginText(this._page);
   }

   /**
    * Appends a circle to the current path.
    *
    * Params:
    * x, y = The center point of the circle.
    * radius = The radius of the circle.
    *
    * ## Graphics Mode
    * Before - GMode.pageDescription or GMode.pathObject.
    * After - GMode.pathObject.
    */
   HPDF_STATUS circle(float x, float y, float ray) {
      return HPDF_Page_Circle(this._page, x, y, ray);
   }

   /**
    * Modifies the current clipping path by intersecting it with the current path using the nonzero winding number rule.
    *
    * The clipping path is only modified after the succeeding painting operator.
    * To avoid painting the current path, use the function HPDF_Page_EndPath().
    *
    * Following painting operations will only affect the regions of the page contained by the clipping path.
    * Initially, the clipping path includes the entire page.
    * There is no way to enlarge the current clipping path, or to replace the clipping path with a new one.
    * The functions HPDF_Page_GSave() and HPDF_Page_GRestore() may be used to save and restore the current graphics state, including the clipping path.
    *
    * ## Graphics Mode
    * Before and after - GMode,pathObject.
    *
    * Params:
    * page = The handle of a page object.
    *
    * Returns:
    *
    * HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
    */
   HPDF_STATUS clip() {
      return HPDF_Page_Clip(this._page);
   }

   /**
    * Appends a straight line from the current point to the start point of sub path. The current point is moved to the start point of sub path
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS closePath() {
      return HPDF_Page_ClosePath(this._page);
   }

   /**
    * Closes the current path. Then, it paints the path.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.<br />
    * After - GMode.pageDescription.
    */
   HPDF_STATUS closePathStroke() {
      return HPDF_Page_ClosePathStroke(this._page);
   }

   /**
    * Closes the current path, fills the current path using the nonzero winding number rule, then paints the path.
    *
    * ## Graphics Mode
    * Before - GMode.pathObjec.
    * After - GMode.pageDescription.
    */
   HPDF_STATUS closePathFillStroke() {
      return HPDF_Page_ClosePathFillStroke(this._page);
   }

   /**
    * Concatenates the page's current transformation matrix and specified matrix.
    *
    * Params:
    * a, b, c, d, x, y = The transformation matrix to concatenate.
    */
   HPDF_STATUS concat(float a, float b, float c, float d, float x, float y) {
      return HPDF_Page_Concat(this._page, a, b, c, d, x, y);
   }

   /**
    * Appends a Bézier curve to the current path using the control points (x1, y1) and (x2, y2) and (x3, y3), then sets the current point to (x3, y3).
    *
    * Params:
    * x1, y1, x2, y2, x3, y3 = The control points for a Bézier curve.
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS curveTo(float x1, float y1, float x2, float y2, float x3, float y3) {
      return HPDF_Page_CurveTo(this._page, x1, y1, x2, y2, x3, y3);
   }

   /**
    * Appends a Bézier curve to the current path using the current point and (x2, y2) and (x3, y3) as control points. Then, the current point is set to (x3, y3).
    *
    * Params:
    * x2, y2, x3, y3 = Control points for Bézier curve, along with current point.
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS curveTo2(float x2, float y2, float x3, float y3) {
      return HPDF_Page_CurveTo2(this._page, x2, y2, x3, y3);
   }

   /**
    * Appends a Bézier curve to the current path using two spesified points.
    *
    * The point (x1, y1) and the point (x3, y3) are used as the control points for a Bézier curve and current point is moved to the point (x3, y3)
    *
    * Params:
    * x1, y1, x3, y3 = The control points for a Bézier curve.
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS curveTo3(float x1, float y1, float x3, float y3) {
      return HPDF_Page_CurveTo3(this._page, x1, y1, x3, y3);
   }

   /**
    * Shows an image in one operation.
    *
    * Params:
    * image = The handle of an image object.
    * x, y = The lower-left point of the region where image is displayed.
    * width = The width of the region where image is displayed.
    * height = The width of the region where image is displayed.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription.
    */
   HPDF_STATUS drawImage(Image image, float x, float y, float width, float height) {
      return HPDF_Page_DrawImage(this._page, image.getHandle(), x, y, width, height);
   }

   /**
    * Appends an ellipse to the current path.
    *
    * Params:
    * x, y = The center point of the ellipse.
    * x_radius, y_radius = Horizontal and vertical radii of the ellipse.
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS ellipse(float x, float y, float xray, float yray) {
      return HPDF_Page_Ellipse(this._page, x, y, xray, yray);
   }

   /**
    * Ends the path object without filling or painting.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.
    * After - GMode.pageDescription.
    */
   HPDF_STATUS endPath() {
      return HPDF_Page_EndPath(this._page);
   }

   /**
    * Ends a text object.
    *
    * ## Graphic Mode
    * Before: GMode.textObject.
    * After: GMode.pageDescription.
    */
   HPDF_STATUS endText() {
      return HPDF_Page_EndText(this._page);
   }

   HPDF_STATUS eoclip() {
      return HPDF_Page_Eoclip(this._page);
   }

   /**
    * Fills the current path using the even-odd rule.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.
    * After - GMode.pageDescription.
    */
   HPDF_STATUS eofill() {
      return HPDF_Page_Eofill(this._page);
   }

   /**
    * Fills the current path using the even-odd rule, then paints the path.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject
    * After - GMode.pageDescription.
    */
   HPDF_STATUS eofillStroke() {
      return HPDF_Page_EofillStroke(this._page);
   }

   HPDF_STATUS executeXObject(Image image) {
      return HPDF_Page_ExecuteXObject(this._page, image.getHandle());
   }

   /**
    * Fills the current path using the nonzero winding number rule.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.
    * After - GMode.pageDescription.
    */
   HPDF_STATUS fill() {
      return HPDF_Page_Fill(this._page);
   }

   /**
    * Fills the current path using the nonzero winding number rule, then paints the path.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.<br />
    * After - GMode.pageDescription.
    */
   HPDF_STATUS fillStroke() {
      return HPDF_Page_FillStroke(this._page);
   }

   /**
    * Restore the graphics state which is saved by HPDF_Page_GSave().
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription.
    */
   HPDF_STATUS graphicRestore() {
      return HPDF_Page_GRestore(this._page);
   }

   /**
    * Saves the page's current graphics parameter to the stack.
    * An application can invoke gSave() up to 28 (???) and can restore the saved parameter by invoking gRestore().
    *
    * The parameters that are saved by gSave() are:
    * <li>Character Spacing</li>
    * <li>Dash Mode</li>
    * <li>Filling Color</li>
    * <li>Flatness</li>
    * <li>Font</li>
    * <li>Font Size</li>
    * <li>Horizontal Scalling</li>
    * <li>Line Width</li>
    * <li>Line Cap Style</li>
    * <li>Line Join Style</li>
    * <li>Miter Limit</li>
    * <li>Rendering Mode</li>
    * <li>Stroking Color</li>
    * <li>Text Leading</li>
    * <li>Text Rise</li>
    * <li>Transformation Matrix</li>
    * <li>Word Spacing</li>
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription.
    */
   HPDF_STATUS graphicSave() {
      return HPDF_Page_GSave(this._page);
   }

   /**
    * Appends a path from the current point to the specified point.
    *
    * Params:
    * x, y = The end point of the path
    *
    * ## Graphics Mode
    * Before and after - GMode.pathObject.
    */
   HPDF_STATUS lineTo(float x, float y) {
      return HPDF_Page_LineTo(this._page, x, y);
   }

   /**
    * Changes the current text position, using the specified offset values. If the current text position is (x1, y1), the new text position will be (x1 + x, y1 + y).
    *
    * Params:
    * x, y = The offset to new text position.
    *
    * ## Graphics Mode
    * Before and after - GMode.textObject.
    */
   HPDF_STATUS moveTextPos(float x, float y, bool setLeading = false) {
      if (setLeading) {
         return HPDF_Page_MoveTextPos2(this._page, x, y);
      }

      return HPDF_Page_MoveTextPos(this._page, x, y);
   }

   /**
    * Starts a new subpath and move the current point for drawing path,
    * moveTo() sets the start point for the path to the point (x, y).
    *
    * Params:
    * x = The x coordinate of start point for drawing path
    * y = The y coordinate of start point for drawing path
    *
    * ## Graphics Mode
    * Before - GMode.pageDescription or GMode.pathObject.
    * After - GMode.pathObject.
    */
   HPDF_STATUS moveTo(float x, float y) {
      return HPDF_Page_MoveTo(this._page, x, y);
   }

   /**
    * Moves to the next line.
    */
   HPDF_STATUS moveToNextLine() {
      return HPDF_Page_MoveToNextLine(this._page);
   }

   /**
    * Appends a rectangle to the current path.
    *
    * ## Graphics Mode
    * Before - GMode.pageDescription or GMode.pathObject.
    * After - GMode.pathObject.
    *
    * Params:
    * x = The x coordinate of lower-left point of the rectangle.
    * y = The y coordinate of lower-left point of the rectangle.
    * width = The width of the rectangle.
    * height = The height of the rectangle.
    *
    */
   HPDF_STATUS rectangle(float x, float y, float width, float height) {
      return HPDF_Page_Rectangle(this._page, x, y, width, height);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * c, m, y, k = The level of each color element. They must be between 0 and 1.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   HPDF_STATUS setCMYKFill(float c, float m, float y, float k) {
      return HPDF_Page_SetCMYKFill(this._page, c, m, y, k);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * c, m, y, k = The level of each color element. They must be between 0 and 1.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   HPDF_STATUS setCMYKStroke(float c, float m, float y, float k) {
      return HPDF_Page_SetCMYKStroke(this._page, c, m, y, k);
   }

   /**
    * Applyies the graphics state to the page.
    *
    * Params:
    * ext_gstate = The handle of an extended graphics state object.
    *
    * ## Graphics Mode
    * Before and after: GMode.pageDescription.
    */
   HPDF_STATUS setExtGState(HPDF_ExtGState ext_gstate) {
      return HPDF_Page_SetExtGState(this._page, ext_gstate);
   }

   /**
    * Sets the type of font and size leading.
    *
    * Params:
    * font = The handle of a font object.
    * size = The size of a font.
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   HPDF_STATUS setFontAndSize(Font font, float size) {
      return HPDF_Page_SetFontAndSize(this._page, font.getHandle(), size);
   }

   /**
    * Gets the current line width of the page.
    *
    * Returns:
    * when getLineWidth() succeed, it returns the current line width for path painting of the page.
    * Otherwise it returns HPDF_DEF_LINEWIDTH.
    */
   float getLineWidth() {
      return HPDF_Page_GetLineWidth(this._page);
   }

   /**
    * Sets the width of the line used to stroke a path.
    *
    * Params:
    * line_width = The line width to use (default is 1).
    *
    * ## Graphics Mode
    * Before and after - GMode.pageDescription or GMode.textObject.
    */
   void setLineWidth(float lineWidth) {
      HPDF_Page_SetLineWidth(this._page, lineWidth);
   }

   /**
    * Sets the text matrix
    */
   HPDF_STATUS setTextMatrix(float a, float b, float c, float d, float x, float y) {
      return HPDF_Page_SetTextMatrix(this._page, a, b, c, d, x, y);
   }

   HPDF_STATUS showText(string text) {
      return HPDF_Page_ShowText(this._page, text.toStringz());
   }

   /**
    * Moves the current text position to the start of the next line,
    * then prints the text at the current position on the page.
    *
    * ## Graphics Mode
    * Before and after - GMode.textObject.
    *
    * Params:
    * text = The text to print.
    *
    */
   HPDF_STATUS showTextNextLine(string text, float word_space = 0.0, float char_space = 0.0) {
      return HPDF_Page_ShowTextNextLine(this._page, text.toStringz());
   }

   /**
    * Paints the current path.
    *
    * ## Graphics Mode
    * Before - GMode.pathObject.
    * After - GMode.pageDescription.
    */
   HPDF_STATUS stroke() {
      return HPDF_Page_Stroke(this._page);
   }

   /**
    * Prints the text on the specified position.
    *
    * Params:
    * xpos = The x position where the text is displayed.
    * ypos = The y position where the text is displayed.
    * text = The text to show.
    * Returns:
    * Zero when succeed, otherwise it returns error code.
    *
    * ## Graphics Mode
    * Before and after - GMode.textObject.
    */
   HPDF_STATUS textOut(float xpos, float ypos, string text) {
      assert(text.length > 0);
      return HPDF_Page_TextOut(this._page, xpos, ypos, text.toStringz());
   }

   /**
    * Prints the text inside the specified region.
    *
    * Params:
    * left, top, right, bottom = Coordinates of corners of the region to output text.
    * text = The text to show.
    * align = The alignment of the text (one of the following).
    * len = If not NULL, the number of characters printed in the area is returned.
    *
    * ## Graphics Mode
    * Before and after - GMode.textObject.
    */
   HPDF_STATUS textRect(float left, float top, float right, float bottom,
      string text, HaruTextAlignment align_, uint* len) {
      return HPDF_Page_TextRect(this._page, left, top, right, bottom,
         text.toStringz(), align_, len);
   }

   HPDF_HANDLE getHandle() {
      return _page;
   }
}
