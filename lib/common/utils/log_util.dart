import 'dart:developer';

import 'package:battery/app_library.dart';
import 'package:logger/logger.dart';

class LogUtil {
  static println(log) {
    if (kDebugMode) {
      print(log);
    }
  }

  /// todo：完整日志打印
  static logUtil(dynamic msg, {String? tag}) {
    /// todo：只在debug模式执行
    if (!kReleaseMode) {
      log(msg, name: tag ?? 'Battery App日志：');
    }
  }

  static Logger logger = Logger();

  static void d(log) {
    logger.d(log);
  }

  static void t(log) {
    logger.t(log);
  }

  static void i(log) {
    logger.i(log);
  }

  static void w(log) {
    logger.w(log);
  }

  static void e(log) {
    logger.e(log);
  }

  static void f(log) {
    logger.f(log);
  }
}
