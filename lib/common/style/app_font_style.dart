import 'package:battery/app_library.dart';
TextStyle getFontStyle({
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? fontHeight,
  String fontFamily=FontFamily.regular,
  TextOverflow? overflow,
  TextDecorationStyle? decorationStyle,
  TextDecoration? decoration,
  Color? color}){
  return TextStyle(
    color: color??AppColorPicker.f33,
    fontWeight: fontWeight??FontWeight.w400,
    fontSize: fontSize?.fz,
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing?.wi,
    height: fontHeight?.hi,
    overflow: overflow,
    decoration: decoration, //文字加横线
    decorationStyle:decorationStyle,
  );
}