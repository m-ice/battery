import 'package:battery/app_library.dart';
import 'package:battery/common/enum/bms.dart';
import 'package:battery/common/extension/blue_data.dart';
import 'package:battery/common/models/blue_data.dart';
import 'package:battery/common/services/blue.dart';

class VircPage extends GetView<VircController> {
  const VircPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VircController>(
        init: VircController(),
        // tag: 'virc',
        builder: (controller) {
          return Obx(
            () => ListView(
              padding:
                  EdgeInsets.only(right: 14.wi, left: 14.wi, bottom: 10.hi),
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 38.hi),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageWidget(
                        imageUrl: AssetsImages.batteryPng,
                        width: 212.wi,
                        height: 212.wi,
                      ),
                      BluetoothDataService.to.dataDeviceType.value ==
                              DataDeviceType.isBind
                          ? Text(
                              'vircTips'.tr,
                              style: getFontStyle(fontSize: 14),
                            )
                          : SizedBox(
                              height: 20.hi,
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.hi, bottom: 14.hi),
                  child: InkButton(
                    onTap: () {
                      BluetoothDataService.to.gerDevice();
                      BluetoothDataService.to.initDevice();
                      Get.toNamed(RouteNames.addDevice)?.then((v) {
                        LogUtil.d("返回值 $v");
                      });
                    },
                    title: BluetoothDataService.to.dataDeviceType.value ==
                            DataDeviceType.isBind
                        ? 'batteryBound'.tr
                        : 'bindBattery'.tr,
                    textStyle: getFontStyle(
                      fontSize: 14,
                      color: BluetoothDataService.to.dataDeviceType.value ==
                              DataDeviceType.isBind
                          ? AppColorPicker.f3dd12a
                          : AppColorPicker.f99,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 17.hi),
                    decoration: BoxDecoration(
                      color: AppColorPicker.white,
                      borderRadius: BorderRadius.circular(8.ri),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !(BluetoothDataService.to.dataDeviceType.value ==
                      DataDeviceType.isBind),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildBatterySizeInfo(
                              size:
                                  BlueDatabase.bmsData86.remainingCapacity > 100
                                      ? "100"
                                      : BlueDatabase.bmsData86.remainingCapacity
                                          .toStringAsFixed(0),
                              type: 'battery'.tr,
                              iconPath: getBatterySizeIcon(
                                  BlueDatabase.bmsData86.remainingCapacity)),
                          SizedBox(
                            width: 15.wi,
                          ),
                          buildBatterySizeInfo(
                              size: BlueDatabase.bmsData86.totalVoltage
                                  .toStringAsFixed(1),
                              type: 'voltage'.tr,
                              iconPath: AssetsImages.voltageSizePng),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 14.hi),
                        decoration: BoxDecoration(
                          color: AppColorPicker.white,
                          borderRadius: BorderRadius.circular(27.ri),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildLockStatus(
                                title: 'open'.tr,
                                selected: controller.lockStatus.value,
                                iconPath: controller.lockStatus.value
                                    ? AssetsImages.closeLockPng
                                    : AssetsImages.unCloseLockPng,
                                onTap: () {
                                  controller.lockStatus.value = true;
                                  HomeController.to.isone = true;
                                  BluetoothDataService.to
                                      .sendDataQueued(BMS.d81.setup(1));
                                  HomeController.to.startListening();
                                },
                              ),
                            ),
                            Expanded(
                              child: _buildLockStatus(
                                  title: 'close'.tr,
                                  selected: !controller.lockStatus.value,
                                  iconPath: controller.lockStatus.value
                                      ? AssetsImages.unOpenLockPng
                                      : AssetsImages.openLockPng,
                                  onTap: () {
                                    controller.lockStatus.value = false;
                                    BluetoothDataService.to
                                        .sendDataQueued(BMS.d81.setup(0));
                                    HomeController.to.nonegetPosition();
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  InkButton _buildLockStatus(
      {bool selected = false,
      required String title,
      required String iconPath,
      ClickCall? onTap}) {
    return InkButton(
        onTap: onTap,
        padding: EdgeInsets.symmetric(vertical: 15.hi),
        decoration: BoxDecoration(
            color: selected ? AppColorPicker.bg00bdff : AppColorPicker.white,
            borderRadius: BorderRadius.circular(27.ri)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: iconPath,
              width: 24.wi,
              // color: selected ? AppColorPicker.white : AppColorPicker.white,
            ),
            SizedBox(
              width: 6.wi,
            ),
            Text(
              title,
              style: getFontStyle(
                fontSize: 14,
              ),
            )
          ],
        ));
  }

  InkButton buildBatterySizeInfo(
      {required String size,
      required String type,
      required String iconPath,
      ClickCall? onTap}) {
    return InkButton(
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 17.hi),
      decoration: BoxDecoration(
        color: AppColorPicker.white,
        borderRadius: BorderRadius.circular(8.ri),
      ),
      width: 166.wi,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                size,
                style: getFontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4.hi,
              ),
              Text(
                type,
                style: getFontStyle(fontSize: 14, color: AppColorPicker.f66),
              )
            ],
          ),
          ImageWidget(
            imageUrl: iconPath,
            width: 28.wi,
          )
        ],
      ),
    );
  }
}

String getBatterySizeIcon(double capacity) {
  if (capacity >= 80) {
    return AssetsImages.batterySizePng;
  } else if (capacity >= 60) {
    return AssetsImages.batterySizePng3;
  } else if (capacity >= 40) {
    return AssetsImages.batterySizePng2;
  } else if (capacity >= 20) {
    return AssetsImages.batterySizePng1;
  }
  {
    return AssetsImages.batterySizePng0;
  }
}
