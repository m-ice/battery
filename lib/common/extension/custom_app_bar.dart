import 'package:battery/app_library.dart';

extension CustomAppBar on BuildContext {
  AppBar getAppBar(
      {bool centerTitle = true,
      bool automaticallyImplyLeading = false,
      Widget? leading,
      List<Widget>? actions,
      Color? backgroundColor,
      Color? surfaceTintColor,
      ClickCall? backCall,
      ClickCall? scanTap,
      bool showBack = true,
      Color? backIconColor,
      TextStyle? titleTextStyle,
      String? title}) {
    return AppBar(
      centerTitle: centerTitle,
      surfaceTintColor: surfaceTintColor ?? AppColorPicker.bg00bdff,
      leading: showBack
          ? Container(
              width: leading == null ? null : 80.wi,
              alignment: Alignment.centerLeft,
              child: leading ??
                  IconButton(
                    tooltip: MaterialLocalizations.of(this).backButtonTooltip,
                    onPressed: backCall ??
                        () {
                          Get.back();
                        },
                    iconSize: 24.wi,
                    icon: ImageWidget(
                      imageUrl: AssetsImages.arrowLeftPng,
                      color: backIconColor ?? AppColorPicker.f33,
                      width: 24.wi,
                    ),
                  ),
            )
          : null,
      leadingWidth: leading == null ? null : 80.wi,
      actions: [
        if (scanTap != null)
          IconButton(
              onPressed: scanTap,
              iconSize: 24.wi,
              icon: ImageWidget(
                imageUrl: AssetsImages.scanPng,
                width: 24.wi,
              )),
        if (actions != null) ...actions
      ],
      backgroundColor: backgroundColor ?? AppColorPicker.bgf6f6f6,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title != null
          ? Text(
              title,
              style: titleTextStyle ??
                  getFontStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColorPicker.f33),
            )
          : null,
    );
  }
}
