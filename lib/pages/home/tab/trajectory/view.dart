import 'dart:convert';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/pages/home/tab/trajectory/map/map_void.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:my_tool_kit/my_toast.dart';

class TrajectoryPage extends GetView<HomeController> {
  const TrajectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        id: 'home',
        builder: (controller) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.wi, vertical: 26.hi),
            children: [
              _buildLocationInfo(
                  title: 'parkingSpot'.tr,
                  type: 'location'.tr,
                  operate: 'navigation'.tr,
                  iconPath: AssetsImages.locationPng,
                  onTap: () async {
                    final data = await DeviceApis.list();

                    ///选择的设备分享
                    if (data != null && (data.deviceList?.length ?? 0) > 1) {
                      Get.dialog(
                        Center(
                          child: Material(
                            color: AppColorPicker.transparent0,
                            child: Container(
                              height: 200.hi,
                              width: 300.wi,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColorPicker.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "selectDevice".tr,
                                    style: getFontStyle(
                                      fontSize: 16,
                                      color: AppColorPicker.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        final item = data.deviceList![index];
                                        return Material(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // 设置圆角半径
                                          ),
                                          color: AppColorPicker.white,
                                          child: ListTile(
                                            onTap: () async {
                                              final dataInfo =
                                                  await DeviceApis.info(
                                                      item.id.toString() ??
                                                          "0");
                                              Get.back();

                                              if (((dataInfo
                                                          ?.deviceInfo
                                                          ?.spotLatitude
                                                          ?.isEmpty) ??
                                                      false) ||
                                                  ((dataInfo
                                                          ?.deviceInfo
                                                          ?.spotLongitude
                                                          ?.isEmpty) ??
                                                      false)) {
                                                ToastUtil.showToast(
                                                    "device_started".tr,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                                return;
                                              }
                                              final success = await MapsLauncher
                                                  .launchCoordinates(
                                                      double.parse(dataInfo
                                                              ?.deviceInfo
                                                              ?.spotLatitude ??
                                                          "0.0"),
                                                      double.parse(dataInfo
                                                              ?.deviceInfo
                                                              ?.spotLongitude ??
                                                          "0.0"));

                                              if (!success) {
                                                LogUtil.d('❌ 启动地图失败');
                                                ToastUtil.showToast(
                                                    "please_map_device".tr,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                              }
                                            },
                                            enabled: true,
                                            minVerticalPadding: 0,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 0),
                                            title: Text(
                                              (item.name ?? '').isNotEmpty
                                                  ? item.name ?? ''
                                                  : 'device $index',
                                              style: getFontStyle(fontSize: 14),
                                            ),
                                            subtitle: Text(
                                              item.imei ?? '',
                                              style: getFontStyle(fontSize: 10),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 0,
                                        );
                                      },
                                      itemCount: data.deviceList?.length ?? 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if ((data?.deviceList?.length ?? 0) == 1) {
                      final dataInfo = await DeviceApis.info(
                          data?.deviceList?[0].id.toString() ?? "0");
                      if (((dataInfo?.deviceInfo?.spotLatitude?.isEmpty) ??
                              false) ||
                          ((dataInfo?.deviceInfo?.spotLongitude?.isEmpty) ??
                              false)) {
                        ToastUtil.showToast("device_started".tr,
                            gravity: ToastGravity.BOTTOM);
                        return;
                      }
                      final success = await MapsLauncher.launchCoordinates(
                          double.parse(
                              dataInfo?.deviceInfo?.spotLatitude ?? "0.0"),
                          double.parse(
                              dataInfo?.deviceInfo?.spotLongitude ?? "0.0"));

                      if (!success) {
                        LogUtil.d('❌ 启动地图失败');
                        ToastUtil.showToast("please_map_device".tr,
                            gravity: ToastGravity.BOTTOM);
                      }
                    } else {
                      ToastUtil.showToast("noDevice".tr,
                          gravity: ToastGravity.BOTTOM);
                    }
                    // Position position = await Geolocator.getCurrentPosition(
                    //     locationSettings: AndroidSettings(
                    //   accuracy: LocationAccuracy.best,
                    //   distanceFilter: 0,
                    // ));
                    // double gcjLat = position.latitude;
                    // double gcjLon = position.longitude;

                    // MapsLauncher.launchQuery(
                    //     '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');
                  }),
              SizedBox(
                height: 20.hi,
              ),
              _buildLocationInfo(
                title: 'travelTrajectory'.tr,
                type: 'route'.tr,
                operate: 'check'.tr,
                iconPath: AssetsImages.routePng,
                onTap: () {
                  Get.toNamed(RouteNames.travelTrajectory);
                },
              )
            ],
          );
        });
  }

  InkButton _buildLocationInfo({
    required String title,
    required String type,
    required String operate,
    required String iconPath,
    ClickCall? onTap,
  }) {
    return InkButton(
      onTap: onTap,
      padding: EdgeInsets.only(left: 22.wi, right: 8.wi),
      decoration: BoxDecoration(
          color: AppColorPicker.white,
          borderRadius: BorderRadius.circular(8.ri)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.hi,
                  ),
                  Text(
                    type,
                    style:
                        getFontStyle(fontSize: 14, color: AppColorPicker.f66),
                  ),
                ],
              ),
              SizedBox(
                height: 33.hi,
              ),
              Row(
                children: [
                  ImageWidget(
                    imageUrl: AssetsImages.goPng,
                    width: 20.wi,
                  ),
                  SizedBox(
                    width: 4.wi,
                  ),
                  Text(
                    operate,
                    style: getFontStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          ImageWidget(
            imageUrl: iconPath,
            fit: BoxFit.cover,
            width: 124.wi,
          )
        ],
      ),
    );
  }
}
