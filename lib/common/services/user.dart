import 'dart:convert';

import 'package:battery/common/models/api/res_user_entity.dart';
import 'package:battery/common/utils/sp_util.dart';
import 'package:battery/common/values/constants.dart';
import 'package:get/get.dart';
import 'package:my_tool_kit/my_log.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  ///用户信息
  Rx<ResUserUserinfo> user = ResUserUserinfo().obs;

  String userName = '';
  String password = '';

  ///获取存储的用户信息
  void getUser() {
    final datas = SpUtil.getString(Constants.userInfo);
    if (datas?.isNotEmpty ?? false) {
      MyLog.d(datas.toString());
      // 将 JSON 字符串解析为 Map
      Map<String, dynamic> userInfoMap = jsonDecode(datas ?? '');

      // 使用 fromJson 创建对象
      user.value = ResUserUserinfo.fromJson(userInfoMap);
    }
  }

  ///获取用户存储的账号密码
  void getUserUserNamepassWord() {
    final userData = SpUtil.getString(Constants.userNamePassWord);
    if (userData?.isNotEmpty ?? false) {
      try {
        // 解析 JSON 字符串为 Map
        final Map<String, dynamic> userInfo = jsonDecode(userData ?? "");

        // 获取值
        userName = userInfo['userName'];
        password = userInfo['password'];
        MyLog.d('Username: $userName, Password: $password');
      } catch (e) {
        // 如果解析失败，打印错误信息
        MyLog.d('Error decoding user data: $e');
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
    getUserUserNamepassWord();
  }
}
