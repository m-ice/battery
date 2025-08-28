import 'package:battery/app_library.dart';

class InputHintDialogWidget extends StatelessWidget {
  final String? title;
  final String? confirmTitle;
  final String? cancelTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? confirmTitleTextStyle;
  final TextStyle? cancelTitleTextStyle;
  final List<TextEditingController>? textEditingControllerList;
  final List<String>? hintTextList;
  final TextStyle? inputTextStyle;
  final TextStyle? hintTextTextStyle;
  final List<String>? inputTypeList;
  final List<TextInputType>? textInputType;
  final TextStyle? inputTypeTextStyle;
  final Function()? confirmTap;
  final Function()? cancelTap;
  final bool showCancelBtn;
  final bool firstAutofocus;

  const InputHintDialogWidget({
    super.key,
    this.title,
    this.confirmTitle,
    this.cancelTitle,
    this.titleTextStyle,
    this.confirmTitleTextStyle,
    this.cancelTitleTextStyle,
    this.hintTextTextStyle,
    this.confirmTap,
    this.cancelTap,
    this.showCancelBtn = true,
    this.textEditingControllerList,
    this.hintTextList,
    this.inputTextStyle,
    this.inputTypeList,
    this.textInputType,
    this.inputTypeTextStyle,
    this.firstAutofocus = true,
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
                  width: 347.wi,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.hi),
                  decoration: BoxDecoration(
                      color: AppColorPicker.white,
                      borderRadius: BorderRadius.circular(10.ri)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.wi),
                        child: Text(
                          title ?? 'hint'.tr,
                          textAlign: TextAlign.center,
                          style: titleTextStyle ??
                              getFontStyle(
                                fontSize: 18,
                                color: AppColorPicker.f66,
                              ),
                        ),
                      ),
                      if (inputTypeList != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.hi,
                            bottom: 25.hi,
                            right: 25.wi,
                            left: 25.wi,
                          ),
                          child: AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListView.separated(
                                  itemCount: inputTypeList?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (cx, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          inputTypeList?[index] ?? '',
                                          style: inputTypeTextStyle ??
                                              getFontStyle(
                                                fontSize: 16,
                                                color: AppColorPicker.f66,
                                              ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4.hi),
                                          height: 40.hi,
                                          child: TextField(
                                            controller:
                                                textEditingControllerList?[
                                                    index],
                                            // obscureText: obscureText,
                                            // keyboardType: keyboardType,
                                            keyboardType: textInputType != null
                                                ? textInputType![index]
                                                : null,
                                            style: inputTextStyle ??
                                                getFontStyle(fontSize: 14),
                                            autofocus: 0 == index
                                                ? firstAutofocus
                                                : false,
                                            textInputAction:
                                                inputTypeList?.length ==
                                                        index + 1
                                                    ? TextInputAction.done
                                                    : TextInputAction.next,
                                            decoration: InputDecoration(
                                              hintText: hintTextList?[index],
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.ri)),
                                              filled: true,
                                              fillColor:
                                                  AppColorPicker.bgf6f7f9,
                                              contentPadding: EdgeInsets.only(
                                                top: 6.hi,
                                                bottom: 6.hi,
                                                left: 11.wi,
                                                right: 0,
                                              ),
                                              hintStyle: hintTextTextStyle ??
                                                  getFontStyle(
                                                    fontSize: 14,
                                                    color: AppColorPicker.f99,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (cx, index) {
                                    return SizedBox(
                                      height: 8.hi,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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
