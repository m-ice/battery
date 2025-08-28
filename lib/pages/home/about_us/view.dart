import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/api/battery/user.dart';

class AboutusPage extends StatefulWidget {
  const AboutusPage({super.key});

  @override
  State<AboutusPage> createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  late String title = '';
  late String content = '';
  String type = '';

  void dataInfo() async {
    final data = await DeviceApis.agreement(type: type);
    setState(() {
      title = data?.name ?? '';
      content = data?.content ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is Map) {
      type = Get.arguments['type'];
      dataInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPicker.bgf6f6f6,
      body: HomeBackgroundWidget(
          child: Column(
        children: [
          context.getAppBar(
            title: title,
            backgroundColor: AppColorPicker.transparent,
          ),
          Expanded(
              child: ColoredBox(
            color: AppColorPicker.white,
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 13.hi,
                horizontal: 14.wi,
              ),
              children: [
                Text(
                  content.tr,
                  style: getFontStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
