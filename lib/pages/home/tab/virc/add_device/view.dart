import 'package:battery/app_library.dart';
import 'package:battery/common/services/blue.dart';
import 'package:my_tool_kit/my_tool_kit.dart' as my;

class AddDevicePage extends GetView<VircController> {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VircController>(
        // init: VircController(),
        id: 'virc',
        // tag: 'virc',
        builder: (controller) {
          return Scaffold(
            appBar: context.getAppBar(
                title: 'addDevice'.tr,
                scanTap: () {
                  Get.toNamed(RouteNames.scanQRCode)?.then((v) {
                    LogUtil.d("参数11  $v");
                    if (v != null && v is bool) {
                      if (v) {
                        Get.back(result: true);
                      }
                    }
                  });
                }),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.hi,
                horizontal: 14.wi,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.hi),
                    child: Text(
                      'deviceList'.tr,
                      style: getFontStyle(
                        fontSize: 16,
                        color: AppColorPicker.f66,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColorPicker.transparent0,
                          borderRadius: BorderRadius.circular(6.ri)),
                      child: Obx(() => my.MyRefresh(
                            onRefresh: () async {
                              controller.checkPermissions();
                            },
                            enableLoad: false,
                            onLoad: () async {},
                            child: ListView.builder(
                              itemCount:
                                  BluetoothDataService.to.scanResults.length,
                              itemBuilder: (context, index) {
                                return InkButton(
                                  onTap: () {
                                    if (BluetoothDataService
                                            .to.currentIndex.value !=
                                        index) {
                                      BluetoothDataService.to
                                          .connectDevice(index);
                                    } else if (BluetoothDataService
                                            .to.currentIndex.value ==
                                        index) {
                                      Get.dialog(
                                        BleHintDialog(
                                          title: 'disconnect_bluetooth'.tr,
                                          titleTextStyle: getFontStyle(
                                            fontSize: 18,
                                            color: AppColorPicker.f66,
                                          ),
                                          confirmTap: () {
                                            Get.back(result: true);
                                          },
                                          confirmTitle: 'confirm'.tr,
                                          cancelTitle: 'cancel'.tr,
                                        ),
                                      ).then((v) {
                                        if (v != null && v) {
                                          BluetoothDataService.to
                                              .disconnectDevice();
                                          BluetoothDataService.to
                                              .onCloseDevice();
                                        }
                                      });
                                    }
                                  },
                                  decoration: BoxDecoration(
                                      color: AppColorPicker.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: index == 0
                                            ? Radius.circular(6.ri)
                                            : Radius.zero,
                                        bottom: index == 2
                                            ? Radius.circular(6.ri)
                                            : Radius.zero,
                                      )),
                                  padding: EdgeInsets.only(
                                    left: 10.wi,
                                    right: 15.wi,
                                    top: 17.hi,
                                    bottom: 17.hi,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ImageWidget(
                                              imageUrl:
                                                  AssetsImages.batteryItemPng,
                                              width: 24.wi,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 4.wi,
                                                ),
                                                child: Text(
                                                  BluetoothDataService
                                                      .to
                                                      .scanResults[index]
                                                      .advertisementData
                                                      .advName,
                                                  style: getFontStyle(
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        return BluetoothDataService
                                                    .to.currentIndex.value ==
                                                index
                                            ? OpenDevice(
                                                type: BluetoothDataService
                                                    .to.dataDeviceType.value)
                                            : const SizedBox();
                                      }),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class OpenDevice extends StatelessWidget {
  final DataDeviceType type;
  const OpenDevice({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == DataDeviceType.isBind) {
      return Text(
        'connected'.tr,
        style: getFontStyle(
          fontSize: 12,
          color: AppColorPicker.f66,
        ),
      );
    } else if (type == DataDeviceType.none) {
      return const SizedBox();
    } else {
      return const SizedBox(
        width: 10,
        height: 10,
        child: CircularProgressIndicator(
          strokeWidth: 1,
          color: AppColorPicker.f66,
        ),
      );
    }
  }
}
