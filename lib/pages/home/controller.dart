import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/api/battery/user.dart';
import 'package:battery/common/api/map.dart';
import 'package:battery/common/models/api/req_upLocation_entity.dart';
import 'package:battery/common/models/api/res_locationAreaList_entity.dart';
import 'package:battery/common/services/blue.dart';
import 'package:battery/pages/home/tab/trajectory/map/map_void.dart';
import 'package:battery/pages/home/widgets/system_update_dialog_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:my_tool_kit/my_tool_kit.dart' as my;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  HomeController();
  static HomeController get to => Get.find();
  RxInt bottomNavigationBarCurrentIndex = 0.obs;

  OverlayEntry? overlayEntry;

  RxInt languageIndex = 0.obs;

  RxString version = '1.0.0'.obs;
  RxString mileage = '2024'.obs;
  RxString avatarUrl =
      'https://img0.baidu.com/it/u=1531480230,393164074&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1733936400&t=73f15ee34e9c51bc54d833f1a9e21062'
          .obs;

  ///位置的流
  StreamSubscription<Position>? positionStreamSub;

  // ///上传的数据
  // List<Map<String, dynamic>> locationBuffer = [];

  /// 语言切换
  switchLanguage({required int index}) {
    Locale locale = AppLanguage.delegate.supportedLocales[index];
    languageIndex.value = index;
    update(['home']);
    Get.updateLocale(locale);
    SpUtil.putInt(Constants.languageKey, index);
  }

  /// 销毁自定义弹窗
  disRemove() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
      update(["home"]);
    }
  }

  setting(HomeUiEnum homeUiEnum) async {
    disRemove();
    switch (homeUiEnum) {
      case HomeUiEnum.personalInformation:
        Get.toNamed(RouteNames.personalInformation);
        break;
      case HomeUiEnum.languageSettings:
        Get.toNamed(RouteNames.languageSettings);
        break;
      case HomeUiEnum.systemUpdate:
        final data = await UserApis.firmwareUpdate();
        final datais = version.value.replaceFirst(RegExp(r'^v'), '');
        if (data?.info?.newversion != datais) {
          Get.dialog(
            SystemUpdateDialogWidget(
              version: data?.info?.newversion,
              sureUpdateTap: () async {
                Get.back(result: true);
                final Uri uri = Uri.parse(data?.info?.url ?? '');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  // throw 'Could not launch $url';
                  my.ToastUtil.showToast("err", gravity: ToastGravity.BOTTOM);
                }
              },
            ),
          );
        } else {
          my.ToastUtil.showToast("alreadyLatest".tr,
              gravity: ToastGravity.BOTTOM);
        }

        break;
      case HomeUiEnum.aboutUs:
        Get.toNamed(
          RouteNames.aboutUs,
          arguments: {'type': '2'},
        );
        break;
    }
  }

  _initData() {
    update(["home"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    Get.put<BluetoothDataService>(BluetoothDataService());
    getAppVersionInfo();
    getlocationAreaList();
  }

  @override
  void onReady() {
    super.onReady();
    languageIndex.value = Constants.languageIndex;
    Get.find<AppGlobalController>().getLanguageLocale();

    _initData();
  }

  Future<void> getAppVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version; // 版本号
  }

  @override
  void onClose() {
    super.onClose();
    clealStream();
    BluetoothDataService.to.despose();
  }

  /// 点击个人头像
  void onTapPersonalInfo(BuildContext context) {
    if (overlayEntry != null) {
      disRemove();
      // LogUtil.d(locationBuffer.length);
    } else {
      overlayEntry = createOverlayEntry(context);
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  OverlayEntry createOverlayEntry(BuildContext context) {
    // var offset = (context.findRenderObject() as RenderBox).globalToLocal(Offset.zero);
    var offset =
        (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    return OverlayEntry(builder: (cx) {
      return Positioned(
          left: offset.dx,
          top: offset.dy + 56.hi,
          // right: 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 12.hi,
                left: 6.wi,
              ),
              constraints: BoxConstraints(
                maxWidth: 160.wi,
                minWidth: 60.wi,
              ),
              decoration: BoxDecoration(
                  color: AppColorPicker.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8.ri),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1.5.wi, 2.hi),
                      color: AppColorPicker.black.withValues(alpha: 0.04),
                      blurRadius: 10.ri,
                      spreadRadius: 0,
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    color: AppColorPicker.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'my'.tr,
                          style: getFontStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkButton(
                          onTap: () {
                            setting(HomeUiEnum.personalInformation);
                          },
                          padding: EdgeInsets.all(6.wi),
                          decoration: BoxDecoration(
                            color: AppColorPicker.transparent,
                            borderRadius: BorderRadius.circular(18.ri),
                          ),
                          child: ImageWidget(
                            imageUrl: AssetsImages.rightTopArrowPng,
                            width: 18.wi,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 36.hi,
                      maxHeight: 398.hi,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: HomeUiEnum.values.length,
                      padding: EdgeInsets.only(right: 6.wi),
                      itemBuilder: (context, index) {
                        return _buildPersonalInfoBtn(
                            homeUiEnum: HomeUiEnum.values[index]);
                      },
                      separatorBuilder: (cx, index) {
                        return SizedBox(
                          height: 12.hi,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }

  InkButton _buildPersonalInfoBtn({required HomeUiEnum homeUiEnum}) {
    return InkButton(
      onTap: () {
        setting(homeUiEnum);
      },
      width: 142.wi,
      padding: EdgeInsets.symmetric(
        horizontal: 10.wi,
        vertical: 8.hi,
      ),
      decoration: BoxDecoration(
        color: AppColorPicker.bgf3f5f7,
        borderRadius: BorderRadius.circular(17.ri),
      ),
      title: _getInfoBtnTitle(homeUiEnum),
      textStyle: getFontStyle(
        fontSize: 12,
      ),
    );
  }

  String _getInfoBtnTitle(HomeUiEnum homeUiEnum) {
    switch (homeUiEnum) {
      case HomeUiEnum.personalInformation:
        return 'personalInformation'.tr;
      case HomeUiEnum.languageSettings:
        return 'languageSettings'.tr;
      case HomeUiEnum.systemUpdate:
        return 'systemUpdate'.tr;
      case HomeUiEnum.aboutUs:
        return 'aboutus'.tr;
    }
  }

  ///监听定位并且上传数据
  Stream<Position>? positionStream;

  ///开启监听流
  void startListening() {
    positionStreamSub = null;
    positionStreamSub?.cancel();
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 3, // 每移动10米更新一次
      ),
    );
    positionStreamSub = positionStream?.listen((Position position) {
      getPosition(position);
    });
  }

  Position? lastposition;

  ///位置方法
  void getPosition(Position position) {
    lastposition = position;

    if (BluetoothDataService.to.dataDeviceType.value == DataDeviceType.isBind &&
        VircController.to.lockStatus.value) {
      uploadLocationToServer(position);
      onLocationUpdate(position);
    }
  }

  ///用于断开蓝牙上传
  void nonegetPosition() {
    if (lastposition != null) {
      uploadLocationToServer(lastposition);
      onLocationUpdate(lastposition);
    }
  }

  ///关闭流并且添加
  void clealStream() {
    positionStreamSub?.cancel();
    nonegetPosition();
  }

  DateTime? _lastUploadTime; // 用于保存上次上传的时间\
  ///是否第一次
  bool isone = false;
  List<String> locationAreaList = [];

  ///获取已点亮点城市
  void getlocationAreaList() async {
    final data = await DeviceApis.locationAreaList();
    for (ResLocationAreaListList element in data?.list ?? []) {
      locationAreaList.add(element.areaName ?? '');
    }
  }

  ///添加数据
  void onLocationUpdate(Position? position) async {
    LogUtil.d('我正在上传数据${position?.latitude}, ${position?.longitude}');
    final now = DateTime.now();
    // 默认时间间隔为 0 秒
    int timeDiffSeconds = 0;

    if (_lastUploadTime != null) {
      timeDiffSeconds = now.difference(_lastUploadTime!).inSeconds;
    }
    _lastUploadTime = now;
    final latitude = position?.latitude;
    final longitude = position?.longitude;
    String? data = 'đang tải';
    if (isone) {
      final dataMap = await getProvinceAndAddressFromCoordinates(
          latitude ?? 0, longitude ?? 0);

      data = dataMap?['address'] ?? '';
      bool contains1231 = locationAreaList.any(
        (e) => (e).contains('${dataMap?['province']}'),
      );

      if (!contains1231) {
        DeviceApis.upLocationArea(
            deviceId: BluetoothDataService.to.resDeviceListDeviceList?.id
                    .toString() ??
                '',
            areaName: dataMap?['province'] ?? '');
        locationAreaList.add(dataMap?['province'] ?? '');
      }
    }
    final wgs84 = CoordinateConverter.wgs84ToGcj02(
        position?.latitude ?? 0, position?.longitude ?? 0);
    final reqData = ReqUpLocationEntity()
      ..latitude = wgs84['lat'].toString()
      ..longitude = wgs84['lon'].toString()
      ..address = isone ? data : 'đang tải'
      ..duration = timeDiffSeconds.toString()

      ///1为开始
      ..isStart = isone ? "1" : '0'
      ..distance = '0.003'
      ..deviceId =
          BluetoothDataService.to.resDeviceListDeviceList?.id.toString();
    DeviceApis.upLocation(reqData: reqData);
    isone = false;
  }

  Future<void> uploadLocationToServer(Position? position) async {
    // if (position == null || !isone) return;
  }
}
