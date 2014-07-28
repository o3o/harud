module harud.page;

import std.conv;
import std.string;
import std.exception; // for ErrNoException

import harud.c;

import harud.haruobject;

import harud.harudestination;
import harud.annotation;
import harud.harufont;
import harud.haruimage;
import harud.haruencoder;

/**
 * The Page class
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
    * when getWidth() succeed, it returns the width of a page. Otherwise it returns 0.
    */
   @property HPDF_REAL width() {
      return HPDF_Page_GetWidth(this._page);
   }

   /**
    * Changes the width of a page
    *
    * Params:
    * value = the new page width. Valid value are between 3 and 14400
    */
   @property void width(HPDF_REAL value) {
      HPDF_STATUS status = HPDF_Page_SetWidth(this._page, value);
      if (status > 0) {
         throw new ErrnoException(getErrorDescription(status));
      }
   }

   /**
    * Changes the height of a page
    *
    * Params:
    * value = the new page height. Valid value are between 3 and 14400
    */
   HPDF_STATUS setHeight(HPDF_REAL value) {
      return HPDF_Page_SetHeight(this._page, value);
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
   HPDF_STATUS setRotate(HPDF_UINT16 angle) {
      return HPDF_Page_SetRotate(this._page, angle);
   }

   /**
    * Gets the height of a page.
    *
    * Returns:
    * when getHeight() succeed, it returns the height of a page. Otherwise it returns 0.
    */
   HPDF_REAL getHeight() {
      return HPDF_Page_GetHeight(this._page);
   }

   /**
    * Creates a new HaruDestination instance for the page
    *
    * Returns:
    * Returns an instance of a HaruDestination object. If it failed, it returns null.
    */
   HaruDestination createDestination() {
      HPDF_Destination destination = HPDF_Page_CreateDestination(this._page);
      return new HaruDestination(destination);
   }

   /**
    * Creates a new Annotation instance for the page.
    *
    * Params:
    * rect = A Rectangle where the annotation is displayed.
    * text = The text to be displayed.
    * encoder = An HaruEncoder instance which is used to encode the text. If it is null, PDFDocEncoding is used.
    *
    * Returns:
    * returns an instance of a Annotation object. If it failed, it returns null.
    */
   Annotation createTextAnnot(HaruRect rect, string text, HaruEncoder encoder = null) {
      HPDF_Encoder _encoder = null;
      if (encoder !is null) {
         _encoder = encoder.getHandle();
      }

      HPDF_Annotation annotation = HPDF_Page_CreateTextAnnot(this._page, rect, text.toStringz(), _encoder);
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
   Annotation createLinkAnnot(HaruRect rect, HaruDestination dst) {
      HPDF_Annotation annotation = HPDF_Page_CreateLinkAnnot(this._page, rect, dst.destination);
      return new Annotation(annotation);
   }

   /**
    * Creates a new web link Annotation instance object for the page.
    *
    * Params:
    *
    * rect = A rectangle of clickable area.
    * dst = A handle of destination object to jump to.
    *
    * Returns:
    *
    * returns an instance of a Annotation object. If it failed, it returns null.
    */
   Annotation createURILinkAnnot(HaruRect rect, string uri) {
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
    * when textWidth() succeed, it returns the width of the text in current fontsize, 
    * character spacing and word spacing. 
    * Otherwise it returns ZERO and error-handler is called.
    */
   HPDF_REAL textWidth(string text) {
      return HPDF_Page_TextWidth(this._page, text.toStringz());
   }

   /**
    * Calculates the byte length which can be included within the specified width.
    *
    * Params:
    * text = The text to get width.
    * width = The width of the area to put the text.
    * wordwrap = When there are three words of "ABCDE", "FGH", and "IJKL", and the substring until "J" can be included within the width, if word_wrap parameter is false it returns 12, and if word_wrap parameter is true, it returns 10 (the end of the previous word).
    * real_width = If this parameter is not null, the real widths of the text is set. An application can set it to null, if it is unnecessary.
    *
    * Return:
    * When HPDF_Page_Font_MeasureText() succeed, it returns the byte length which can be included within the specified width in current fontsize, character spacing and word spacing. Otherwise it returns ZERO and error-handler is called.
    */
   HPDF_UINT measureText(string text, HPDF_REAL width, bool wordwrap, HPDF_REAL* real_width) {
      return HPDF_Page_MeasureText(this._page, text.toStringz(), width, cast(uint) wordwrap, real_width);
   }

   /**
    * Gets the current graphics mode.
    *
    * Returns:
    * when getGMode() succeed, it returns the current graphics mode of the page. Otherwise it returns 0.
    */
   HPDF_UINT16 getGMode() {
      return HPDF_Page_GetGMode(this._page);
   }

   /**
    * Gets the current position for path painting. An application can invoke getCurrentPos() only when graphics mode is HPDF_GMODE_PATH_OBJECT.
    *
    * Returns:
    * when getCurrentPos() succeed, it returns a HaruPoint struct indicating the current position for path painting of the page. Otherwise it returns a HaruPoint struct of {0, 0}.
    */
   HaruPoint getCurrentPos() {
      return HPDF_Page_GetCurrentPos(this._page);
   }

   /**
    * Gets the current position for text showing. An application can invoke getCurrentTextPos() only when graphics mode is HPDF_GMODE_TEXT_OBJECT.
    *
    * Returns:
    * when getCurrentTextPos() succeed, it returns a HaruPoint struct indicating the current position for text showing of the page.
    * Otherwise it returns a HaruPoint struct of {0, 0}.
    */
   HaruPoint getCurrentTextPos() {
      return HPDF_Page_GetCurrentTextPos(this._page);
   }

   /**
    * Gets a HaruFont instance of the page's current font.
    *
    * Returns:
    * when getCurrentFont() succeed, it returns a HaruFont instance of the page's current font. Otherwise it returns null.
    */
   HaruFont getCurrentFont() {
      HPDF_Font font = HPDF_Page_GetCurrentFont(this._page);
      return new HaruFont(font);
   }

   /**
    * Gets the size of the page's current font.
    *
    * Returns:
    * when getCurrentFont() succeed, it returns the size of the page's current font. Otherwise it returns 0.
    */
   HPDF_REAL getCurrentFontSize() {
      return HPDF_Page_GetCurrentFontSize(this._page);
   }

   /**
    * Gets the current transformation matrix of the page.
    *
    * Returns:
    * when getTransMatrix() succeed, it returns a HaruTransMatrix struct of current transformation matrix of the page
    */
   HaruTransMatrix getTransMatrix() {
      return HPDF_Page_GetTransMatrix(this._page);
   }

   /**
    * Gets the current line width of the page.
    *
    * Returns:
    * when getLineWidth() succeed, it returns the current line width for path painting of the page. Otherwise it returns HPDF_DEF_LINEWIDTH.
    */
   HPDF_REAL getLineWidth() {
      return HPDF_Page_GetLineWidth(this._page);
   }

   /**
    * Gets the current line cap style of the page.
    *
    * Returns:
    * when getLineCap() succeed, it returns the current line cap style of the page. Otherwise it returns HPDF_DEF_LINECAP.
    */
   HaruLineCap getLineCap() {
      return HPDF_Page_GetLineCap(this._page);
   }

   /**
    * Gets the current line join style of the page.
    *
    * Returns:
    * when getLineJoin() succeed, it returns the current line join style of the page. Otherwise it returns HPDF_DEF_LINEJOIN.
    */
   HaruLineJoin getLineJoin() {
      return HPDF_Page_GetLineJoin(this._page);
   }

   /**
    * Gets the current value of the page's miter limit.
    *
    * Returns:
    * when getLineJoin() succeed, it returns the current value of the page's miter limit. Otherwise it returns HPDF_DEF_MITERLIMIT.
    */
   HPDF_REAL getMiterLimit() {
      return HPDF_Page_GetMiterLimit(this._page);
   }

   /**
    * Gets the current pattern of the page.
    *
    * Returns:
    * when getMiterLimit() succeeds, it returns a HaruDashMode struct of the current pattern of the page.
    */
   HaruDashMode getDash() {
      return HPDF_Page_GetDash(this._page);
   }

   /**
    * Gets the current value of the page's flatness.
    *
    * Return:
    * when getFlat() succeed, it returns the current value of the page's miter limit. Otherwise it returns HPDF_DEF_FLATNESS.
    */
   HPDF_REAL getFlat() {
      return HPDF_Page_GetFlat(this._page);
   }

   /**
    * Gets the current value of the page's character spacing.
    *
    * Returns:
    * when getCharSpace() succeed, it returns the current value of the page's character spacing. Otherwise it returns 0.
    */
   HPDF_REAL getCharSpace() {
      return HPDF_Page_GetCharSpace(this._page);
   }

   /**
    * Get the current value of the page's word spacing.
    *
    * Returns:
    * when getWordSpace() succeed, it returns the current value of the page's word spacing. Otherwise it returns 0.
    */
   HPDF_REAL getWordSpace() {
      return HPDF_Page_GetWordSpace(this._page);
   }

   /**
    * Gets the current value of the page's horizontal scalling for text showing.
    *
    * Returns:
    * when getHorizontalScalling() succeed, it returns the current value of the page's horizontal scalling. Otherwise it returns HPDF_DEF_HSCALING.
    */
   HPDF_REAL getHorizontalScalling() {
      return HPDF_Page_GetHorizontalScalling(this._page);
   }

   /**
    * Gets the current value of the page's line spacing.
    *
    * Returns:
    * when getTextLeading() succeed, it returns the current value of the line spacing. Otherwise it returns 0.
    */
   HPDF_REAL getTextLeading() {
      return HPDF_Page_GetTextLeading(this._page);
   }

   /**
    * Gets the current value of the page's text rendering mode.
    *
    * Returns:
    * when getTextRenderingMode() succeed, it returns the current value of the text rendering mode. Otherwise it returns 0.
    */
   HPDF_REAL getTextRenderingMode() {
      return HPDF_Page_GetTextRenderingMode(this._page);
   }

   /**
    * Gets the current value of the page's text rising.
    *
    * Returns:
    * when getTextRise() succeed, it returns the current value of the text rising. Otherwise it returns 0.
    */
   HPDF_REAL getTextRise() {
      return HPDF_Page_GetTextRise(this._page);
   }

   /**
    * Gets the current value of the page's filling color. getRGBFill() is valid only when the page's filling color space is HPDF_CS_DEVICE_RGB.
    *
    * Returns:
    * when getRGBFill() succeed, it returns the current value of the page's filling color. Otherwise it returns {0, 0, 0}.
    */
   HaruRGBColor getRGBFill() {
      return HPDF_Page_GetRGBFill(this._page);
   }

   /**
    * Gets the current value of the page's stroking color. getRGBStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_RGB.
    *
    * Returns:
    * when getRGBStroke() succeed, it returns the current value of the page's stroking color. Otherwise it returns {0, 0, 0}.
    */
   HaruRGBColor getRGBStroke() {
      return HPDF_Page_GetRGBStroke(this._page);
   }

   /**
    * Gets the current value of the page's filling color. getCMYKFill() is valid only when the page's filling color space is HPDF_CS_DEVICE_CMYK.
    *
    * Returns:
    * when getCMYKFill() succeed, it returns the current value of the page's filling color. Otherwise it returns {0, 0, 0, 0}.
    */
   HaruCMYKColor getCMYKFill() {
      return HPDF_Page_GetCMYKFill(this._page);
   }

   /**
    * Gets the current value of the page's stroking color. getCMYKStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_CMYK.
    *
    * Returns:
    * when getCMYKStroke() succeed, it returns the current value of the page's stroking color. Otherwise it returns {0, 0, 0, 0}.
    */
   HaruCMYKColor getCMYKStroke() {
      return HPDF_Page_GetCMYKStroke(this._page);
   }

   /**
    * Gets the current value of the page's filling color. getGrayFill() is valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY.
    *
    * Returns:
    * when getGrayFill() succeed, it returns the current value of the page's filling color. Otherwise it returns 0.
    */
   HPDF_REAL getGrayFill() {
      return HPDF_Page_GetGrayFill(this._page);
   }

   /**
    * Gets the current value of the page's stroking color. getGrayStroke() is valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY.
    *
    * Returns:
    * when getGrayStroke() succeed, it returns the current value of the page's stroking color. Otherwise it returns 0.
    */
   HPDF_REAL getGrayStroke() {
      return HPDF_Page_GetGrayStroke(this._page);
   }

   /**
    * Gets the current value of the page's stroking color space.
    *
    * Returns:
    * when getStrokingColorSpace() succeed, it returns the current value of the page's stroking color space. Otherwise it returns HPDF_CS_EOF.
    */
   HaruColorSpace getStrokingColorSpace() {
      return HPDF_Page_GetStrokingColorSpace(this._page);
   }

   /**
    * Gets the current value of the page's stroking color space.
    *
    * Returns:
    * when getFillingColorSpace() succeed, it returns the current value of the page's stroking color space. Otherwise it returns HPDF_CS_EOF.
    */
   HaruColorSpace getFillingColorSpace() {
      return HPDF_Page_GetFillingColorSpace(this._page);
   }

   /**
    * Gets the current text transformation matrix of the page.
    *
    * Returns:
    * when getTextMatrix() succeed, it returns a HaruTransMatrix struct of current text transformation matrix of the page.
    */
   HaruTransMatrix getTextMatrix() {
      return HPDF_Page_GetTextMatrix(this._page);
   }

   /**
    * Gets the number of the page's graphics state stack.
    *
    * Returns:
    * when getGStateDepth() succeed, it returns the number of the page's graphics state stack. Otherwise it returns 0.
    */
   HPDF_UINT getGStateDepth() {
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
   HPDF_STATUS setSlideShow(HaruTransitionStyle type, HPDF_REAL disp_time, HPDF_REAL trans_time) {
      return HPDF_Page_SetSlideShow(this._page, type, disp_time, trans_time);
   }

   /**
    * Appends a circle arc to the current path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_PATH_OBJECT.
    * After - HPDF_GMODE_PATH_OBJECT.
    *
    * Params:
    * x, y = The center point of the circle.
    * radius = The radius of the circle.
    * ang1 = The angle of the begining of the arc.
    * ang2 = The angle of the end of the arc. It must be greater than ang1.
    *
    */
   HPDF_STATUS arc(HPDF_REAL x, HPDF_REAL y, HPDF_REAL ray, HPDF_REAL ang1, HPDF_REAL ang2) {
      return HPDF_Page_Arc(this._page, x, y, ray, ang1, ang2);
   }

   /**
    * Begins a text object and sets the text position to (0, 0).
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PAGE_DESCRIPTION.<br />
    * After - HPDF_GMODE_TEXT_OBJECT.
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
    * Graphics Mode
    * Before - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS circle(HPDF_REAL x, HPDF_REAL y, HPDF_REAL ray) {
      return HPDF_Page_Circle(this._page, x, y, ray);
   }

   /**
    * Write documentation
    */
   HPDF_STATUS clip() {
      return HPDF_Page_Clip(this._page);
   }

   /**
    * Appends a straight line from the current point to the start point of sub path. The current point is moved to the start point of sub path
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS closePath() {
      return HPDF_Page_ClosePath(this._page);
   }

   /**
    * Closes the current path. Then, it paints the path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS closePathStroke() {
      return HPDF_Page_ClosePathStroke(this._page);
   }

   /**
     HPDF_STATUS ClosePathEoillStroke()
     {
     return HPDF_Page_ClosePathEoillStroke(this._page);
     }
    */

   /**
    * Closes the current path, fills the current path using the nonzero winding number rule, then paints the path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.
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
   HPDF_STATUS concat(HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, HPDF_REAL x, HPDF_REAL y) {
      return HPDF_Page_Concat(this._page, a, b, c, d, x, y);
   }

   /**
    * Appends a Bézier curve to the current path using the control points (x1, y1) and (x2, y2) and (x3, y3), then sets the current point to (x3, y3).
    *
    * Params:
    * x1, y1, x2, y2, x3, y3 = The control points for a Bézier curve.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS curveTo(HPDF_REAL x1, HPDF_REAL y1, HPDF_REAL x2, HPDF_REAL y2, HPDF_REAL x3, HPDF_REAL y3) {
      return HPDF_Page_CurveTo(this._page, x1, y1, x2, y2, x3, y3);
   }

   /**
    * Appends a Bézier curve to the current path using the current point and (x2, y2) and (x3, y3) as control points. Then, the current point is set to (x3, y3).
    *
    * Params:
    * x2, y2, x3, y3 = Control points for Bézier curve, along with current point.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS curveTo2(HPDF_REAL x2, HPDF_REAL y2, HPDF_REAL x3, HPDF_REAL y3) {
      return HPDF_Page_CurveTo2(this._page, x2, y2, x3, y3);
   }

   /**
    * Appends a Bézier curve to the current path using two spesified points. The point (x1, y1) and the point (x3, y3) are used as the control points for a Bézier curve and current point is moved to the point (x3, y3)
    *
    * Params:
    * x1, y1, x3, y3 = The control points for a Bézier curve.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS curveTo3(HPDF_REAL x1, HPDF_REAL y1, HPDF_REAL x3, HPDF_REAL y3) {
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
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS drawImage(HaruImage image, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height) {
      return HPDF_Page_DrawImage(this._page, image.getHandle(), x, y, width, height);
   }

   /**
    * Appends an ellipse to the current path.
    *
    * Params:
    * x, y = The center point of the ellipse.
    * x_radius, y_radius = Horizontal and vertical radii of the ellipse.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS ellipse(HPDF_REAL x, HPDF_REAL y, HPDF_REAL xray, HPDF_REAL yray) {
      return HPDF_Page_Ellipse(this._page, x, y, xray, yray);
   }

   /**
    * Ends the path object without filling or painting.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS endPath() {
      return HPDF_Page_EndPath(this._page);
   }

   /**
    * Ends a text object.
    *
    * Graphic Mode
    * Before: HPDF_GMODE_TEXT_OBJECT.<br />
    * After: HPDF_GMODE_PAGE_DESCRIPTION.
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
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.<br />
    */
   HPDF_STATUS eofill() {
      return HPDF_Page_Eofill(this._page);
   }

   /**
    * Fills the current path using the even-odd rule, then paints the path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.<br />
    */
   HPDF_STATUS eofillStroke() {
      return HPDF_Page_EofillStroke(this._page);
   }

   /**
    * Fills the current path using the nonzero winding number rule.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.<br />
    */
   HPDF_STATUS fill() {
      return HPDF_Page_Fill(this._page);
   }

   /**
    * Fills the current path using the nonzero winding number rule, then paints the path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS fillStroke() {
      return HPDF_Page_FillStroke(this._page);
   }

   /**
    * Restore the graphics state which is saved by HPDF_Page_GSave().
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS gRestore() {
      return HPDF_Page_GRestore(this._page);
   }

   /**
    * Saves the page's current graphics parameter to the stack. An application can invoke gSave() up to 28 (???) and can restore the saved parameter by invoking gRestore().
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
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS gSave() {
      return HPDF_Page_GSave(this._page);
   }

   /**
    * Appends a path from the current point to the specified point.
    *
    * Params:
    * x, y = The end point of the path
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS lineTo(HPDF_REAL x, HPDF_REAL y) {
      return HPDF_Page_LineTo(this._page, x, y);
   }

   /**
    * Changes the current text position, using the specified offset values. If the current text position is (x1, y1), the new text position will be (x1 + x, y1 + y).
    *
    * Params:
    * x, y = The offset to new text position.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS moveTextPos(HPDF_REAL x, HPDF_REAL y, bool set_leading = false) {
      if (set_leading) {
         return HPDF_Page_MoveTextPos2(this._page, x, y);
      }

      return HPDF_Page_MoveTextPos(this._page, x, y);
   }

   /**
    * Starts a new subpath and move the current point for drawing path, HPDF_Page_MoveTo() sets the start point for the path to the point (x, y).
    *
    * Params:
    * x, y = The start point for drawing path
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_PATH_OBJECT.
    * After - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS moveTo(HPDF_REAL x, HPDF_REAL y) {
      return HPDF_Page_MoveTo(this._page, x, y);
   }

   /**
    * Moves to the next line.
    *
    */
   HPDF_STATUS moveToNextLine() {
      return HPDF_Page_MoveToNextLine(this._page);
   }

   /**
    * Appends a rectangle to the current path.
    *
    * Params:
    * x, y = The lower-left point of the rectangle.
    * width = The width of the rectangle.
    * height = The height of the rectangle.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_PATH_OBJECT.
    * After - HPDF_GMODE_PATH_OBJECT.
    */
   HPDF_STATUS rectangle(HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height) {
      return HPDF_Page_Rectangle(this._page, x, y, width, height);
   }

   /**
    * Sets the character spacing for text.
    *
    * Params:
    * value = The character spacing (initial value is 0).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setCharSpace(HPDF_REAL value) {
      return HPDF_Page_SetCharSpace(this._page, value);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * c, m, y, k = The level of each color element. They must be between 0 and 1.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setCMYKFill(HPDF_REAL c, HPDF_REAL m, HPDF_REAL y, HPDF_REAL k) {
      return HPDF_Page_SetCMYKFill(this._page, c, m, y, k);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * c, m, y, k = The level of each color element. They must be between 0 and 1.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setCMYKStroke(HPDF_REAL c, HPDF_REAL m, HPDF_REAL y, HPDF_REAL k) {
      return HPDF_Page_SetCMYKStroke(this._page, c, m, y, k);
   }

   /**
    * Sets the dash pattern for lines in the page.
    *
    * Params:
    * dash_pattern = Pattern of dashes and gaps used to stroke paths.
    * num_elem = Number of elements in dash_pattern. 0 <= num_param <= 8.
    * phase = The phase in which the pattern begins (default is 0).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setDash(HPDF_UINT16* dash_ptn, HPDF_UINT num_param, HPDF_UINT phase) {
      return HPDF_Page_SetDash(this._page, dash_ptn, num_param, phase);
   }

   /**
    * Applyies the graphics state to the page.
    *
    * Params:
    * ext_gstate = The handle of an extended graphics state object.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION.
    */
   HPDF_STATUS setExtGState(HPDF_ExtGState ext_gstate) {
      return HPDF_Page_SetExtGState(this._page, ext_gstate);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * value = The value of the gray level between 0 and 1.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setGrayFill(HPDF_REAL gray) {
      return HPDF_Page_SetGrayFill(this._page, gray);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * value = The value of the gray level between 0 and 1.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setGrayStroke(HPDF_REAL gray) {
      return HPDF_Page_SetGrayStroke(this._page, gray);
   }

   /**
    * Sets the type of font and size leading.
    *
    * Params:
    * font = The handle of a font object.
    * size = The size of a font.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setFontAndSize(HaruFont font, HPDF_REAL size) {
      return HPDF_Page_SetFontAndSize(this._page, font.getHandle(), size);
   }

   /**
    * Sets the horizontal scalling (scaling) for text showing.
    *
    * Params:
    * value = The value of horizontal scalling (scaling) (initially 100).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setHorizontalScalling(HPDF_REAL value) {
      return HPDF_Page_SetHorizontalScalling(this._page, value);
   }

   /**
    * Sets the width of the line used to stroke a path.
    *
    * Params:
    * line_width = The line width to use (default is 1).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setLineWidth(HPDF_REAL line_width) {
      return HPDF_Page_SetLineWidth(this._page, line_width);
   }

   /**
    * Sets the shape to be used at the ends of lines.
    *
    * Params:
    * line_cap - The line cap style (one of the following).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setLineCap(HaruLineCap line_cap) {
      return HPDF_Page_SetLineCap(this._page, line_cap);
   }

   /**
    * Sets the line join style in the page.
    *
    * Params:
    * line_join = The line join style (one of the following).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setLineJoin(HaruLineJoin line_join) {
      return HPDF_Page_SetLineJoin(this._page, line_join);
   }

   /**
    * Sets the miter limit
    */
   HPDF_STATUS setMiterLimit(HPDF_REAL miter_limit) {
      return HPDF_Page_SetMiterLimit(this._page, miter_limit);
   }

   /**
    * Sets the text leading (line spacing) for text showing.
    *
    * Params:
    * value = The value of text leading (initial value is 0).
    */
   HPDF_STATUS setTextLeading(HPDF_REAL value) {
      return HPDF_Page_SetTextLeading(this._page, value);
   }

   /**
    * Sets the text matrix
    */
   HPDF_STATUS setTextMatrix(HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, HPDF_REAL x, HPDF_REAL y) {
      return HPDF_Page_SetTextMatrix(this._page, a, b, c, d, x, y);
   }

   /**
    * Sets the text rendering mode. The initial value of text rendering mode is HPDF_FILL.
    *
    * Params:
    * mode = The text rendering mode (one of the following values)
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setTextRenderingMode(HaruTextRenderingMode mode) {
      return HPDF_Page_SetTextRenderingMode(this._page, mode);
   }

   /**
    * Moves the text position in vertical direction by the amount of value. Useful for making subscripts or superscripts.
    *
    * Params:
    * value = Text rise, in user space units.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setTextRise(HPDF_REAL value) {
      return HPDF_Page_SetTextRise(this._page, value);
   }

   /**
    * Sets the filling color.
    *
    * Params:
    * r, g, b = The level of each color element. They must be between 0 and 1. (See "Colors")
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setRGBFill(HPDF_REAL r, HPDF_REAL g, HPDF_REAL b) {
      return HPDF_Page_SetRGBFill(this._page, r, g, b);
   }

   /**
    * Sets the stroking color.
    *
    * Params:
    * r, g, b = The level of each color element. They must be between 0 and 1. (See "Colors")
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setRGBStroke(HPDF_REAL r, HPDF_REAL g, HPDF_REAL b) {
      return HPDF_Page_SetRGBStroke(this._page, r, g, b);
   }

   /**
    * Sets the word spacing for text.
    *
    * Params:
    * value = The value of word spacing (initial value is 0).
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_PAGE_DESCRIPTION or HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS setWordSpace(HPDF_REAL value) {
      return HPDF_Page_SetWordSpace(this._page, value);
   }

   HPDF_STATUS showText(string text) {
      return HPDF_Page_ShowText(this._page, text.toStringz());
   }

   /**
    * Moves the current text position to the start of the next line, then prints the text at the current position on the page.
    *
    * Params:
    * text = The text to print.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS showTextNextLine(string text, HPDF_REAL word_space = 0.0, HPDF_REAL char_space = 0.0) {
      /**
        if( word_space || char_space )
        {
        return HPDF_Page_ShowTextNextLineEx(this._page, word_space, char_space, text);
        }
       */
      return HPDF_Page_ShowTextNextLine(this._page, text.toStringz());
   }

   /**
    * Paints the current path.
    *
    * Graphics Mode
    * Before - HPDF_GMODE_PATH_OBJECT.<br />
    * After - HPDF_GMODE_PAGE_DESCRIPTION.<br />
    */
   HPDF_STATUS stroke() {
      return HPDF_Page_Stroke(this._page);
   }

   /**
    * Prints the text on the specified position.
    *
    * Params:
    * xpos, ypos = The point position where the text is displayed.
    * text = The text to show.
    *
    * Graphics Mode
    * Before and after - HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS textOut(HPDF_REAL xpos, HPDF_REAL ypos, string text) {
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
    * Graphics Mode
    * Before and after - HPDF_GMODE_TEXT_OBJECT.
    */
   HPDF_STATUS textRect(HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, HPDF_REAL bottom, string text, HaruTextAlignment align_, HPDF_UINT* len) {
      return HPDF_Page_TextRect(this._page, left, top, right, bottom, text.toStringz(), align_ , len);
   }

   HPDF_HANDLE getHandle() {
      return _page;
   }
}
