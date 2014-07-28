module harud.haruencoder;

import harud.haruobject;
//fix import harud.doc;
import harud.c;
//FIXimport harud.c.types;

class HaruEncoder : IHaruObject {
   protected HPDF_Encoder _encoder;

   this(HPDF_Encoder encoder) {
      _encoder =  encoder;
   }

   /**
   * Gets the type of an encoding object.
   *
   * Return:
   *   a HaruEncoder value
   */
   HaruEncoderType getType() {
      return HPDF_Encoder_GetType(this._encoder);
   }

   /**
   * Get the type of byte in the text at position index.
   *
   * Return:
   *    a HaruEncoderType value
   */
   HaruByteType getByteType(char[] text, HPDF_UINT index) {
      return HPDF_Encoder_GetByteType(this._encoder, cast(char*) text, index);
   }

   /**
   * Converts a specified character code to unicode.
   *
   * Params:
   *   code = A character code to convert.
   *
   * Return:
   *   the converted character to unicode
   */
   HPDF_UNICODE getUnicode(HPDF_UINT16 code) {
      return HPDF_Encoder_GetUnicode(this._encoder, code);
   }

   /**
   * Gets the writing mode for the encoding object.
   *
   * Return:
   *   a HaruWritingMode value
   */
   HaruWritingMode getWritingMode() {
      return HPDF_Encoder_GetWritingMode(this._encoder);
   }



   public HPDF_HANDLE getHandle() {
      return _encoder;
   }

}
