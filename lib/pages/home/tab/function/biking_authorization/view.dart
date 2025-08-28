import 'package:battery/app_library.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class BikingAuthorizationPage extends StatelessWidget {
  final String? qrCodeData;
  final Uint8List? locationData;
  final ClickCall? zaloOnTap;
  final bool showQrcode;
  final bool info;
  final bool showSaveImage;
  BikingAuthorizationPage({
    super.key,
    this.qrCodeData,
    this.locationData,
    this.zaloOnTap,
    this.info = true,
    this.showQrcode = true,
    this.showSaveImage = true,
  });

  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _locationInfoKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPicker.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned.fill(
                child: InkButton(
              backGroundColor: AppColorPicker.transparent,
              splashColor: AppColorPicker.bg00bdff.withValues(alpha: 0.03),
              onTap: () {
                Get.back();
              },
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                showQrcode
                    ? Column(
                        children: [
                          SizedBox(
                            height: 278.hi,
                          ),
                          _buildQrCode(
                            qrData: qrCodeData ?? '',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildLocationInfo(),
                          SizedBox(
                            height: 10.hi,
                          ),
                        ],
                      ),
                if (showQrcode) const Spacer(),
                _buildDownInfo(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildLocationInfo() {
    return RepaintBoundary(
      // 将 RepaintBoundary 包裹住需要截图的部分
      key: _locationInfoKey, // 这里使用你已有的 key
      child: SkeletonWidget(
        width: 300.wi,
        height: 538.24.hi,
        clipBehavior: Clip.hardEdge,
        cornerRadius: 6.ri,
        child: Stack(
          children: [
            Positioned(
              child: locationData != null
                  ? Image.memory(
                      locationData!,
                      width: 300.wi,
                      height: 538.24.hi,
                    )
                  : const Text('点击按钮截图组件'),
            ),
            if (info)
              Positioned(
                  bottom: 4,
                  left: 20,
                  child: Transform.scale(
                    scale: 0.85,
                    child: HomeTopInfo(
                      showMileage: false,
                      allowClick: false,
                      versionTextStyle: getFontStyle(
                        fontSize: 14,
                        color: AppColorPicker.white,
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  /// 底部信息
  Container _buildDownInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColorPicker.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.ri),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2.hi),
              blurRadius: 4.ri,
              spreadRadius: 0,
              color: AppColorPicker.f33.withOpacity(0.08),
            )
          ]),
      padding: EdgeInsets.symmetric(vertical: 11.hi),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(
                bottom: 12.hi,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30.wi,
                    height: 1.hi,
                    color: AppColorPicker.bgd9,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.wi),
                    child: Text(
                      'pleaseSelectSharingMethod'.tr,
                      style: getFontStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: 30.wi,
                    height: 1.hi,
                    color: AppColorPicker.bgd9,
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.wi),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSvaeGenerateQrCode(
                  iconPath: AssetsImages.loginDownPng,
                  title: 'zalo'.tr,
                  onTap: () {
                    if (zaloOnTap != null) {
                      zaloOnTap!();
                      shareQrCodeImageToZalo();
                    }
                  },
                ),
                if (showSaveImage)
                  _buildSvaeGenerateQrCode(
                    iconPath: AssetsImages.saveImagePng,
                    title: 'saveImage'.tr,
                    onTap: () {
                      saveContainerToImage(context);
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 34.wi,
              right: 34.wi,
              bottom: 4.hi,
              top: 7.hi,
            ),
            child: Divider(
              color: AppColorPicker.bgf3,
              height: 1.hi,
              thickness: 1.hi,
            ),
          ),
          InkButton(
            onTap: () {
              Get.back(result: false);
            },
            padding: EdgeInsets.symmetric(
              vertical: 14.hi,
            ),
            backGroundColor: AppColorPicker.white,
            title: 'cancel'.tr,
            textStyle: getFontStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColorPicker.f2e3244,
            ),
          )
        ],
      ),
    );
  }

  Future<void> shareQrCodeImageToZalo() async {
    final granted = await PermissionConfigUtil.requestStoragePermission();
    if (!granted) {
      LogUtil.d("我没有权限");
      return;
    }

    try {
      Uint8List? imageBytes;

      if (locationData != null) {
        imageBytes = await _captureWidgetAsImage(_locationInfoKey);
      } else {
        imageBytes = await _captureWidgetAsImage(_containerKey);
      }

      if (imageBytes == null || imageBytes.isEmpty) {
        LogUtil.e("截图失败，图片数据为空");
        return;
      }

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/qr_share.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      const platform = MethodChannel('zalo_share');
      await platform.invokeMethod('shareImageToZalo', {'path': filePath});
    } catch (e) {
      LogUtil.e("分享二维码失败: $e");
    }
  }

  Future<Uint8List?> _captureWidgetAsImage(GlobalKey key) async {
    try {
      final context = key.currentContext;
      if (context == null) {
        LogUtil.e("截图失败：context 为 null");
        return null;
      }

      await Future.delayed(const Duration(milliseconds: 100)); // 等 UI 稳定

      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        LogUtil.d("等待绘制完成");
        await Future.delayed(const Duration(milliseconds: 50));
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      LogUtil.e("截图出错: $e");
      return null;
    }
  }

  saveContainerToImage(BuildContext context) {
    // 请求存储权限
    PermissionConfigUtil.requestStoragePermission().then((v) async {
      if (v) {
        RenderRepaintBoundary boundary = _containerKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage();

        ByteData? byteData =
            await (image.toByteData(format: ui.ImageByteFormat.png));
        SaveImageUtil.saveImageToPhotoAlbum(byteData: byteData).then((result) {
          if (result != null) {
            Get.back();
          }
        });
      } else {
        LogUtil.d("我没有权限");
      }
    });
  }

  /// 二维码
  Widget _buildQrCode({required String qrData}) {
    return RepaintBoundary(
      key: _containerKey,
      child: Container(
        width: 238.wi,
        padding: EdgeInsets.only(
          top: 16.hi,
          bottom: 15.hi,
        ),
        decoration: BoxDecoration(
          color: AppColorPicker.white,
          borderRadius: BorderRadius.circular(6.ri),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              imageUrl: AssetsImages.qrTitlePng,
              width: 100.25.wi,
            ),
            Container(
              width: 150.wi,
              height: 150.wi,
              margin: EdgeInsets.only(
                top: 20.hi,
                bottom: 13.hi,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColorPicker.bg1d3074,
                  width: 2.wi,
                ),
              ),
              padding: EdgeInsets.all(5.wi),
              child: QrImageView(
                data: qrData,
                dataModuleStyle: const QrDataModuleStyle(
                  color: AppColorPicker.bg1d3074,
                ),
                eyeStyle: const QrEyeStyle(
                  color: AppColorPicker.bg1d3074,
                  eyeShape: QrEyeShape.square,
                ),
                version: QrVersions.auto,
                size: 140.wi,
              ),
            ),
            Text(
              'scanCodeAuthorization'.tr,
              style: getFontStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 底部信息按钮
  GestureDetector _buildSvaeGenerateQrCode(
      {ClickCall? onTap, required String title, required String iconPath}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          ImageWidget(
            imageUrl: iconPath,
            width: 34.wi,
          ),
          SizedBox(
            height: 4.hi,
          ),
          Text(
            title,
            style: getFontStyle(
              fontSize: 12,
              color: AppColorPicker.f2e3244,
            ),
          )
        ],
      ),
    );
  }
}
