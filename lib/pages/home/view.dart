import 'package:battery/app_library.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (controller) {
        return Listener(
          onPointerDown: (v) {
            controller.disRemove();
          },
          child: Obx(
            () => HomeBackgroundWidget(
              child: Scaffold(
                backgroundColor: AppColorPicker.transparent,
                appBar: context.getAppBar(
                  backgroundColor: AppColorPicker.transparent,
                  showBack: false,
                  title: [
                    'virc',
                    'trajectory',
                    'function'
                  ][controller.bottomNavigationBarCurrentIndex.value]
                      .tr,
                  scanTap: controller.bottomNavigationBarCurrentIndex.value == 0
                      ? () {
                          Get.toNamed(RouteNames.scanQRCode)!.then((v) {
                            LogUtil.d("返回值 $v");
                            Get.find<VircController>(tag: 'virc')
                                .bindingStatus
                                .toggle();
                          });
                        }
                      : null,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 0,
                  currentIndex:
                      controller.bottomNavigationBarCurrentIndex.value,
                  backgroundColor: AppColorPicker.white,
                  type: BottomNavigationBarType.fixed,
                  fixedColor: AppColorPicker.f00bdff,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: getFontStyle(
                    fontSize: 12,
                    color: AppColorPicker.f00bdff,
                  ),
                  unselectedLabelStyle: getFontStyle(
                    fontSize: 12,
                    color: AppColorPicker.fd2d4d8,
                  ),
                  onTap: (index) {
                    controller.bottomNavigationBarCurrentIndex.value = index;
                  },
                  mouseCursor: MouseCursor.defer,
                  items: List.generate(
                      3, (index) => buildBottomNavigationItem(index)),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 14.wi, right: 14.wi, top: 10.hi),
                      child: const HomeTopInfo(),
                    ),
                    Expanded(
                      child: IndexedStack(
                          index:
                              controller.bottomNavigationBarCurrentIndex.value,
                          children: const [
                            VircPage(),
                            TrajectoryPage(),
                            FunctionPage(),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  buildBottomNavigationItem(int index) {
    String label = '';
    String icon = '';
    String activeIcon = '';

    switch (index) {
      case 0:
        label = 'virc'.tr;
        icon = AssetsImages.unsc1Png;
        activeIcon = AssetsImages.sc1Png;
        break;
      case 1:
        label = 'trajectory'.tr;
        icon = AssetsImages.unsc2Png;
        activeIcon = AssetsImages.sc2Png;
        break;
      case 2:
        label = 'function'.tr;
        icon = AssetsImages.unsc3Png;
        activeIcon = AssetsImages.sc3Png;
        break;
    }

    return BottomNavigationBarItem(
      label: label,
      icon: ImageWidget(
        imageUrl: icon,
        width: 24.wi,
      ),
      activeIcon: ImageWidget(
        imageUrl: activeIcon,
        width: 24.wi,
      ),
    );
  }
}
