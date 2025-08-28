import 'package:battery/app_library.dart';

class EmergencyContactPersonPage extends GetView<FunctionController> {
  const EmergencyContactPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunctionController>(
        init: FunctionController(),
        id: 'function',
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColorPicker.bgf6f6f6,
            body: HomeBackgroundWidget(
              child: Column(
                children: [
                  context.getAppBar(
                    backgroundColor: AppColorPicker.transparent,
                    title: 'emergencyContactPerson'.tr,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.dialog(InputHintDialogWidget(
                            title: 'add'.tr,
                            textEditingControllerList: [
                              controller.nameEditingController.value,
                              controller.phoneNumberEditingController.value,
                            ],
                            inputTypeList: ['name1'.tr, 'phoneNumber1'.tr],
                            textInputType: const [
                              TextInputType.name,
                              TextInputType.phone
                            ],
                            confirmTap: () {
                              Get.back(result: true);
                            },
                            hintTextList: [
                              'name1Hint'.tr,
                              'phoneNumberHint'.tr
                            ],
                          ));
                        },
                        icon: ImageWidget(
                          imageUrl: AssetsImages.addPng,
                          width: 24.wi,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 4,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.hi, horizontal: 14.wi),
                      itemBuilder: (cx, index) {
                        return Container(
                          padding: EdgeInsets.only(
                            top: 15.hi,
                            bottom: 15.hi,
                            left: 10.wi,
                          ),
                          decoration: BoxDecoration(
                              color: AppColorPicker.white,
                              borderRadius: BorderRadius.circular(8.ri),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColorPicker.black.withOpacity(0.03),
                                  offset: Offset(0, 2.hi),
                                  blurRadius: 10.ri,
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: _buildPersonalConnect(index),
                        );
                      },
                      separatorBuilder: (cx, index) {
                        return SizedBox(
                          height: 14.hi,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Row _buildPersonalConnect(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              imageUrl: [
                AssetsImages.contactGreenPng,
                AssetsImages.contactBrownPng,
                AssetsImages.contactYellowPng,
                AssetsImages.contactBluePng
              ][index % 4],
              width: 34.wi,
            ),
            SizedBox(
              width: 8.wi,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfo(
                  name: 'name'.tr,
                  contect: 'Eimile',
                ),
                SizedBox(
                  height: 4.hi,
                ),
                _buildInfo(
                  name: 'phoneNumber'.tr,
                  contect: '12345678901',
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                controller
                  ..nameEditingController.value.text = 'Eimile'
                  ..phoneNumberEditingController.value.text = '12345678901'
                  ..update(['function']);

                Get.dialog(InputHintDialogWidget(
                  title: 'edit'.tr,
                  inputTypeList: ['name1'.tr, 'phoneNumber1'.tr],
                  hintTextList: ['name1Hint'.tr, 'phoneNumberHint'.tr],
                  textInputType: const [
                    TextInputType.name,
                    TextInputType.phone
                  ],
                  confirmTap: () {
                    Get.back(result: true);
                  },
                  textEditingControllerList: [
                    controller.nameEditingController.value,
                    controller.phoneNumberEditingController.value,
                  ],
                )).then((v) {
                  controller
                    ..nameEditingController.value.text = ''
                    ..phoneNumberEditingController.value.text = ''
                    ..update(['function']);
                });
              },
              iconSize: 24.wi,
              icon: ImageWidget(
                imageUrl: AssetsImages.editPng,
                width: 24.wi,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.dialog(BleHintDialog(
                  content: 'deleteHint'.tr,
                  confirmTap: () {
                    Get.back(result: true);
                  },
                ));
              },
              iconSize: 24.wi,
              icon: ImageWidget(
                imageUrl: AssetsImages.deletePng,
                width: 24.wi,
              ),
            ),
          ],
        )
      ],
    );
  }

  RichText _buildInfo({required String name, required String contect}) {
    return RichText(
      text: TextSpan(text: name, style: getFontStyle(fontSize: 14), children: [
        TextSpan(
          text: contect,
          style: getFontStyle(
            fontSize: 14,
            color: AppColorPicker.f66,
          ),
        ),
      ]),
    );
  }
}
