import 'package:battery/app_library.dart';
import 'package:battery/common/services/blue.dart';
import 'package:my_tool_kit/my_bluetooth.dart';

class VircController extends GetxController {
  VircController();

  /// 创建单例模式
  static VircController get to => Get.find<VircController>();
  RxBool lockStatus = false.obs;
  RxBool bindingStatus = false.obs;

  _initData() {
    update(["virc"]);
  }

  Future<void> checkPermissions() async {
    BluetoothDataService.to.updataDevice();
    BluetoothDataService.to.gerDevice();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermissions();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      BluetoothDataService.to.initDevice();
    });
    _initData();
  }
}
