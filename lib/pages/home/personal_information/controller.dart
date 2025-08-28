import 'package:battery/app_library.dart';

class PersonalInformationController extends GetxController {
  PersonalInformationController();

  Rx<dynamic> avatar =
      'https://img0.baidu.com/it/u=1531480230,393164074&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1733936400&t=73f15ee34e9c51bc54d833f1a9e21062'
          .obs;
  var localFile = Rx<File?>(null);
  _initData() {
    update(["personalInformation"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
