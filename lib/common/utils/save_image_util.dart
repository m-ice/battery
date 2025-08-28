import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImageUtil {
  static Future<dynamic> saveImageToPhotoAlbum({ByteData? byteData}) async {
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      return result;
    }
    return null;
  }
}
