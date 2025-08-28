import 'package:battery/app_library.dart';

class BindBatteryPage extends GetView<VircController> {
  const BindBatteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VircController>(
        init: VircController(),
        // tag: 'virc',
        builder: (controller) {
          return Scaffold(
            appBar: context.getAppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.wi),
              child: Column(
                children: [
                  AnimatedCrossFade(
                    firstChild: _buildHint(
                      hint: 'batterySuccessfullyBound'.tr,
                      iconPath: AssetsImages.boundSuccessPng,
                    ),
                    secondChild: _buildHint(
                      hint: 'theBatteryHasBeenBound'.tr,
                      iconPath: AssetsImages.theBatteryHasBeenBoundPng,
                    ),
                    crossFadeState: !(Get.arguments != null &&
                            Get.arguments is bool &&
                            Get.arguments)
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 200),
                  ),
                  const Spacer(),
                  _buildConfirm(
                    title: 'confirm'.tr,
                    onTap: () {
                      // Get.offNamed(RouteNames.addDevice);
                      // Get.until((setting)=>Get.previousRoute==RouteNames.home);
                      Get.back(result: true);
                      Get.back(result: true);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 34.hi,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Column _buildHint({required String hint, required String iconPath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 69.hi),
          child: ImageWidget(
            imageUrl: iconPath,
            width: 172.wi,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.hi),
          child: Text(
            hint,
            style: getFontStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _buildConfirm({
    required String title,
    ClickCall? onTap,
  }) {
    return InkButton(
      title: title,
      textStyle: getFontStyle(
        fontSize: 16,
        color: AppColorPicker.white,
      ),
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 15.hi),
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
}
