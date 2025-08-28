import 'package:battery/app_library.dart';

class LanguageSettingsPage extends GetView<HomeController> {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: 'home',
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColorPicker.bgf6f6f6,
          body: Obx(()=>HomeBackgroundWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.getAppBar(
                  backgroundColor: AppColorPicker.transparent,
                  title: 'languageSettings'.tr,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 26.hi,
                    bottom: 10.hi,
                    left: 14.wi,
                    right: 14.wi,
                  ),
                  child: Text(
                    'language'.tr,
                    style: getFontStyle(
                      fontSize: 16,
                      color: AppColorPicker.f66,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 14.wi,
                  ),
                  decoration: BoxDecoration(
                      color: AppColorPicker.white,
                      borderRadius: BorderRadius.circular(8.ri),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.hi),
                          blurRadius: 8.ri,
                          spreadRadius: 0,
                          color: AppColorPicker.black.withOpacity(0.03),
                        ),
                      ]),
                  child: Column(
                    children: List.generate(2, (index) {
                      return InkButton(
                        height: 58.hi,
                        onTap: () {
                      controller.switchLanguage(index: index);
                        },
                        padding: EdgeInsets.only(
                          left: 10.wi,
                          right: 14.wi,
                        ),
                        decoration: BoxDecoration(
                            color: AppColorPicker.white,
                            borderRadius: BorderRadius.vertical(
                              top: index == 0 ? Radius.circular(8.ri) : Radius.zero,
                              bottom:
                              index == 1 ? Radius.circular(8.ri) : Radius.zero,
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ImageWidget(
                                    imageUrl: [
                                      AssetsImages.vietnamesePng,
                                      AssetsImages.englishPng,
                                    ][index],
                                    width: 24.wi,
                                  ),
                                  SizedBox(
                                    width: 4.wi,
                                  ),
                                  Text(
                                    ['vietnamese', 'english'][index].tr,
                                    style: getFontStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            ImageWidget(
                              imageUrl: [
                                AssetsImages.selectedPng,
                                AssetsImages.unSelectPng,
                              ][controller.languageIndex.value==index ? 0 : 1],
                              width: 18.wi,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),),
        );
      }
    );
  }
}
