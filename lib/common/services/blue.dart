import 'dart:async';
import 'dart:collection';
import 'package:battery/app_library.dart';
import 'package:battery/common/api/battery/device.dart';
import 'package:battery/common/enum/bms.dart';
import 'package:battery/common/extension/blue_data.dart';
import 'package:battery/common/models/api/res_device_info_entity.dart';
import 'package:battery/common/models/api/res_device_list_entity.dart';
import 'package:battery/common/models/blue_data.dart';
import 'package:battery/common/utils/log_util.dart';
import 'package:battery/common/widgets/popup_pin.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as data;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tool_kit/my_tool_kit.dart';
import 'package:get/get.dart';

enum DataDeviceType {
  ///正在连接
  isOPen,

  ///连接成功
  isBind,

  /// 连接失败
  none
}

class BluetoothDataService extends GetxService {
  /// 创建单例模式
  static BluetoothDataService get to => Get.find<BluetoothDataService>();

  /// 蓝牙扫描结果列表
  RxList<data.ScanResult> scanResults = <data.ScanResult>[].obs;

  /// 监听蓝牙扫描的 Stream 订阅
  StreamSubscription<List<data.ScanResult>>? scanResultsAsync;

  /// 监听蓝牙连接状态的 Stream 订阅
  StreamSubscription<data.BluetoothConnectionState>? scanblueDevice;

  /// 监听蓝牙数据通知的 Stream 订阅
  StreamSubscription<List<int>>? subscription;

  /// 定时器，用于持续发送数据
  Timer? _sendTimer;

  /// 当前连接的蓝牙设备
  data.ScanResult? blueDevice;

  ///是否正在连接
  Rx<DataDeviceType> dataDeviceType = DataDeviceType.none.obs;

  ///当前连接的蓝牙下标
  Rx<int> currentIndex = (-1).obs;

  /// 设备 ID 列表（存储已绑定的蓝牙设备）
  List<String> devicesId = [];

  /// 设备数据列表
  List<ResDeviceListDeviceList> devicesList = [];

  ///当前设备详细数据
  ResDeviceInfoEntity? resDeviceInfoEntity;

  ///当前设备数据
  ResDeviceListDeviceList? resDeviceListDeviceList;

  ///是否第一次连接上一次设备
  bool _firstOpenLastDevice = false;

  /// 开始扫描蓝牙设备
  /// 初始化蓝牙设备列表（仅包含符合特征值的设备）
  void initDevice() async {
    // if (blueDevice != null) {
    //   await blueDevice!.device.disconnect();
    // }
    scanResultsAsync =
        BluetoothService.to.scanResults.listen((scanResultsData) async {
      deviceGetData(scanResultsData);
    });
    await BluetoothService.to.startScanning(androidUsesFineLocation: true);
    MyLog.d("message${BluetoothService.to.isBluetoothOn}");
  }

  ///获取已连接设备
  Future<void> _disconnectAllConnectedDevices() async {
    try {
      List<data.BluetoothDevice> connectedDevices =
          data.FlutterBluePlus.connectedDevices;
      for (var device in connectedDevices) {
        await device.disconnect();
        LogUtil.d("已断开设备: ${device.remoteId}");
      }
    } catch (e) {
      LogUtil.d("断开蓝牙设备失败: $e");
    }
  }

  ///初始化数据
  void deviceGetData(List<data.ScanResult> scanResultsData) async {
    List<data.ScanResult> filteredResults = [];

    if (blueDevice != null) {
      currentIndex.value = 0;
      filteredResults.add(blueDevice!);
    }
    final lastDeviceOpen = SpUtil.getString('lastDeviceOpen');
    for (var result in scanResultsData) {
      if (result.advertisementData.advName.isNotEmpty) {
        bool hasTargetCharacteristic = await checkDeviceById(result.device);
        if (hasTargetCharacteristic && blueDevice != result) {
          filteredResults.add(result);
        }
        if (!_firstOpenLastDevice) {
          if ((lastDeviceOpen?.isNotEmpty ?? false) &&
              lastDeviceOpen == result.device.remoteId.str &&
              blueDevice == null) {
            final index = devicesId
                .indexWhere((data) => data == result.device.remoteId.str);
            if (index == -1) continue;
            scanblueDevice?.cancel();
            dataDeviceType.value = DataDeviceType.isOPen; // 尝试连接时，先设为 true
            currentIndex.value = index;
            blueDevice = result;
            _firstOpenLastDevice = true;
            await result.device.connect();
            scanblueDevice = result.device.connectionState.listen((state) {
              buleStateVoid(state);
            });
          }
        }
      }
    }

    if (_isDeviceListChanged(scanResults, filteredResults)) {
      scanResults.assignAll(filteredResults);
    }
  }

  bool _isDeviceListChanged(
      List<data.ScanResult> oldList, List<data.ScanResult> newList) {
    if (oldList.length != newList.length) return true;

    for (int i = 0; i < newList.length; i++) {
      final oldDevice = oldList[i];
      final newDevice = newList[i];

      // 比较 device ID（唯一标识） 和 RSSI（信号强度）
      if (oldDevice.device.id != newDevice.device.id ||
          oldDevice.rssi != newDevice.rssi) {
        return true;
      }
    }

    return false;
  }

  ///重新开始扫描
  void updataDevice() {
    // gerDevice();
    if (currentIndex.value != -1) {
      currentIndex.value = 0;
    }
    BluetoothService.to.startScanning(androidUsesFineLocation: true);
  }

  Future<bool> checkDeviceById(data.BluetoothDevice device) async {
    try {
      // 获取设备 ID
      String deviceId = device.remoteId.toString().toUpperCase();
      // 检查设备 ID 是否在 devicesId 列表中
      for (var element in devicesId) {
        if (deviceId == element) {
          return true; // 如果找到匹配的设备 ID
        }
      }
      return false; // 如果没有找到匹配的设备 ID
    } catch (e) {
      return false;
    }
  }

  /// 连接指定的蓝牙设备
  Future<void> connectDevice(int index) async {
    if (index < 0 ||
        index >= scanResults.length ||
        index == currentIndex.value) {
      return;
    }
    scanblueDevice?.cancel();
    dataDeviceType.value = DataDeviceType.isOPen; // 尝试连接时，先设为 true
    currentIndex.value = index;
    blueDevice = scanResults[currentIndex.value];
    try {
      await blueDevice?.device.connect();
      scanblueDevice = blueDevice?.device.connectionState.listen((state) {
        buleStateVoid(state);
      });
    } catch (e) {
      LogUtil.d("蓝牙连接失败: $e");
    }
  }

  ///蓝牙状态方法
  void buleStateVoid(data.BluetoothConnectionState state) async {
    if (state == data.BluetoothConnectionState.connected) {
      await startListening();
      showOtpDialog(onClose: () {
        if (BlueDatabase.passWordEnum == PassWordEnum.no) {
          disconnectDevice();
          onCloseDevice();
        }
      }, onConfirm: (String code) async {
        if (code.length == 4) {
          final command = BMS.d60.passWordModbus(code);
          await sendDataQueued(command);
        }
      });
    } else if (state == data.BluetoothConnectionState.disconnected) {
      if (currentIndex.value != -1) {
        dataDeviceType.value = DataDeviceType.none;
        Get.toNamed(RouteNames.bindBattery, arguments: true);
        blueDevice = null;
        currentIndex.value = -1;
        stopSendingData();
        BlueDatabase.passWordEnum = PassWordEnum.no;
        if (Get.isRegistered<VircController>() &&
            VircController.to.lockStatus.value &&
            Get.isRegistered<HomeController>()) {
          HomeController.to.clealStream();
        }
      }

      // _initData();
    } else {
      BlueDatabase.passWordEnum = PassWordEnum.no;
      dataDeviceType.value = DataDeviceType.isOPen;
      // _initData();
    }
  }

  /// 断开当前蓝牙设备的连接
  Future<void> disconnectDevice() async {
    await blueDevice?.device.disconnect();
    blueDevice = null;
    await scanblueDevice?.cancel();
    stopSendingData();
  }

  /// 监听蓝牙设备的数据通知
  Future<void> startListening() async {
    if (blueDevice == null) return;
    List<data.BluetoothService> services =
        await blueDevice!.device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          await characteristic.setNotifyValue(true);
          subscription?.cancel();
          subscription = characteristic.onValueReceived.listen((value) {
            getblueData(value);
          });
          LogUtil.d("已开启蓝牙数据通知");
          return;
        }
      }
    }
  }

  ///获取数据解析数据
  void getblueData(List<int> value) async {
    String hexString =
        value.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');

    if (value.verifyModbusCRC()) {
      BlueDatabase.setData(value);
      // LogUtil.d("收到蓝牙数据: $hexString");

      ///密码匹配成功
      if (BlueDatabase.passWordEnum.index == 0 &&
          dataDeviceType.value != DataDeviceType.isBind) {
        SpUtil.putString(
            'lastDeviceOpen', blueDevice?.device.remoteId.toString() ?? '');
        dataDeviceType.value = DataDeviceType.isBind; // 连接成功后设为 false
        Get.back();
        Get.toNamed(RouteNames.bindBattery, arguments: false);
        saveDeviceData();
        sendDataQueued(BMS.d81.setup(0));
        startSendingData();
        if (Get.isRegistered<VircController>()) {
          VircController.to.lockStatus.value = false;
        }
        for (var element in devicesList) {
          if (element.imei == blueDevice?.device.remoteId.toString()) {
            resDeviceInfoEntity = await DeviceApis.info(element.id.toString());
            resDeviceListDeviceList = element;
            break;
          }
        }
      } else if (dataDeviceType.value != DataDeviceType.isBind) {
        dataDeviceType.value = DataDeviceType.none;
        ToastUtil.showToast(BlueDatabase.passWordEnum.name.tr,
            gravity: ToastGravity.BOTTOM);
        Get.back();
      }

      // LogUtil.d(BlueDatabase.bmsData86.toString());
      // LogUtil.d(BlueDatabase.bmsData50.toString());
    } // dataDeviceType.value = DataDeviceType.isBind; // 连接成功后设为 false
    // Get.toNamed(RouteNames.bindBattery, arguments: false);
    // startListening();
    // startSendingData();

    // _initData();
  }

  /// 发送数据到蓝牙设备
  Future<void> _internalSend(List<int> dataToSend) async {
    if (blueDevice == null) {
      LogUtil.d("未连接蓝牙设备，无法发送数据");
      return;
    }

    const String serviceUuid = "00010203-0405-0607-0809-0a0b0c0dffe0";
    const String writeCharUuid = "00010203-0405-0607-0809-0a0b0c0dffe2";

    try {
      data.BluetoothService? targetService = await getService(serviceUuid);
      data.BluetoothCharacteristic? writeCharacteristic =
          getCharacteristic(targetService, writeCharUuid);
      String hexString =
          dataToSend.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
      // LogUtil.d("发送数据成功: $hexString");
      if (writeCharacteristic?.properties.write ?? false) {
        await writeCharacteristic?.write(dataToSend, withoutResponse: false);
        // LogUtil.d("成功发送数据（有响应模式）: $dataToSend");
      } else if (writeCharacteristic?.properties.writeWithoutResponse ??
          false) {
        await writeCharacteristic?.write(dataToSend, withoutResponse: true);
        // LogUtil.d("成功发送数据（无响应模式）: $hexString");
      } else {
        LogUtil.d("该特征值不支持写入: $writeCharUuid");
      }
    } catch (e) {
      LogUtil.d("发送数据失败: $e");
    }
  }

  final Queue<List<int>> _writeQueue = Queue();
  bool _isWriting = false;

  Future<void> sendDataQueued(List<int> dataToSend) async {
    _writeQueue.add(dataToSend);
    if (!_isWriting) _processQueue();
  }

  void _processQueue() async {
    _isWriting = true;
    while (_writeQueue.isNotEmpty) {
      final data = _writeQueue.removeFirst();
      await _internalSend(data); // 调用你原本的 sendData 逻辑
      await Future.delayed(const Duration(milliseconds: 200)); // 控制频率
    }
    _isWriting = false;
  }

  /// 获取指定服务
  Future<data.BluetoothService?> getService(String serviceUuid) async {
    List<data.BluetoothService> services =
        await blueDevice!.device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == serviceUuid) {
        return service;
      }
    }
    return null;
  }

  /// 获取指定特征值
  data.BluetoothCharacteristic? getCharacteristic(
      data.BluetoothService? service, String charUuid) {
    if (service == null) return null;
    for (var characteristic in service.characteristics) {
      if (characteristic.uuid.toString() == charUuid) {
        return characteristic;
      }
    }
    return null;
  }

  /// 开启定时器，每秒发送一次数据
  void startSendingData() {
    _sendTimer?.cancel();
    _sendTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      saveDeviceData();
    });
  }

  ///给设备定时发送数据
  void saveDeviceData() async {
    if (blueDevice == null) {
      LogUtil.d("未连接蓝牙设备，停止发送数据");
      stopSendingData();
      return;
    }

    List<int> command = BMS.d96.modbus();
    List<int> commandData = BMS.d0.modbus();

    try {
      await sendDataQueued(command);
      await sendDataQueued(commandData);
      // LogUtil.d("发送数据成功: $commandD81");
    } catch (e) {
      LogUtil.d("发送数据失败: $e");
      stopSendingData();
    }
  }

  /// 停止发送数据
  void stopSendingData() {
    _sendTimer?.cancel();
    _sendTimer = null;
    LogUtil.d("已停止发送数据");
  }

  ///后端获取当前的蓝牙设备
  void gerDevice() async {
    List<String> newDeviceList = [];
    List<ResDeviceListDeviceList> newDeviceListData = [];
    final data = await DeviceApis.list();
    if (data != null) {
      for (var i = 0; i < (data.deviceList?.length ?? 0); i++) {
        if (data.deviceList?[i].imei?.isNotEmpty ?? false) {
          newDeviceList.add(data.deviceList?[i].imei ?? '');
          newDeviceListData
              .add(data.deviceList?[i] ?? ResDeviceListDeviceList());
        }
      }
      if (newDeviceList.isNotEmpty) {
        devicesId = newDeviceList;
        devicesList = newDeviceListData;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    gerDevice();
    getPermission();
  }

  ///请求权限完成后
  void getPermission() async {
    Get.put<BluetoothService>(BluetoothService());
    final data = await PermissionConfigUtil.requestLocationPermission();
    if (data) {
      _disconnectAllConnectedDevices();
      initDevice();
    }
  }

  ///删除监听的设备
  void onCloseDevice() async {
    currentIndex.value = -1;
    await blueDevice?.device.disconnect();
    blueDevice = null;
    await scanResultsAsync?.cancel();
    await scanblueDevice?.cancel();
    await subscription?.cancel();
  }

  ///销毁定时器
  void despose() {
    stopSendingData();
    onCloseDevice();
  }

  @override
  void onClose() {
    stopSendingData();
    onCloseDevice();
    super.onClose();
  }
}
