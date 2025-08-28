import 'package:battery/app_library.dart';
import 'package:battery/common/services/user.dart';
import 'widgets/login_bg_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (controller) {
        return ColoredBox(
          color: AppColorPicker.bgf6f6f6,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: AppColorPicker.transparent0,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColorPicker.transparent,
            ),
            child: LoginBgWidget(
              bgPath: AssetsImages.loginBgPng,
              child: Scaffold(
                backgroundColor: AppColorPicker.transparent0,
                body: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildView(controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // 主视图
  Widget _buildView(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: kToolbarHeight + 40.hi),
          child: ImageWidget(
            imageUrl: AssetsImages.loginTopPng,
            width: 100.25.wi,
          ),
        ),
        _buildAccount(account: UserService.to.user.value.username),
        SizedBox(
          height: 60.hi,
        ),
        _buildLoginGroup(controller),
        SizedBox(
          height: 122.hi,
        ),
        Text(
          'thirdPartyAccountLogin'.tr,
          textAlign: TextAlign.center,
          style: getFontStyle(
            fontSize: 11,
            color: AppColorPicker.f66,
          ),
        ),
        SizedBox(
          height: 16.hi,
        ),
        IconButton(
          onPressed: () {},
          style: ButtonStyle(
              padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 6.wi))),
          icon: Column(
            children: [
              ImageWidget(
                imageUrl: AssetsImages.loginDownPng,
                width: 40.wi,
              ),
              Text(
                'zalo'.tr,
                style:
                    getFontStyle(fontSize: 11, color: AppColorPicker.f0068ff),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.hi,
        ),
        Text(
          'loginHint'.tr,
          textAlign: TextAlign.center,
          style: getFontStyle(
            fontSize: 11,
            color: AppColorPicker.f66,
          ),
        ),
      ],
    );
  }

  _buildAccount({String? account}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 87.hi, bottom: 12.hi),
          child: Text(
            account != null && account.isNotEmpty
                ? (account.contains('@')
                    ? '${account.substring(0, 3)}...${account.substring(account.indexOf('@'))}'
                    : account)
                : 'firstLoginHint'.tr,
            textAlign: TextAlign.center,
            style: getFontStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'loginEmailTips'.tr,
          style: getFontStyle(fontSize: 12, color: AppColorPicker.f66),
        ),
      ],
    );
  }

  _buildLoginGroup(LoginController controller) {
    return Column(
      children: [
        _buildLoginBtn(
          titleTextStyle: getFontStyle(
            fontSize: 18,
            color: AppColorPicker.white,
          ),
          decoration: BoxDecoration(
            color: AppColorPicker.bg00bdff,
            borderRadius: BorderRadius.circular(25.ri),
            gradient: SweepGradient(
              endAngle: 347.wi / 2,
              colors: const [
                AppColorPicker.bg00bdff,
                AppColorPicker.bg61abff,
              ],
            ),
          ),
          title: 'oneClickLogin'.tr,
          clickCall: () {
            controller.oneClickLogin(LoginType.oneClickLogin);
          },
        ),
        SizedBox(
          height: 16.hi,
        ),
        _buildLoginBtn(
            titleTextStyle: getFontStyle(
              fontSize: 18,
            ),
            decoration: BoxDecoration(
              color: AppColorPicker.white,
              borderRadius: BorderRadius.circular(25.ri),
              gradient: SweepGradient(
                endAngle: 347.wi / 2,
                colors: const [
                  AppColorPicker.white,
                  AppColorPicker.white,
                ],
              ),
            ),
            title: 'otherEmailLogin'.tr,
            clickCall: () {
              controller.oneClickLogin(LoginType.oterLogin);
            }),
      ],
    );
  }

  _buildLoginBtn(
      {required String title,
      TextStyle? titleTextStyle,
      required BoxDecoration decoration,
      ClickCall? clickCall}) {
    return InkButton(
      textStyle: titleTextStyle,
      title: title,
      onTap: clickCall,
      width: 347.wi,
      padding: EdgeInsets.only(top: 13.hi, bottom: 12.hi),
      decoration: decoration,
    );
  }
}
