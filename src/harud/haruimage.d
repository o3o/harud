module harud.haruimage;

import std.conv;

import harud.haruobject;
import harud.c;

/**
* HaruImage class
*/
class HaruImage : IHaruObject {
   protected HPDF_Image _image;

   this(HPDF_Image image) {
      _image =  image;
   }

   /**
   * Gets the size of the image of an image object.
   *
   * Return:
   *   when getSize() succeed, it returns a HaruPoint struct which includes the size of the image. Otherwise, it returns a HaruPoint struct whose value is (0, 0).
   */
   HaruPoint getSize() {
      return HPDF_Image_GetSize(this._image);
   }

   /**
   * Gets the width of the image of an image object.
   *
   * Return:
   *   when getWidth() succeed, it returns the width of the image. Otherwise, it returns 0.
   */
   HPDF_UINT getWidth() {
      return HPDF_Image_GetWidth(this._image);
   }

   /**
   * Gets the height of the image of an image object.
   *
   * Return:
   *   when getHeight() succeed, it returns the height of the image. Otherwise, it returns 0.
   */
   HPDF_UINT getHeight() {
      return HPDF_Image_GetHeight(this._image);
   }

   /**
   * Gets the number of bits used to describe each color component.
   *
   */
   HPDF_UINT getBitsPerComponent() {
      return HPDF_Image_GetBitsPerComponent(this._image);
   }

   /**
   * Gets the name of the image's color space.
   *
   * Return:
   *   when getColorSpace() succeed, it returns the following values. Otherwise, it returns null.
   *
   *   <li> "DeviceGray"</li>
   *   <li>"DeviceRGB"</li>
   *   <li>"DeviceCMYK"</li>
   *   <li>"Indexed"</li>
   */
   string getColorSpace() {
      return to!string(HPDF_Image_GetColorSpace(this._image));
   }

   /**
   * Sets the transparent color of the image by the RGB range values. The color within the range is displayed as a transparent color. The Image must be RGB color space.
   *
   * Return:
   *   rmin = The lower limit of Red. It must be between 0 and 255.
   *   rmax = The upper limit of Red. It must be between 0 and 255.
   *   gmin = The lower limit of Green. It must be between 0 and 255.
   *   gmax = The upper limit of Green. It must be between 0 and 255.
   *   bmin = The lower limit of Blue. It must be between 0 and 255.
   *   bmax = The upper limit of Blue. It must be between 0 and 255.
   */
   HPDF_STATUS setColorMask(
      HPDF_UINT    rmin,
      HPDF_UINT    rmax,
      HPDF_UINT    gmin,
      HPDF_UINT    gmax,
      HPDF_UINT    bmin,
      HPDF_UINT    bmax) {
      return HPDF_Image_SetColorMask(this._image,
                                     rmin,
                                     rmax,
                                     gmin,
                                     gmax,
                                     bmin,
                                     bmax);
   }


   public HPDF_HANDLE getHandle() {
      return _image;
   }

}
