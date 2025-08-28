import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionConfigUtil {
  // 请求存储权限
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _isAndroid10OrHigher()) {
        return await _requestStoragePermissionAndroid10AndAbove();
      } else {
        return await _requestStoragePermissionBelowAndroid10();
      }
    }
    return false;
  }

  // 请求定位权限
  static Future<bool> requestLocationPermission() async {
    if (Platform.isAndroid) {
      if (await _isAndroid10OrHigher()) {
        return await _requestLocationPermissionAndroid10AndAbove();
      } else {
        return await _requestLocationPermissionBelowAndroid10();
      }
    }
    return false;
  }

  // 判断是否是 Android 10 或更高版本
  static Future<bool> _isAndroid10OrHigher() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 29; // Android 10 (SDK 29) 及以上
  }

  // 请求 Android 10 及以上的存储权限
  static Future<bool> _requestStoragePermissionAndroid10AndAbove() async {
    var mediaLibraryStatus = await Permission.photos.status;
    if (!mediaLibraryStatus.isGranted) {
      var mediaLibraryRequestResult = await Permission.photos.request();
      if (mediaLibraryRequestResult.isDenied) {
        return false;
      }
    }
    return true;
  }

  // 请求 Android 10 以下的存储权限
  static Future<bool> _requestStoragePermissionBelowAndroid10() async {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      var storageRequestResult = await Permission.storage.request();
      if (storageRequestResult.isDenied) {
        return false;
      }
    }
    return true;
  }

  // 请求 Android 10 及以上的定位权限
  static Future<bool> _requestLocationPermissionAndroid10AndAbove() async {
    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      var locationRequestResult = await Permission.location.request();
      if (locationRequestResult.isDenied) {
        return false;
      }
    }

    // 如果需要后台定位权限
    var backgroundLocationStatus = await Permission.locationAlways.status;
    if (!backgroundLocationStatus.isGranted) {
      var backgroundLocationRequestResult =
          await Permission.locationAlways.request();
      if (backgroundLocationRequestResult.isDenied) {
        return false;
      }
    }

    return true;
  }

  // 请求 Android 10 以下的定位权限
  static Future<bool> _requestLocationPermissionBelowAndroid10() async {
    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      var locationRequestResult = await Permission.location.request();
      if (locationRequestResult.isDenied) {
        return false;
      }
    }
    return true;
  }
}
