import 'package:battery/app_library.dart';
import 'package:battery/common/models/api/res_trajectoryLists_entity.dart';
import 'package:battery/common/services/user.dart';
import 'package:battery/pages/home/tab/trajectory/map/map.dart';
import 'package:my_tool_kit/my_tool_kit.dart' as my;

class TravelTrajectoryPage extends GetView<TrajectoryController> {
  const TravelTrajectoryPage({super.key});

  shareLocation() async {
    final data = await controller.captureWidgetToImage();
    Get.dialog(BikingAuthorizationPage(
      locationData: data,
      showQrcode: false,
      showSaveImage: false,
      zaloOnTap: () {},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrajectoryController>(
        init: TrajectoryController(),
        id: 'trajectory',
        builder: (controller) {
          return Listener(
            onPointerDown: (v) {
              // Get.find<HomeController>(tag: 'home').disRemove();
            },
            child: Scaffold(
              backgroundColor: AppColorPicker.bg212d45,
              body: Stack(
                children: [
                  Offstage(
                    offstage: controller.showTrajectory.value !=
                        TrajectoryEnum.illuminateRegion,
                    child: _buildIlluminateRegion(context),
                  ),
                  Column(
                    children: [
                      _buildHeadInfo(context),
                      if (controller.showTrajectory.value ==
                          TrajectoryEnum.historyTrack)
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: _buildHistoryTrack(),
                              ),
                              _buildDownCard(context),
                            ],
                          ),
                        )
                    ],
                  ),
                  if (controller.showTrajectory.value !=
                      TrajectoryEnum.historyTrack)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _buildDownCard(context),
                    ),
                ],
              ),
            ),
          );
        });
  }

  Container _buildDownCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.ri)),
        color: AppColorPicker.bg00bdff,
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColorPicker.bg405c8e,
              AppColorPicker.bg364363,
            ]),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.hi, bottom: 14.hi),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDownButton(
                  trajectoryEnum: TrajectoryEnum.illuminateRegion,
                  title: 'illuminateRegion'.tr,
                ),
                SizedBox(
                  width: 32.wi,
                ),
                _buildDownButton(
                  trajectoryEnum: TrajectoryEnum.historyTrack,
                  title: 'historyTrack'.tr,
                ),
              ],
            ),
          ),
          Container(
            width: 347.wi,
            margin: EdgeInsets.only(
              bottom: 43.hi + MediaQuery.of(context).padding.bottom,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.wi,
              vertical: 13.hi,
            ),
            decoration: BoxDecoration(
              color: AppColorPicker.bg00bdff,
              borderRadius: BorderRadius.circular(6.ri),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColorPicker.bg2c3852,
                    AppColorPicker.bg2f4262,
                  ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'mileage1'.tr,
                  style: getFontStyle(
                    fontSize: 16,
                    color: AppColorPicker.white,
                  ),
                ),
                Obx(() => RichText(
                        text: TextSpan(
                            text: '${UserService.to.user.value.totalDistance}',
                            style: getFontStyle(
                              color: AppColorPicker.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                          TextSpan(
                            text: 'km'.tr,
                            style: getFontStyle(
                              color: AppColorPicker.white,
                              fontSize: 12,
                            ),
                          )
                        ])))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildHeadInfo(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(context),
        _buildPersonInfo(),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return context.getAppBar(
      backgroundColor: AppColorPicker.transparent0,
      backIconColor: AppColorPicker.white,
      title: 'travelTrajectory'.tr,
      actions: [
        if (controller.showTrajectory.value == TrajectoryEnum.illuminateRegion)
          IconButton(
            onPressed: () {
              shareLocation();
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
    return Padding(
      padding: EdgeInsets.only(
        top: 10.hi,
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
    );
  }

  Widget _buildIlluminateRegion(BuildContext context) {
    // return Transform.scale(
    //   scale: 2.0,
    //   child: ImageWidget(
    //     width: MediaQuery.of(context).size.width,
    //     imageUrl:
    //         'https://img2.baidu.com/it/u=3647310846,1064416777&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889',
    //   ),
    // );

    return RepaintBoundary(
      key: controller.previewContainer,
      child: const ShowMapPage(
        type: true,
      ),
    );
  }

  Widget _buildHistoryTrack() {
    return Container(
      margin: EdgeInsets.only(
        top: 14.hi,
      ),
      child: Column(
        children: [
          Container(
            width: 347.wi,
            height: 74.hi,
            padding: EdgeInsets.only(
              top: 5.hi,
              bottom: 7.hi,
              left: 21.wi,
              right: 21.wi,
            ),
            decoration: BoxDecoration(
              color: AppColorPicker.bg364363,
              borderRadius: BorderRadius.circular(6.ri),
            ),
            child: Row(
              children: List.generate(
                  3,
                  (index) => Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: index == 1 ? 80.wi : null,
                            child: Text(
                              [
                                'totalCyclingDistance'.tr,
                                'totalRidingTime'.tr,
                                'accumulatedRidingDays'.tr
                              ][index],
                              textAlign: TextAlign.center,
                              style: getFontStyle(
                                color: AppColorPicker.f9dacbf,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Obx(() => RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: [
                                      '${controller.resTrajectoryListsInfo.value.distance}',
                                      '${controller.resTrajectoryListsInfo.value.duration}',
                                      '${controller.resTrajectoryListsInfo.value.day}'
                                    ][index],
                                    style: getFontStyle(
                                      color: AppColorPicker.white,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: [
                                          'km'.tr,
                                          'h'.tr,
                                          'day'.tr
                                        ][index],
                                        style: getFontStyle(
                                          color: AppColorPicker.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ]),
                              )),
                        ],
                      ))),
            ),
          ),
          Expanded(
            child: my.MyRefresh(
              onRefresh: () async {
                controller.page = 0;
                controller.resTrajectoryListsList.clear();
                controller.getDeviceData();
              },
              onLoad: controller.resTrajectoryListsList.length % 10 != 0
                  ? null
                  : () async {
                      controller.getDeviceData();
                    },
              child: Obx(() => ListView.separated(
                    itemCount: controller.resTrajectoryListsList.length,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.hi,
                      horizontal: 14.wi,
                    ),
                    itemBuilder: (cx, index) {
                      final item = controller.resTrajectoryListsList[index];
                      return _buildInfoCard(item);
                    },
                    separatorBuilder: (cx, index) {
                      return SizedBox(
                        height: 14.hi,
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ResTrajectoryListsList item) {
    return Hero(
      tag: "${item.groupId}",
      child: InkButton(
        onTap: () {
          HomeController.to.disRemove();
          Get.toNamed(RouteNames.travelTrajectoryDetails, arguments: {
            "groupId": "${item.groupId}",
          });
        },
        decoration: BoxDecoration(
          color: AppColorPicker.bg3b4f82,
          borderRadius: BorderRadius.circular(6.ri),
        ),
        child: Column(
          children: [_buildInfoCardHead(item), _buildRecordInfo(item)],
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

  Padding _buildInfoCardHead(ResTrajectoryListsList item) {
    return Padding(
      padding: EdgeInsets.only(
        top: 6.hi,
        bottom: 6.hi,
        right: 9.wi,
        left: 14.wi,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ImageWidget(
                  imageUrl: AssetsImages.trackPng,
                  width: 18.wi,
                ),
                SizedBox(
                  width: 6.wi,
                ),
                RichText(
                  text: TextSpan(
                    text: formatDateStringWithWeekday(
                        item.endLocation?.createtime ?? ''),
                    style: getFontStyle(
                      color: AppColorPicker.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ImageWidget(
            imageUrl: AssetsImages.singleArrowPng,
            color: AppColorPicker.white,
            width: 14.wi,
          ),
        ],
      ),
    );
  }

  Container _buildRecordInfo(ResTrajectoryListsList item) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 13.hi,
        top: 9.hi,
      ),
      decoration: BoxDecoration(
        color: AppColorPicker.bg364363,
        borderRadius: BorderRadius.circular(6.ri),
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
                            text: index == 0
                                ? '${item.startLocation?.time} '
                                : '${item.endLocation?.time} ',
                            style: getFontStyle(
                              fontSize: 16,
                              color: AppColorPicker.white,
                            ),
                            children: [
                              TextSpan(
                                text: [
                                  '${item.startLocation?.address}',
                                  '${item.endLocation?.address}'
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
          _buildParameterStatus(item)
        ],
      ),
    );
  }

  Padding _buildParameterStatus(ResTrajectoryListsList item) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.hi,
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
                  '${item.distance}${'km'.tr}',
                  '${item.duration}',
                  '${item.avgSpeed}km/h'
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

  Widget _buildDownButton({
    required TrajectoryEnum trajectoryEnum,
    required String title,
  }) {
    return Obx(
      () => InkButton(
        width: 144.wi,
        height: 36.hi,
        onTap: () {
          controller.switchIlluminateRegionOrHistory(trajectoryEnum);
        },
        decoration: controller.showTrajectory.value == trajectoryEnum
            ? BoxDecoration(
                color: AppColorPicker.bg00bdff,
                borderRadius: BorderRadius.circular(18.ri),
              )
            : BoxDecoration(
                color: AppColorPicker.bg2e3955,
                borderRadius: BorderRadius.circular(18.ri),
              ),
        title: title,
        textStyle: getFontStyle(
          fontSize: 16,
          color: AppColorPicker.white,
        ),
      ),
    );
  }
}
