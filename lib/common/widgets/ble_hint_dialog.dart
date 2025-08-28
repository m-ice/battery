import 'package:battery/app_library.dart';

class BleHintDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? confirmTitle;
  final String? cancelTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;
  final TextStyle? confirmTitleTextStyle;
  final TextStyle? cancelTitleTextStyle;
  final Function()? confirmTap;
  final Function()? cancelTap;
  final bool showCancelBtn;
  final bool showTextField;
  final String? hintText;
  final String? unit;
  const BleHintDialog({
    super.key,
    this.title,
    this.content,
    this.confirmTitle,
    this.cancelTitle,
    this.titleTextStyle,
    this.contentTextStyle,
    this.confirmTitleTextStyle,
    this.cancelTitleTextStyle,
    this.confirmTap,
    this.cancelTap,
    this.showCancelBtn = true,
    this.showTextField = false,
    this.hintText,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColorPicker.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 270.wi,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.hi),
                  decoration: BoxDecoration(
                      color: AppColorPicker.white,
                      borderRadius: BorderRadius.circular(10.ri)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.wi),
                        child: Text(
                          title ?? 'hint'.tr,
                          textAlign: TextAlign.center,
                          style: titleTextStyle ??
                              getFontStyle(
                                fontSize: 16,
                                color: AppColorPicker.f66,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.hi,
                            bottom: 19.hi,
                            right: 8.wi,
                            left: 8.wi),
                        child: Column(
                          children: [
                            if (content != null)
                              Text(
                                '$content',
                                textAlign: TextAlign.center,
                                style: contentTextStyle ??
                                    getFontStyle(fontSize: 16),
                              ),
                            if (showTextField)
                              Container(
                                margin: EdgeInsets.only(
                                  top: 7.hi,
                                  left: 58.wi,
                                  right: 58.wi,
                                ),
                                height: 32.hi,
                                padding: EdgeInsets.only(right: 5.wi),
                                decoration: BoxDecoration(
                                  color: AppColorPicker.bgf6f7f9,
                                  borderRadius: BorderRadius.circular(10.ri),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        // controller: textEditingController,
                                        // obscureText: obscureText,
                                        // keyboardType: keyboardType,
                                        style: getFontStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          hintText: hintText,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.ri)),
                                          filled: true,
                                          fillColor: AppColorPicker.bgf6f7f9,
                                          contentPadding: EdgeInsets.only(
                                            top: 6.hi,
                                            bottom: 6.hi,
                                            left: 11.wi,
                                            right: 0,
                                          ),
                                          hintStyle: getFontStyle(
                                            fontSize: 14,
                                            color: AppColorPicker.black,
                                          ),
                                        ),
                                        // suffixIcon: suffixIconPath != null
                                        //     ? IconButton(
                                        //         onPressed: showPassword,
                                        //         icon: ImageWidget(imageUrl: suffixIconPath))
                                        //     : null,
                                      ),
                                    ),
                                    if (unit != null)
                                      Text(
                                        '$unit',
                                        textAlign: TextAlign.center,
                                        style: getFontStyle(
                                          fontSize: 12,
                                          color: AppColorPicker.f66,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      // const Spacer(),
                      Column(
                        children: [
                          Divider(
                            color: AppColorPicker.bgf1,
                            thickness: 1.hi,
                            height: 2.hi,
                          ),
                          showCancelBtn
                              ? Row(
                            children: [
                              Expanded(
                                child: InkButton(
                                  height: 43.hi,
                                  onTap: cancelTap ??
                                          () {
                                        Get.back(result: false);
                                      },
                                  decoration: BoxDecoration(
                                      color: AppColorPicker.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                          Radius.circular(10.ri))),
                                  child: Text(
                                    cancelTitle ?? 'cancel'.tr,
                                    style: cancelTitleTextStyle ??
                                        getFontStyle(
                                            fontSize: 16,
                                            color: AppColorPicker.f66),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkButton(
                                  height: 43.hi,
                                  onTap: confirmTap,
                                  decoration: BoxDecoration(
                                      color: AppColorPicker.white,
                                      borderRadius: BorderRadius.only(
                                          bottomRight:
                                          Radius.circular(10.ri))),
                                  child: Text(
                                    confirmTitle ?? 'confirm'.tr,
                                    style: confirmTitleTextStyle ??
                                        getFontStyle(
                                            fontSize: 16,
                                            color:
                                            AppColorPicker.f00bdff),
                                  ),
                                ),
                              ),
                            ],
                          )
                              : InkButton(
                            height: 43.hi,
                            onTap: confirmTap,
                            decoration: BoxDecoration(
                                color: AppColorPicker.white,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10.ri))),
                            child: Text(
                              confirmTitle ?? 'confirm'.tr,
                              style: confirmTitleTextStyle ??
                                  getFontStyle(
                                      fontSize: 16,
                                      color: AppColorPicker.f00bdff),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
