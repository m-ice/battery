import 'package:flutter/services.dart';
import 'package:my_tool_kit/my_log.dart';

class ZaloShare {
  static const MethodChannel _channel = MethodChannel('zalo_share');

  static Future<void> shareImage(String path) async {
    try {
      await _channel.invokeMethod('shareImageToZalo', {'path': path});
    } catch (e) {
      MyLog.d("Error sharing image: $e");
    }
  }
}
