module harud.image;

import std.conv;

import harud.haruobject;
import harud.c;
import harud.types;

/**
  Image class
*/
class Image: IHaruObject {
   protected HPDF_Image _image;

   this(HPDF_Image image) {
      _image = image;
   }

   /**
   * Gets the size of the image of an image object.
   *
   * Returns:
   * When succeed, it returns a $(LINK2 harud/c/types/Point.html, Point) struct which includes the size of the image. 
   * Otherwise, it returns a $(LINK2 harud/c/types/Point.html, Point) struct whose value is (0, 0).
   */
   @property Point size() {
      return HPDF_Image_GetSize(this._image);
   }

   /**
   * Gets the width of the image of an image object.
   *
   * Returns:
   *   When succeed, it returns the width of the image. Otherwise, it returns 0.
   */
   @property uint width() {
      return HPDF_Image_GetWidth(this._image);
   }

   /**
   * Gets the height of the image of an image object.
   *
   * Returns:
   *   when succeed, it returns the height of the image. Otherwise, it returns 0.
   */
   @property uint height() {
      return HPDF_Image_GetHeight(this._image);
   }

   /**
   * Gets the number of bits used to describe each color component.
   */
   @property uint bitsPerComponent() {
      return HPDF_Image_GetBitsPerComponent(this._image);
   }

   /**
   * Gets the name of the image's color space.
   *
   * Returns:
   *   when getColorSpace() succeed, it returns the following values. Otherwise, it returns null.
   * $(UL
   *   $(LI DeviceGray)
   *   $(LI DeviceRGB)
   *   $(LI DeviceCMYK)
   *   $(LI Indexed)
   * )
   */
   @property string colorSpace() {
      return to!string(HPDF_Image_GetColorSpace(this._image));
   }

   /**
   * Sets the transparent color of the image by the RGB range values. 
   *
   * The color within the range is displayed as a transparent color. The Image must be RGB color space.
   *
   * Params:
   *   rmin = The lower limit of Red. It must be between 0 and 255.
   *   rmax = The upper limit of Red. It must be between 0 and 255.
   *   gmin = The lower limit of Green. It must be between 0 and 255.
   *   gmax = The upper limit of Green. It must be between 0 and 255.
   *   bmin = The lower limit of Blue. It must be between 0 and 255.
   *   bmax = The upper limit of Blue. It must be between 0 and 255.
   */
   HPDF_STATUS setColorMask(uint rmin,
         uint rmax,
         uint gmin,
         uint gmax,
         uint bmin,
         uint bmax) 

      in {
         assert(rmin < 256, "rmin should less than 256");
         assert(rmax < 256, "rmax should less than 256");
         assert(gmin < 256, "gmin should less than 256");
         assert(gmax < 256, "gmax should less than 256");
         assert(bmin < 256, "bmin should less than 256");
         assert(bmax < 256, "bmax should less than 256");
         
      } body {
         return HPDF_Image_SetColorMask(this._image,
            rmin, rmax,
            gmin, gmax,
            bmin, bmax);
      }

   void setMaskImage(Image maskImage) {
      HPDF_Image_SetMaskImage(this._image, maskImage.getHandle());
   }

   public HPDF_HANDLE getHandle() {
      return _image;
   }
}
