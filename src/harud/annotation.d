module harud.annotation;

import harud.haruobject;
//fix import harud.doc;
import harud.c;
//FIXimport harud.c.types;

class Annotation: IHaruObject {
   protected HPDF_Annotation _annotation;

   this(HPDF_Annotation annotation) {
      _annotation =  annotation;
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
   *   dash_on = The dash style.
   *   dash_off = The dash style
   */
   HPDF_STATUS setBorderStyle(float width, ushort dash_on, ushort dash_off) {
      return HPDF_LinkAnnot_SetBorderStyle(this._annotation, width, dash_on, dash_off);
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
      return HPDF_TextAnnot_SetOpened(this._annotation, cast(uint) open);
   }

   public HPDF_HANDLE getHandle() {
      return this._annotation;
   }
}
