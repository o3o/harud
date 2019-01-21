/**
 * Describes an encoder
 */
module harud.encoder;

import harud.c;
import harud;

/**
 * Encoder class
 */
class Encoder : IHaruObject {
   protected HPDF_Encoder _encoder;

   this(HPDF_Encoder encoder) {
      _encoder = encoder;
   }

   /**
    * Gets the type of an encoding object.
    *
    * Returns:
    *   a Encoder value
    */
   HaruEncoderType getType() {
      return HPDF_Encoder_GetType(this._encoder);
   }

   /**
    * Get the type of byte in the text at position index.
    *
    * Returns:
    *    a $(LINK2 harud/c/types/HaruByteType.html, HaruByteType) value
    */
   HaruByteType getByteType(char[] text, uint index) {
      return HPDF_Encoder_GetByteType(this._encoder, cast(char*)text, index);
   }

   /**
    * Converts a specified character code to unicode.
    *
    * Params:
    *   code = A character code to convert.
    *
    * Returns:
    *   the converted character to unicode
    */
   HPDF_UNICODE getUnicode(ushort code) {
      return HPDF_Encoder_GetUnicode(this._encoder, code);
   }

   unittest {

   }

   /**
    * Gets the writing mode for the encoding object.
    *
    * Returns:
    *    a $(LINK2 harud/c/types/HaruWritingMode.html, HaruWritingMode) value
    */
   HaruWritingMode getWritingMode() {
      return HPDF_Encoder_GetWritingMode(this._encoder);
   }

   public HPDF_HANDLE getHandle() {
      return _encoder;
   }

}
