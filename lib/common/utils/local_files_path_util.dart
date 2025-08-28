import 'package:battery/app_library.dart';

class LocalFilesPathUtil {
  static Future<File> saveImageToDisk(Uint8List imageBytes,
      {String? fileName}) async {
    // 获取临时目录
    final directory = await getTemporaryDirectory();
    // 如果没有提供文件名，则生成一个默认的文件名
    final name = fileName ?? '${DateTime.now().millisecondsSinceEpoch}.png';
    // 创建文件路径
    final filePath = '${directory.path}/$name';
    // 创建文件并写入图片字节
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    return file;
  }
}
