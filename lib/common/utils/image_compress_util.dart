import 'package:battery/app_library.dart';
import 'package:my_tool_kit/my_log.dart';

class ImageCompressUtil {
  /// 图片压缩 File -> File
  static Future<Object?> imageCompressAndGetFile(File file) async {
    if (file.lengthSync() < 200 * 1024) {
      return file;
    }
    var quality = 100;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      //4m
      quality = 50;
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      //2m
      quality = 60;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      //1m
      quality = 70;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      //500k
      quality = 80;
    } else if (file.lengthSync() > 0.25 * 1024 * 1024) {
      //250k
      quality = 90;
    }
    var dir = await getTemporaryDirectory();
    var targetPath =
        "${dir.absolute.path}/${Constants.userId}_${DateTime.now().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minHeight: 1920,
      minWidth: 1080,
      quality: quality,
      rotate: 0,
    );

    if (kDebugMode) {
      MyLog.d("压缩后：${file.lengthSync() / 1024}");
    }

    return result;
  }

  /// 图片压缩 File -> Uint8List
  Future<Uint8List?> imageCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    if (kDebugMode) {
      MyLog.d(file.lengthSync());
      MyLog.d(result?.length);
    }

    return result;
  }

  /// 图片压缩 Asset -> Uint8List
  Future<Uint8List?> imageCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }
}
