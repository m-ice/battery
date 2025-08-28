import 'dart:convert';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/user.dart';
import 'package:battery/common/services/user.dart';

class HomeTopInfo extends GetView<HomeController> {
  final bool showMileage;
  final bool allowClick;
  final TextStyle? versionTextStyle;
  const HomeTopInfo({
    super.key,
    this.showMileage = true,
    this.allowClick = true,
    this.versionTextStyle,
  });
  bool isValidBase64(String base64Str) {
    if (base64Str.isEmpty) return false;

    try {
      // 解码后尝试转成图片字节
      final decodedBytes = base64Decode(base64Str);
      return decodedBytes.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "home",
        builder: (controller) {
          return Material(
            color: AppColorPicker.transparent,
            child: Row(
              mainAxisAlignment: showMileage
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Builder(builder: (cx) {
                      return Stack(
                        children: [
                          SkeletonWidget(
                            width: 50.wi,
                            height: 50.wi,
                            clipBehavior: Clip.hardEdge,
                            cornerRadius: 25.ri,
                            child: Obx(() {
                              final avatar = UserService.to.user.value.avatar;
                              final isBase64 = avatar.startsWith('data:image');
                              final isValid = avatar.isNotEmpty;

                              if (!isValid) {
                                return const SizedBox.shrink(); // 不显示或返回默认图
                              }

                              if (isBase64) {
                                try {
                                  final base64Str = avatar.split(',').last;
                                  final bytes = base64Decode(base64Str);
                                  return Image.memory(
                                    bytes,
                                    width: 50.wi,
                                    height: 50.wi,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const SizedBox.shrink(),
                                  );
                                } catch (_) {
                                  return const SizedBox.shrink(); // base64 解码失败
                                }
                              } else {
                                final fullUrl = "${Constants.apiUrl}/$avatar";
                                return ImageWidget(
                                  useExtendedImage: true,
                                  imageUrl: fullUrl,
                                  width: 50.wi,
                                  height: 50.wi,
                                );
                              }
                            }),
                          ),
                          Positioned.fill(
                            child: InkButton(
                              backGroundColor: AppColorPicker.transparent,
                              splashColor:
                                  AppColorPicker.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(25.ri),
                              onTap: allowClick
                                  ? () {
                                      controller.onTapPersonalInfo(cx);
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      width: 8.wi,
                    ),
                    Obx(() => Text(
                          "${'version'.tr}${controller.version.value}",
                          style: versionTextStyle ??
                              getFontStyle(
                                fontSize: 14,
                              ),
                        )),
                  ],
                ),
                if (showMileage)
                  Obx(() => Text(
                        "${'mileage'.tr}${UserService.to.user.value.totalDistance}${'km'.tr}",
                        style: getFontStyle(
                            fontSize: 14, color: AppColorPicker.f66),
                      )),
              ],
            ),
          );
        });
  }
}
