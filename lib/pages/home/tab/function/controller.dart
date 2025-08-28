import 'dart:convert';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/enum/bms.dart';
import 'package:battery/common/extension/blue_data.dart';
import 'package:battery/common/services/blue.dart';
import 'package:battery/common/utils/zalo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tool_kit/my_tool_kit.dart';

class FunctionController extends GetxController {
  FunctionController();

  var nameEditingController = TextEditingController().obs;
  var phoneNumberEditingController = TextEditingController().obs;
  _initData() {
    update(["function"]);
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
    initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  RxList<FunctionModelUI> dataList = <FunctionModelUI>[].obs;

  initData() {
    final data = [];
    data.add(FunctionEnum.values[3]);
    data.add(FunctionEnum.values[5]);
    data.add(FunctionEnum.values[0]);
    data.add(FunctionEnum.values[4]);
    dataList.value =
        List.generate(data.length, (index) => createModeUI(data[index]));
    // dataList.value = List.generate(FunctionEnum.values.length,
    //     (index) => createModeUI(FunctionEnum.values[index]));
    update(['function']);
  }

  switchStatus(int indexWhere, bool v) {
    if (indexWhere != -1) {
      dataList[indexWhere].switchValue = !v;
      update(['function']);
    }
  }

  turnSwitch({required FunctionModelUI modeUI}) async {
    int indexWhere =
        dataList.indexWhere((e) => e.functionEnum == modeUI.functionEnum);

    switchStatus(indexWhere, modeUI.switchValue);
    switch (modeUI.functionEnum) {
      case FunctionEnum.oneKey:
        oneKey(indexWhere, modeUI);

        break;
      case FunctionEnum.fallAndCallForHelp:
        if (modeUI.switchValue) {
          Get.dialog(
            BleHintDialog(
              title: 'inputCountHint'.tr,
              titleTextStyle: getFontStyle(
                fontSize: 18,
                color: AppColorPicker.f66,
              ),
              hintText: '6',
              unit: 'times'.tr,
              showTextField: true,
              confirmTap: () {
                Get.back(result: true);
              },
              confirmTitle: 'confirm'.tr,
              cancelTitle: 'cancel'.tr,
            ),
          ).then((v) {
            if (v != null && v) {
              //... 进行开启操作
            } else {
              switchStatus(indexWhere, modeUI.switchValue);
            }
            update(['function']);
          });
        }
        break;
      case FunctionEnum.shakeToUnlock:
        Get.toNamed(
          RouteNames.emergencyContactPerson,
        );
        break;
      case FunctionEnum.bikingAuthorization:

        // return;
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
                                borderRadius:
                                    BorderRadius.circular(20), // 设置圆角半径
                              ),
                              color: AppColorPicker.white,
                              child: ListTile(
                                onTap: () {
                                  Get.back();
                                  Get.dialog(BikingAuthorizationPage(
                                    qrCodeData: jsonEncode(item.toJson()),
                                    zaloOnTap: () {},
                                  ));
                                },
                                enabled: true,
                                minVerticalPadding: 0,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
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
          Get.dialog(BikingAuthorizationPage(
            qrCodeData: jsonEncode(data?.deviceList?[0].toJson()),
            zaloOnTap: () {},
          ));
        } else {
          ToastUtil.showToast("noDevice".tr, gravity: ToastGravity.BOTTOM);
        }

        break;
      case FunctionEnum.automaticUnlocking:
        if (modeUI.switchValue) {
          noFunctionHint(dialogcCall: (v) {
            switchStatus(indexWhere, modeUI.switchValue);
          });
        }

        break;
      case FunctionEnum.afterSalesService:
        Get.toNamed(RouteNames.aboutUs, arguments: {
          'type': '1',
        });
        break;
    }
  }

  /// 一键启动
  oneKey(int indexWhere, FunctionModelUI modeUI) {
    if (modeUI.switchValue) {
      Get.dialog(
        BleHintDialog(
          title: 'hint'.tr,
          content: 'turnHint'.tr,
          confirmTap: () {
            Get.back(result: true);
          },
          confirmTitle: 'confirm'.tr,
          cancelTitle: 'cancel'.tr,
        ),
      ).then((v) {
        if (v != null && v) {
          //... 进行开启操作
          BluetoothDataService.to.sendDataQueued(BMS.d82.setup(1));
        } else {
          BluetoothDataService.to.sendDataQueued(BMS.d82.setup(0));
          switchStatus(indexWhere, modeUI.switchValue);
        }
        update(['function']);
      });
    } else {
      Get.dialog(
        BleHintDialog(
          title: 'hint'.tr,
          content: 'afterCloseHint'.tr,
          showCancelBtn: false,
          confirmTap: () {
            Get.back(result: true);
          },
          confirmTitle: 'send'.tr,
        ),
      ).then((v) {
        if (v != null && v) {
          //... 进行开启操作
        } else {
          switchStatus(indexWhere, modeUI.switchValue);
        }
        update(['function']);
      });
    }
  }

  /// 无此功能的提示
  noFunctionHint({SwitchOnChangedCall? dialogcCall}) {
    Get.dialog(BleHintDialog(
      content: 'open_automatic_unlock'.tr,
      confirmTap: () {
        Get.back(result: true);
      },
    )).then((v) {
      if (v) {
        BluetoothDataService.to.sendDataQueued(BMS.d83.setup(1));
      } else {
        BluetoothDataService.to.sendDataQueued(BMS.d83.setup(0));
        dialogcCall?.call(v);
      }
    });
  }

  FunctionModelUI createModeUI(FunctionEnum functionEnum) {
    FunctionModelUI modeUI =
        FunctionModelUI(iconPath: '', title: '', functionEnum: functionEnum);
    switch (functionEnum) {
      case FunctionEnum.oneKey:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.oneKeyPng,
          title: 'oneKey',
          functionEnum: functionEnum,
        );
        break;
      case FunctionEnum.fallAndCallForHelp:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.fallAndCallForHelpPng,
          title: 'fallAndCallForHelp',
          functionEnum: functionEnum,
        );
        break;
      case FunctionEnum.shakeToUnlock:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.shakeToUnlockPng,
          title: 'shakeToUnlock',
          switchValue: false,
          functionEnum: functionEnum,
        );
        break;
      case FunctionEnum.bikingAuthorization:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.bikingAuthorizationPng,
          title: 'bikingAuthorization',
          showSwitch: false,
          functionEnum: functionEnum,
        );
        break;
      case FunctionEnum.automaticUnlocking:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.automaticUnlockingPng,
          title: 'automaticUnlocking',
          showSingleArrow: false,
          functionEnum: functionEnum,
        );
        break;
      case FunctionEnum.afterSalesService:
        modeUI = FunctionModelUI(
          iconPath: AssetsImages.afterSalesServicePng,
          title: 'afterSalesService',
          showSwitch: false,
          functionEnum: functionEnum,
        );
        break;
    }

    return modeUI;
  }
}
