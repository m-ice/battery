import 'package:battery/common/index.dart';
import 'package:pinput/pinput.dart';

void showOtpDialog({
  required Function(String code) onConfirm,
  Function()? onClose, // 👈 新增：关闭时触发
}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColorPicker.white,
      surfaceTintColor: AppColorPicker.white,
      title: Text(
        'enterVerificationCode'.tr,
        style: getFontStyle(color: AppColorPicker.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Pinput(
            length: 4,
            onChanged: (value) {
              onConfirm(value); // 实时回调（可选）
            },
            defaultPinTheme: PinTheme(
              width: 48,
              height: 48,
              textStyle: const TextStyle(fontSize: 20),
              decoration: BoxDecoration(
                color: AppColorPicker.bg00bdff,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: true, // 👈 允许点击外部关闭
  ).whenComplete(() {
    if (onClose != null) {
      onClose(); // 👈 弹窗被关闭后触发
    }
  });
}
