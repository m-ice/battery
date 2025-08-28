import 'package:permission_handler/permission_handler.dart';

// 请求定位权限
void requestLocationPermission() async {
  // 申请定位权限
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.phone,
  ].request();
  // 判断权限状态
  if (statuses[Permission.location] != PermissionStatus.granted) {
    // 未授权
    // print('未授权定位权限');
  }
  if (statuses[Permission.storage] != PermissionStatus.granted) {
    // 未授权
    // print('未授权存储权限');
  }
}
