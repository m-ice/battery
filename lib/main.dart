import 'package:battery/app.dart';
import 'package:battery/app_library.dart';
import 'package:battery/common/services/battery_http.dart';
import 'package:battery/common/services/user.dart';
import 'package:my_tool_kit/my_tool_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.dark,
  //   systemNavigationBarColor: AppColorPicker.black,
  // );
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  await SpUtil.getInstance();
  Get.put(AppGlobalController());
  Get.put(BatteryHttpService());
  Get.put(UserService());
  runApp(const App());
}
