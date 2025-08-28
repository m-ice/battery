import 'dart:convert';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/user.dart';
import 'package:battery/common/services/user.dart';

enum LoginType { emailLogin, oneClickLogin, oterLogin }

class LoginController extends GetxController {
  LoginController();

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool obscureText = true.obs;

  _initData() {
    update(["login"]);
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
    Get.find<AppGlobalController>().getLanguageLocale();
  }

  oneClickLogin(LoginType loginType) {
    switch (loginType) {
      case LoginType.emailLogin:
        loginSuccess();
        break;
      case LoginType.oneClickLogin:
        loginSuccess(type: true);
        break;
      case LoginType.oterLogin:
        Get.toNamed(RouteNames.otherEmailLogin);
        break;
    }
  }

  loginSuccess({bool? type}) async {
    ///一键登录功能
    if (type ?? false) {
      if (UserService.to.userName.isEmpty && UserService.to.password.isEmpty) {
        return;
      }
      final data = await UserApis.login(
          userName: UserService.to.userName, password: UserService.to.password);
      if (data != null) {
        UserService.to.user.value = data.userinfo;
        final dataInfo = data.userinfo.toString();
        SpUtil.putString(Constants.userInfo, dataInfo);
        Get.offAllNamed(RouteNames.home);
      }
      return;
    }
    final username = userName.text;
    final passWord = password.text;

    final data = await UserApis.login(userName: username, password: passWord);
    if (data != null) {
      UserService.to.user.value = data.userinfo;
      final dataInfo = data.userinfo.toString();
      SpUtil.putString(Constants.userInfo, dataInfo);
      await SpUtil.putString(
        Constants.userNamePassWord,
        jsonEncode({
          'userName': userName.text,
          'password': password.text,
        }), // 使用 jsonEncode
      );

      Get.offAllNamed(RouteNames.home);
    }
  }
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
