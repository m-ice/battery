import 'package:battery/app_library.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();
  // static ImagePickerService? _singleton;
  // static ImagePickerService? getInstance() {
  //   if (_singleton == null) {
  //     if (_singleton == null) {
  //       var singleton = ImagePickerService._();
  //       _picker = ImagePicker();
  //       _singleton = singleton;
  //     }
  //   }
  //   return _singleton;
  // }

  // ImagePickerService._();

  static Future<File?> getPickerImage() async {
    File? file;
    try {
      dynamic xFile = await _picker.pickImage(source: ImageSource.gallery);
      file = xFile != null ? File(xFile.path) : null;
      if (file != null && !(file.path.toString().endsWith('.gif'))) {
        dynamic xF =
            (await ImageCompressUtil.imageCompressAndGetFile(file));
        xFile=(xF is XFile?xF:XFile(xF.path));
      }
      file = xFile != null ? File(xFile.path) : null;
      return file;
    } catch (e) {
      LogUtil.e(e);
    }
    return null;
  }
}
