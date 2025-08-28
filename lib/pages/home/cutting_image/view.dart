import 'package:battery/app_library.dart';

class CuttingImagePage extends StatefulWidget {
  const CuttingImagePage({super.key});

  @override
  State<CuttingImagePage> createState() => _CuttingImagePageState();
}

class _CuttingImagePageState extends State<CuttingImagePage> {
  CustomImageCropController controller = CustomImageCropController();
  late File file;
  @override
  void initState() {
    super.initState();
    file = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.getAppBar(
          backgroundColor: AppColorPicker.black,
          leading: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'cancel'.tr,
              style: getFontStyle(
                fontSize: 14,
                color: AppColorPicker.white,
              ),
            ),
          ),
          title: 'cutting'.tr,
          titleTextStyle: getFontStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColorPicker.white,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final image = await controller.onCropImage();
                if (image != null) {
                  File f2 =
                      await LocalFilesPathUtil.saveImageToDisk(image.bytes);
                  Get.back(result: f2);
                }
              },
              child: Text(
                'finish'.tr,
                style: getFontStyle(
                  fontSize: 14,
                  color: AppColorPicker.f00bdff,
                ),
              ),
            ),
          ]),
      backgroundColor: AppColorPicker.black,
      body: CustomImageCrop(
        pathPaint: Paint()..strokeWidth = 0,
        clipShapeOnCrop: true,
        cropPercentage: 0.746,
        backgroundColor: AppColorPicker.black,
        overlayColor: AppColorPicker.black,
        cropController: controller,
        image: FileImage(file),
      ),
    );
  }
}
