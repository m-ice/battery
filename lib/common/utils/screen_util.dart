import '../index.dart';

extension IntMatching on int {
  /// 适配宽度
  double get wi => w;

  /// 适配高度
  double get hi => h;

  /// 适配字体大小
  double get fz => sp;

  /// 适配圆角大小
  double get ri => r;
}

extension DoubleMatching on double {
  /// 适配宽度
  double get wi => w;

  /// 适配高度
  double get hi => h;

  /// 适配字体大小
  double get fz => sp;

  /// 适配圆角大小
  double get ri => r;
}

Widget screenUtilInitBuilder({required ScreenBuildCall build, Widget? child}) {
  return ScreenUtilInit(
    designSize: Constants.designSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
      return build(child);
    },
    child: child,
  );
}
