/**
 * Describes an annotation.
 */
module harud.annotation;

import harud;
import harud.c.capi;

/**
* Haru PDF Annotation Class.
*/
class Annotation : IHaruObject {
   protected HPDF_Annotation _annotation;

   this(HPDF_Annotation annotation) {
      _annotation = annotation;
   }

   /**
   * Defines the appearance when a mouse clicks on a link annotation.
   *
   * Params:
   *   mode = mode for highlighting
   */
   HPDF_STATUS setHighlightMode(HaruAnnotHighlightMode mode) {
      return HPDF_LinkAnnot_SetHighlightMode(this._annotation, mode);
   }

   /**
   * Defines the style of the annotation's border.
   *
   * Params:
   *   width = The width of an annotation's border.
   *   dashOn = The dash style.
   *   dashOff = The dash style
   */
   HPDF_STATUS setBorderStyle(float width, ushort dashOn, ushort dashOff) {
      return HPDF_LinkAnnot_SetBorderStyle(this._annotation, width, dashOn, dashOff);
   }

   /**
   * Defines the style of the annotation's icon
   *
   * Params:
   *   icon = a AnnotationIcon value
   */
   HPDF_STATUS setIcon(HaruAnnotIcon icon) {
      return HPDF_TextAnnot_SetIcon(this._annotation, icon);
   }

   /**
   * Defines whether the text-annotation is initially open.
   *
   * Params:
   *   open = true means the annotation initially displayed open.
   */
   HPDF_STATUS setOpened(bool open) {
      return HPDF_TextAnnot_SetOpened(this._annotation, cast(uint)open);
   }

   public HPDF_HANDLE getHandle() {
      return this._annotation;
   }
}
