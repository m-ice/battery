import 'dart:ui';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/api/map.dart';
import 'package:battery/common/models/api/res_trajectoryLists_entity.dart';
import 'package:flutter/rendering.dart';

enum TrajectoryEnum { illuminateRegion, historyTrack }

class TrajectoryController extends GetxController {
  TrajectoryController();
  static TrajectoryController get to => Get.find<TrajectoryController>();
  var showTrajectory = TrajectoryEnum.illuminateRegion.obs;
  GlobalKey previewContainer = GlobalKey();
  switchIlluminateRegionOrHistory(TrajectoryEnum trajectoryEnum) {
    showTrajectory.value = trajectoryEnum;
    switch (trajectoryEnum) {
      case TrajectoryEnum.illuminateRegion:
        break;
      case TrajectoryEnum.historyTrack:
        break;
    }
    update(["trajectory"]);
  }

  Future<Uint8List?> captureWidgetToImage() async {
    try {
      RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("截图失败: $e");
      return null;
    }
  }

  _initData() {
    update(["trajectory"]);
  }

  void onTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  int page = 0;

  ///头部信息
  Rx<ResTrajectoryListsInfo> resTrajectoryListsInfo =
      ResTrajectoryListsInfo().obs;

  ///轨迹列表
  RxList<ResTrajectoryListsList> resTrajectoryListsList =
      <ResTrajectoryListsList>[].obs;

  ///请求历史轨迹
  bool isLoading = false;

  Future<void> getDeviceData() async {
    if (isLoading) return;
    isLoading = true;
    page++;
    final data = await DeviceApis.trajectoryList(page: '$page');
    if (data?.list?.isEmpty ?? true) {
      page--;
      isLoading = false;
      return;
    }
    resTrajectoryListsInfo.value = data?.info ?? ResTrajectoryListsInfo();
    final startIndex = resTrajectoryListsList.length;
    resTrajectoryListsList.addAll(data?.list ?? []);
    for (var i = 0; i < (data?.list?.length ?? 0); i++) {
      final element = data?.list?[i];

      if (element?.endLocation?.address == 'đang tải') {
        final dataMap = await getProvinceAndAddressFromCoordinates(
            double.parse(element?.endLocation?.latitude ?? "0"),
            double.parse(element?.endLocation?.longitude ?? "0"));
        resTrajectoryListsList[i + startIndex].endLocation?.address =
            dataMap?['address'];
        await DeviceApis.updateTrajectoryEndAddress(
            address: dataMap?['address'] ?? 'đang tải',
            groupId: (element?.groupId.toString() ?? '0'));
      }
    }

    isLoading = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
