import 'dart:ui';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/models/api/res_trajectoryInfo_entity.dart';
import 'package:battery/pages/home/tab/trajectory/map/map.dart';
import 'package:flutter/rendering.dart';

class TravelTrajectoryDetailsPage extends StatefulWidget {
  const TravelTrajectoryDetailsPage({super.key});

  @override
  State<TravelTrajectoryDetailsPage> createState() =>
      _TravelTrajectoryDetailsPageState();
}

class _TravelTrajectoryDetailsPageState
    extends State<TravelTrajectoryDetailsPage> {
  GlobalKey previewContainer = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.disRemove();
    getData();
  }

  ResTrajectoryInfoEntity? item;

  ///获取地图数据
  void getData() async {
    if (Get.arguments != null) {
      if (Get.arguments['groupId'] != null) {
        LogUtil.d(Get.arguments['groupId']);
        final groupId = Get.arguments['groupId'];
        final datas = await DeviceApis.trajectoryInfo(groupId: groupId);
        setState(() {
          item = datas;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPicker.bg212d45,
      appBar: _buildAppBar(context),
      body: RepaintBoundary(
        key: previewContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonInfo(),
            Expanded(child: _buildIlluminateRegion(context)),
            _buildInfoCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIlluminateRegion(BuildContext context) {
    // return ImageWidget(
    //   width: MediaQuery.of(context).size.width,
    //   imageUrl:
    //       'https://img2.baidu.com/it/u=3647310846,1064416777&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889',
    // );
    return ShowMapPage(
      type: false,
      groupId: Get.arguments['groupId'] ?? '',
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Hero(
      tag: Get.arguments != null ? Get.arguments['groupId'] : "",
      child: Material(
        color: AppColorPicker.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 178.hi,
          decoration: BoxDecoration(
            color: AppColorPicker.bg364363,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(6.ri),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCardHead(),
                _buildParameterStatus(),
                _buildRecordInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDateStringWithWeekday(String datetimeStr) {
    try {
      // 将字符串解析为 DateTime
      final date = DateTime.parse(datetimeStr);

      // 格式化日期
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      // 获取星期索引（让周日是0）
      final weekdayIndex = date.weekday % 7;

      // 使用 GetX 的国际化获取对应字符串
      final weekdayStr = 'weekday_$weekdayIndex'.tr;

      return '$dateStr $weekdayStr';
    } catch (e) {
      return datetimeStr; // 如果解析失败就原样返回
    }
  }

  Padding _buildInfoCardHead() {
    return Padding(
      padding: EdgeInsets.only(
        top: 6.hi,
        bottom: 6.hi,
        right: 9.wi,
        left: 14.wi,
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: formatDateStringWithWeekday(
              '${item?.info?.startLocation?.createtime}'),
          style: getFontStyle(
            color: AppColorPicker.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 记录
  Widget _buildRecordInfo() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 13.hi,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 14.wi,
              right: 26.wi,
            ),
            child: Column(
              children: List.generate(
                2,
                (index) => TimelineTile(
                  alignment: TimelineAlign.start, // 手动对齐
                  lineXY: 0.3, // 线条相对于内容的位置
                  isFirst: index == 0,
                  isLast: index == 1,
                  indicatorStyle: IndicatorStyle(
                    width: 8.wi,
                    height: 8.wi,
                    indicator: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 0
                            ? AppColorPicker.bg3dd12a
                            : AppColorPicker.bge83e41,
                      ),
                    ),
                  ),
                  endChild: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.hi,
                      horizontal: 4.wi,
                    ),
                    child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text:
                                '${index == 0 ? item?.info?.startLocation?.time : item?.info?.endLocation?.time} ',
                            style: getFontStyle(
                              fontSize: 16,
                              color: AppColorPicker.white,
                            ),
                            children: [
                              TextSpan(
                                text: [
                                  '${item?.info?.startLocation?.address}',
                                  '${item?.info?.endLocation?.address}'
                                ][index],
                                style: getFontStyle(
                                  fontSize: 16,
                                  color: AppColorPicker.white,
                                ),
                              ),
                            ])),
                  ),

                  beforeLineStyle: index == 1
                      ? LineStyle(
                          thickness: 2.0.wi,
                          color: AppColorPicker.bg00bdff,
                        )
                      : LineStyle(
                          thickness: 2.0.wi,
                          color: Colors.transparent, // 使上方线条不可见
                        ),
                  afterLineStyle: index == 1
                      ? LineStyle(
                          thickness: 2.0.wi,
                          color: Colors.transparent, // 使下方线条不可见
                        )
                      : LineStyle(
                          thickness: 2.0.wi,
                          color: AppColorPicker.bg00bdff,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildParameterStatus() {
    return Padding(
      padding: EdgeInsets.only(
        top: 13.hi,
        bottom: 15.hi,
      ),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                imageUrl: [
                  AssetsImages.totalCyclingDistancePng,
                  AssetsImages.totalRidingTimePng,
                  AssetsImages.accumulatedRidingDaysPng,
                ][index],
                width: 20.wi,
              ),
              SizedBox(
                width: 3.wi,
              ),
              Text(
                [
                  '${item?.info?.distance} ${'km'.tr}',
                  '${item?.info?.duration}',
                  '${item?.info?.avgSpeed}km/h'
                ][index],
                style: getFontStyle(
                  fontSize: 16,
                  color: AppColorPicker.white,
                ),
              )
            ],
          ));
        }),
      ),
    );
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

  AppBar _buildAppBar(BuildContext context) {
    return context.getAppBar(
      backgroundColor: const Color(0xff212D44),
      backIconColor: AppColorPicker.white,
      title: 'travelTrajectory'.tr,
      actions: [
        IconButton(
          onPressed: () async {
            final data = await captureWidgetToImage();
            Get.dialog(BikingAuthorizationPage(
              locationData: data,
              showQrcode: false,
              info: false,
              showSaveImage: false,
              zaloOnTap: () {},
            ));
          },
          iconSize: 30.wi,
          icon: ImageWidget(
            imageUrl: AssetsImages.shareLocationPng,
            width: 30.wi,
          ),
        ),
      ],
      titleTextStyle: getFontStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColorPicker.white,
      ),
    );
  }

  Widget _buildPersonInfo() {
    return Container(
      color: const Color(0xff212D44),
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.hi,
          bottom: 25.hi,
          left: 14.wi,
          right: 14.wi,
        ),
        child: HomeTopInfo(
          showMileage: false,
          versionTextStyle: getFontStyle(
            fontSize: 14,
            color: AppColorPicker.white,
          ),
        ),
      ),
    );
  }
}
