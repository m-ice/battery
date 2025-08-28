import 'package:battery/app_library.dart';

class InkButton extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final Widget? child;
  final String? title;
  final Color? backGroundColor;
  final Color? splashColor;
  final double elevation;
  final Function()? onTap;

  const InkButton(
      {super.key,
      this.width,
      this.padding,
      this.borderRadius,
      this.textStyle,
      this.title,
      this.onTap,
      this.decoration,
      this.child,
      this.height,
      this.splashColor,
      this.backGroundColor,
      this.elevation = 0.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      // color: decoration != null ? decoration?.color : backGroundColor,
      color: AppColorPicker.transparent,
      borderRadius:
          decoration != null ? decoration?.borderRadius : borderRadius,
      child: InkWell(
        borderRadius: decoration != null
            ? decoration?.borderRadius as BorderRadius
            : borderRadius,
        splashColor: splashColor,
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                  color: backGroundColor ?? AppColorPicker.white,
                  borderRadius: borderRadius),
          child: title != null || child != null
              ? Center(
                  child: child ??
                      Text(
                        title.toString(),
                        style: textStyle,
                      ),
                )
              : null,
        ),
      ),
    );
  }
}
