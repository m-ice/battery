import 'package:battery/app_library.dart';

class SystemUpdateDialogWidget extends StatelessWidget {
  final ClickCall? sureUpdateTap;
  final String? version;
  const SystemUpdateDialogWidget({super.key, this.sureUpdateTap, this.version});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300.wi,
                height: 247.hi,
                margin: EdgeInsets.only(bottom: 10.hi),
                decoration: const BoxDecoration(
                  color: AppColorPicker.transparent,
                  image: DecorationImage(
                    image: AssetImage(
                      AssetsImages.systemUpdatePng,
                    ),
                  ),
                ),
                child: Material(
                  color: AppColorPicker.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40.hi, left: 13.wi),
                        child: Text(
                          'discoverNewVersion'.tr,
                          style: getFontStyle(
                            fontSize: 18,
                            color: AppColorPicker.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 43.hi),
                        width: 300.wi,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkButton(
                                  backGroundColor: AppColorPicker.bgffe055,
                                  borderRadius: BorderRadius.circular(15.ri),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.wi),
                                  // height: 26.hi,
                                  title: 'v$version',
                                  textStyle: getFontStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 6.hi,
                                bottom: 27.hi,
                              ),
                              child: Text(
                                'fixedSomeIssues'.tr,
                                style: getFontStyle(
                                  fontSize: 12,
                                  color: AppColorPicker.f66,
                                ),
                              ),
                            ),
                            InkButton(
                              decoration: BoxDecoration(
                                color: AppColorPicker.bg00bdff,
                                borderRadius: BorderRadius.circular(25.ri),
                                gradient: SweepGradient(
                                  endAngle: 347.wi / 2,
                                  colors: const [
                                    AppColorPicker.bg00bdff,
                                    AppColorPicker.bg61abff,
                                  ],
                                ),
                              ),
                              width: 176.wi,
                              padding: EdgeInsets.symmetric(vertical: 8.hi),
                              textStyle: getFontStyle(
                                fontSize: 16,
                                color: AppColorPicker.white,
                              ),
                              title: 'updateNow'.tr,
                              onTap: sureUpdateTap,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                iconSize: 26.wi,
                onPressed: () {
                  Get.back(result: false);
                },
                icon: Opacity(
                  opacity: 0.5,
                  child: ImageWidget(
                    imageUrl: AssetsImages.closePng,
                    width: 26.wi,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // ImageWidget(
              //   imageUrl: AssetsImages.systemUpdatePng,
              //   width: 300.wi,
              // ),
            ],
          ),
        )
      ],
    );
  }
}
