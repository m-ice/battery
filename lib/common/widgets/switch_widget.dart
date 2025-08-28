import 'package:battery/app_library.dart';

class SwitchWidget extends StatelessWidget {
  final bool initValue;
  final SwitchOnChangedCall onChanged;
  const SwitchWidget(
      {super.key, required this.initValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
          trackOutlineColor:
          WidgetStateProperty.all(AppColorPicker.transparent),
          activeColor: AppColorPicker.white, // 激活时滑块颜色
          activeTrackColor: AppColorPicker.bg3dd12a, // 激活时轨道颜色
          inactiveThumbColor: AppColorPicker.white, // 非激活时滑块颜色
          inactiveTrackColor: AppColorPicker.bgdf, // 非激活时轨道颜色
          // splashRadius: 38.ri,
          autofocus: true,
          thumbIcon: WidgetStateProperty.all(Icon(
            Icons.abc_outlined,
            color: AppColorPicker.transparent,
            size: 16.wi,
          )),
          value: initValue,
          onChanged: onChanged),
    );
  }
}
