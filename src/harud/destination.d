/**
 * Describes a destination
 */
module harud.destination;

import harud;
import harud.c.capi;

/**
* Haru PDF Destination Class.
*/
class Destination {
   private HPDF_Destination _destination;

   this(HPDF_Destination destination) {
      _destination = destination;
   }

   @property HPDF_Destination destinationHandle() {
      return this._destination;
   }

   /**
   * Defines the appearance of a page with three parameters which are left, top and zoom.
   *
   * Params:
   *   left = The left coordinates of the page.
   *   top = The top coordinates of the page.
   *   zoom = The page magnified factor. The value must be between 0.08(8%) to 32(%).
   */
   HPDF_STATUS setXYZ(float left, float top, float zoom) {
      return HPDF_Destination_SetXYZ(this._destination, left, top, zoom);
   }

   /**
   * Sets the appearance of the page to displadescriptionying entire page within the window
   */
   HPDF_STATUS setFit() {
      return HPDF_Destination_SetFit(this._destination);
   }

   /**
   * Defines the appearance of a page to magnifying to fit the width of the page within the window and setting
   * the top position of the page to the value of the "top" parameter.
   *
   * Params:
   *   top = The top coordinates of the page.
   */
   HPDF_STATUS setFitH(float top) {
      return HPDF_Destination_SetFitH(this._destination, top);
   }

   /**
   * Defines the appearance of a page to magnifying to fit the
   * height of the page within the window and setting the left
   * position of the page to the value of the "left" parameter.
   *
   * Params:
   *   left = The left coordinates of the page.
   */
   HPDF_STATUS setFitV(float left) {
      return HPDF_Destination_SetFitV(this._destination, left);
   }

   /**
   * Defines the appearance of a page to magnifying the page to fit a rectangle specified by left, bottom, right and top.
   *
   * Params:
   *   left = The left coordinates of the page.
   *   bottom = The bottom coordinates of the page.
   *   right = The right coordinates of the page.
   *   top = The top coordinates of the page.
   *
   */
   HPDF_STATUS setFitR(float left, float bottom, float right, float top) {
      return HPDF_Destination_SetFitR(this._destination, left, bottom, right, top);
   }

   /**
   * Sets the appearance of the page to magnifying to fit the bounding box of the page within the window.
   *
   */
   HPDF_STATUS setFitB() {
      return HPDF_Destination_SetFitB(this._destination);
   }

   /**
   * Defines the appearance of a page to magnifying to fit the width of the bounding box of the page within the window
   * and setting the top position of the page to the value of the "top" parameter.
   *
   * Params:
   *  top = The top coordinates of the page.
   */
   HPDF_STATUS setFitBH(float top) {
      return HPDF_Destination_SetFitBH(this._destination, top);
   }

   /**
   * Defines the appearance of a page to magnifying to fit the height of the bounding box of the page within the window
   * and setting the left position of the page to the value of the "left" parameter.
   *
   * Params:
   *  left = The left coordinates of the page.
   */
   HPDF_STATUS setFitBV(float left) {
      return HPDF_Destination_SetFitBV(this._destination, left);
   }
}
