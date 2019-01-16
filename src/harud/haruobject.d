/**
 * Generic haru object interface
 */
module harud.haruobject;

import harud;

interface IHaruObject {
   protected HPDF_HANDLE getHandle();
}
