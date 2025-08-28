import 'dart:convert';

import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/models/api/res_device_list_entity.dart';
import 'package:battery/common/services/blue.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
export 'dart:io' show Platform;

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: AppColorPicker.bg00bdff,
              borderRadius: 0,
              borderLength: 8.wi,
              borderWidth: 2.wi,
              cutOutSize: 282.wi,
            ),
          ),
          Positioned(
              child: Column(
            children: [
              context.getAppBar(
                  backgroundColor: AppColorPicker.transparent,
                  showBack: true,
                  backIconColor: AppColorPicker.white),
              Padding(
                padding: EdgeInsets.only(top: 12.hi, left: 16.wi, right: 16.wi),
                child: Text(
                  'qrCodeHint'.tr,
                  textAlign: TextAlign.center,
                  style: getFontStyle(
                    fontSize: 18,
                    color: AppColorPicker.white,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  bool isValidMacAddress(String input) {
    RegExp regExp = RegExp(r'^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$');
    return regExp.hasMatch(input);
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        LogUtil.d('扫描二维码结果：${scanData.code}');
        // Get.back(result: scanData.code);
        ResDeviceListDeviceList? data;
        try {
          if (scanData.code != null) {
            final decoded = jsonDecode(scanData.code!);
            data = ResDeviceListDeviceList.fromJson(decoded);
          }
        } catch (e) {
          print('解析失败: $e');
        }
        if (data != null) {
          await DeviceApis.add(resDeviceListDeviceList: data);
          Get.offNamed(RouteNames.bindBattery, arguments: scanData.code);
          BluetoothDataService.to.updataDevice();
        } else {
          // print('Invalid MAC Address');
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
