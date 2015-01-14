module harud.outline;

import harud.haruobject;
import harud.destination;
import harud.c;
import harud.types;
/**
* Outline class
*/
class Outline: IHaruObject {
   private HPDF_Outline _outline;

   this(HPDF_Outline outline) {
      _outline = outline;
   }

   /**
   * Sets whether this node is opened or not when the outline is displayed for the first time.
   *
   * Params:
   *   opened = Specify whether the node is opened or not.
   */
   HPDF_STATUS setOpened(bool opened) {
      return HPDF_Outline_SetOpened(this._outline, cast(uint) opened);
   }

   /**
   * Sets a destination object which becomes to a target to jump when the outline is clicked.
   *
   * Params:
   *   dst = Specify the handle of an destination object.
   */
   HPDF_STATUS setDestination(Destination dst) {
      assert(dst !is null, "dst should be not null");
      return HPDF_Outline_SetDestination(this._outline, dst.destinationHandle);
   }

   public HPDF_HANDLE getHandle() {
      return _outline;
   }
}
