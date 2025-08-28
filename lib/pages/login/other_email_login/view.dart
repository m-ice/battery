import 'package:battery/app_library.dart';
import '../widgets/login_bg_widget.dart';

class OtherEmailLoginView extends GetView<LoginController> {
  const OtherEmailLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: LoginBgWidget(
            bgPath: AssetsImages.loginBgPng,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildView(controller, context),
              ],
            ),
          ),
        );
      },
    );
  }

  // 主视图
  Widget _buildView(LoginController controller, BuildContext context) {
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.wi, vertical: 30.hi),
          padding: EdgeInsets.only(
              left: 25.wi, right: 24.wi, top: 23.hi, bottom: 34.hi),
          decoration: BoxDecoration(
            color: AppColorPicker.white,
            borderRadius: BorderRadius.circular(10.ri),
          ),
          child: Column(
            children: [
              _buildInputTip(
                focusNode: controller.emailFocusNode.value,
                iconPath: AssetsImages.accountPng,
                title: 'emailAddress'.tr,
                inputHint: 'emailAddressHint'.tr,
                keyboardType: TextInputType.emailAddress,
                textEditingController: controller.userName,
                context: context,
              ),
              SizedBox(
                height: 20.hi,
              ),
              Obx(
                () => _buildInputTip(
                    focusNode: controller.passwordFocusNode.value,
                    iconPath: AssetsImages.passwordPng,
                    title: 'password'.tr,
                    inputHint: 'passwordHint'.tr,
                    suffixIconPath: AssetsImages.viewInputPng,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.obscureText.value,
                    textEditingController: controller.password,
                    showPassword: () {
                      controller.obscureText.toggle();
                    },
                    context: context),
              ),
            ],
          ),
        ),
        _buildLoginBtn(
            titleTextStyle: getFontStyle(
              fontSize: 18,
              color: AppColorPicker.white,
            ),
            title: 'login'.tr,
            clickCall: () {
              controller.oneClickLogin(LoginType.emailLogin);
            }),
      ],
    );
  }

  _buildLoginBtn(
      {required String title,
      TextStyle? titleTextStyle,
      ClickCall? clickCall}) {
    return InkButton(
      textStyle: titleTextStyle,
      title: title,
      onTap: clickCall,
      width: 347.wi,
      padding: EdgeInsets.only(top: 13.hi, bottom: 12.hi),
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
    );
  }

  _buildInputTip(
      {required String title,
      required String iconPath,
      required BuildContext context,
      String? suffixIconPath,
      required String inputHint,
      required TextInputType keyboardType,
      ClickCall? showPassword,
      FocusNode? focusNode,
      bool obscureText = false,
      TextEditingController? textEditingController}) {
    return Column(
      children: [
        Row(
          children: [
            ImageWidget(
              imageUrl: iconPath,
              width: 20.wi,
            ),
            SizedBox(
              width: 6.wi,
            ),
            Text(
              title,
              style: getFontStyle(
                fontSize: 16,
                color: AppColorPicker.f58606d,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.hi),
          child: Listener(
            onPointerDown: (e) {
              if (Platform.isAndroid) {
                FocusScope.of(context).requestFocus(focusNode);
              }
            },
            child: TextField(
              controller: textEditingController,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: getFontStyle(fontSize: 14),
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: inputHint,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.ri)),
                filled: true,
                fillColor: AppColorPicker.bgf6f7f9,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 11.hi, horizontal: 18.wi),
                hintStyle: getFontStyle(
                  fontSize: 12,
                  color: AppColorPicker.fc8c7c8,
                ),
                suffixIcon: suffixIconPath != null
                    ? IconButton(
                        onPressed: showPassword,
                        icon: ImageWidget(imageUrl: suffixIconPath))
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
