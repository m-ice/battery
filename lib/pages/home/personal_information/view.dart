import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/user.dart';
import 'package:battery/common/models/api/res_user_entity.dart';
import 'package:battery/common/services/user.dart';

class PersonalInformationPage extends GetView<PersonalInformationController> {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInformationController>(
        id: 'personalInformation',
        init: PersonalInformationController(),
        builder: (controller) {
          return Obx(
            () => Scaffold(
              appBar: context.getAppBar(
                title: 'personalInformation'.tr,
              ),
              body: ListView(
                padding:
                    EdgeInsets.symmetric(vertical: 20.hi, horizontal: 14.wi),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              SkeletonWidget(
                                width: 60.wi,
                                height: 60.wi,
                                clipBehavior: Clip.hardEdge,
                                cornerRadius: 30.ri,
                                child: ImageWidget(
                                  useExtendedImage: true,
                                  imageUrl:
                                      "${Constants.apiUrl}${UserService.to.user.value.avatar}",
                                  width: 60.wi,
                                ),
                              ),
                              Positioned(
                                top: 40.wi,
                                left: 40.wi,
                                child: ImageWidget(
                                  imageUrl: AssetsImages.imageEditingPng,
                                  width: 20.wi,
                                ),
                              ),
                              Positioned.fill(
                                  child: InkButton(
                                onTap: () async {
                                  ImagePickerService.getPickerImage().then((v) {
                                    if (v != null) {
                                      Get.toNamed(RouteNames.cuttingImage,
                                              arguments: v)
                                          ?.then((file) async {
                                        if (file != null) {
                                          // controller
                                          //   ..localFile.value = file

                                          //   ..update(["personalInformation"]);
                                          final data = await UserApis.upload(
                                              file: file.path);
                                          await UserApis.profile(
                                              avatar: data?.url);
                                          await UserApis.userinfo();
                                          controller
                                              .update(["personalInformation"]);
                                        }
                                      });
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(30.ri),
                                backGroundColor: AppColorPicker.transparent,
                                splashColor:
                                    AppColorPicker.bg00bdff.withOpacity(0.3),
                              ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.hi, bottom: 52.hi),
                            child: Column(
                              children: [
                                Text(
                                  'email'.tr,
                                  style: getFontStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.hi,
                                ),
                                Obx(() => Text(
                                      UserService.to.user.value.username,
                                      style: getFontStyle(
                                        fontSize: 14,
                                        color: AppColorPicker.f66,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          InkButton(
                            title: 'logout'.tr,
                            onTap: () {
                              Get.dialog(
                                BleHintDialog(
                                  title: 'hint'.tr,
                                  content: 'sureLogout'.tr,
                                  confirmTap: () {
                                    SpUtil.remove(Constants.userInfo);
                                    SpUtil.remove(Constants.userNamePassWord);
                                    UserService.to.password = '';
                                    UserService.to.userName = '';
                                    UserService.to.user.value =
                                        ResUserUserinfo();
                                    Get.offAllNamed(RouteNames.login);
                                  },
                                ),
                              );
                            },
                            textStyle: getFontStyle(
                              fontSize: 18,
                              color: AppColorPicker.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.hi,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
