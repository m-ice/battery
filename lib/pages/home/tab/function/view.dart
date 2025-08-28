import 'package:battery/app_library.dart';

class FunctionPage extends GetView<FunctionController> {
  const FunctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunctionController>(
        init: FunctionController(),
        id: 'function',
        builder: (controller) {
          return Obx(() => GridView.count(
                padding:
                    EdgeInsets.symmetric(vertical: 20.hi, horizontal: 14.wi),
                crossAxisCount: 2,
                crossAxisSpacing: 15.wi,
                mainAxisSpacing: 14.hi,
                childAspectRatio: 1.482,
                children: List.generate(
                  controller.dataList.length,
                  (index) =>
                      _buildFunctionItem(modeUI: controller.dataList[index]),
                ),
              ));
        });
  }

  Widget _buildFunctionItem({required FunctionModelUI modeUI}) {
    return InkButton(
      onTap: modeUI.showSwitch
          ? null
          : () {
              controller.turnSwitch(modeUI: modeUI);
            },
      width: 166.wi,
      padding:
          EdgeInsets.only(top: 13.hi, bottom: 11.hi, left: 11.wi, right: 11.wi),
      decoration: BoxDecoration(
          color: AppColorPicker.white,
          borderRadius: BorderRadius.circular(8.ri),
          boxShadow: [
            BoxShadow(
                color: AppColorPicker.black.withOpacity(0.03),
                offset: Offset(0, 2.hi),
                blurRadius: 8.ri,
                spreadRadius: 0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.hi),
                  child: ImageWidget(
                    imageUrl: modeUI.iconPath,
                    width: 40.wi,
                  ),
                ),
                Expanded(
                  child: Text(
                    modeUI.title.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: getFontStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (modeUI.showSwitch)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: modeUI.showSingleArrow ? 24.hi : 0),
                    child: SwitchWidget(
                      initValue: modeUI.switchValue,
                      onChanged: (v) {
                        controller.turnSwitch(
                          modeUI: modeUI,
                        );
                      },
                    ),
                  ),
                Visibility(
                  visible: modeUI.showSingleArrow,
                  child: ImageWidget(
                    imageUrl: AssetsImages.singleArrowPng,
                    width: 16.wi,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
