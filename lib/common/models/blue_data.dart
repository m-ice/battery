import 'package:battery/app_library.dart';
import 'package:battery/common/enum/bms.dart';
import 'package:get/get_core/src/get_main.dart';

enum PassWordEnum {
  ///密码正确
  yes,

  /// 密码错误
  no,

  /// 密码不合理
  notReasonable,

  /// 未知
  err
}

/// 蓝牙设备数据管理 - 单例模式
class BlueDatabase {
  /// 私有构造函数，防止外部实例化
  BlueDatabase._privateConstructor();

  /// 静态私有实例
  static final BlueDatabase _instance = BlueDatabase._privateConstructor();

  /// 公开访问点
  static BlueDatabase get instance => _instance;

  ///50的全部数据
  static BMSData bmsData50 = BMSData([]);

  ///86的数据
  static BMSData86 bmsData86 = BMSData86([]);

  /// 密码枚举
  static PassWordEnum passWordEnum = PassWordEnum.no;

  static void setData(List<int> data) {
    if (data.length - 6 == (BMS.d0.count * 2)) {
      bmsData50 = BMSData(data);
    } else if (data.length - 6 == (BMS.d96.count * 2)) {
      bmsData86 = BMSData86(data);
    } else if (data.length == 7) {
      passWordEnum = PassWordEnum.values[data[4]];
    }
    VircController.to.update();
  }
}

/// BMS 数据解析类
class BMSData {
  /// 原始数据
  List<int> rawData;

  /// 起始寄存器地址（2 字节）
  int startAddress = 0;

  /// 地址数量（2 字节，表示接下来有多少个数据字节）
  int addressCount = 0;

  /// BMS 软件版本号（20 字节 HEX）
  String bmsSoftwareVersion = '';

  /// BMS 硬件版本号（15 字节 HEX）
  String bmsHardwareVersion = '';

  /// BMS 识别码（10 字节 ASCII）
  String bmsIdentifier = "";

  /// 系统时间（3 字节 ASCII）
  String systemTime = "";

  /// 零漂电流值（1 WORD = 2 字节，表示无电流时的采集值）有效值范围：-32768～32767
  int zeroDriftCurrent = 0;

  /// 自检结果返回值（1 WORD = 2 字节，自检后的状态）按位定义 0 ：自检正常，1：自检异常  详见《附录6_自检位内容》
  int selfCheckResult = 0;

  /// 系统控制命令（1 WORD = 2 字节，用于控制 BMS）
  /// 按位定义 0 ：未触发，1：触发  详见《附录5_系统控制位内容》
  int systemControlCommand = 0;

  BMSData(this.rawData) {
    _parseData();
  }

  /// 解析 BMS 蓝牙返回的数据
  void _parseData() {
    if (rawData.isEmpty) {
      return;
    }
    int index = 0;

    // 解析起始寄存器地址（2 字节）
    startAddress = (rawData[index] << 8) | rawData[index + 1];
    index += 2;

    // 解析地址数量（2 字节）
    addressCount = (rawData[index] << 8) | rawData[index + 1];
    index += 2;

    // 解析 BMS 软件版本号（20 字节 HEX）
    // 解析 BMS 软件版本号（40 字节 ASCII，不够补空格）
    List<int> softwareBytes = rawData.sublist(index, index + 40);
    bmsSoftwareVersion =
        String.fromCharCodes(softwareBytes).trimRight(); // 去除末尾空格
    index += 40;

    // 解析 BMS 硬件版本号（20 字节 HEX）
    List<int> bmsHardwareVersionInt = rawData.sublist(index, index + 20);
    bmsHardwareVersion =
        String.fromCharCodes(bmsHardwareVersionInt).trimRight();
    index += 20;

    // 解析 BMS 识别码（20 字节 ASCII）
    bmsIdentifier = String.fromCharCodes(rawData.sublist(index, index + 20));
    index += 20;

    // 解析系统时间（6 字节 ASCII）
    // 假设系统时间字段从index开始，取6个字节
    List<int> timeBytes = rawData.sublist(index, index + 6);

// 按照你提供的格式解析系统时间
    int year = timeBytes[0] + 2000; // 年份是从2000年开始
    int month = timeBytes[1]; // 月份
    int day = timeBytes[2]; // 日期
    int hour = timeBytes[3]; // 小时
    int minute = timeBytes[4]; // 分钟
    int second = timeBytes[5]; // 秒

// 格式化时间输出
    systemTime = '$year年$month月$day日 $hour时$minute分$second秒';

// 更新index
    index += 6;

    // 解析零漂电流值（1 WORD = 2 字节）
    zeroDriftCurrent = (rawData[index] << 8) | rawData[index + 1];
    index += 2;

    // 解析自检结果返回值（1 WORD = 2 字节）
    selfCheckResult = (rawData[index] << 8) | rawData[index + 1];
    index += 2;
    index += 8;
    // 解析系统控制命令（1 WORD = 2 字节）
    systemControlCommand = (rawData[index] << 8) | rawData[index + 1];
  }

  /// 打印解析的数据
  @override
  String toString() {
    return 'BMSData(\n'
        '  BMS 软件版本号: $bmsSoftwareVersion,\n'
        '  BMS 硬件版本号: $bmsHardwareVersion,\n'
        '  BMS 识别码: $bmsIdentifier,\n'
        '  系统时间: $systemTime,\n'
        '  零漂电流值: $zeroDriftCurrent,\n'
        '  自检结果返回值: $selfCheckResult,\n'
        '  系统控制命令: $systemControlCommand,\n'
        ')';
  }
}

class BMSData86 {
  /// 原始数据
  List<int> rawData;
  // 实时数据字段
  /// 最大单体电压
  double maxCellVoltage = 0;

  /// 最小单体电压
  double minCellVoltage = 0;

  /// 最大单体电压编号
  int maxCellVoltageIndex = 0;

  /// 最小单体电压编号
  int minCellVoltageIndex = 0;

  /// 电芯探头最高温度
  double maxTempProbe = 0;

  /// 电芯探头最低温度
  double minTempProbe = 0;

  /// 电芯探头最高温度编号
  int maxTempProbeIndex = 0;

  /// 电芯探头最低温度编号
  int minTempProbeIndex = 0;

  /// 单体电池电压（32个电池电压）
  List<double> cellVoltages = [];

  /// 探针温度（6个探针温度）
  List<double> probeTemperatures = [];

  /// SOC（电池状态）
  int soc = 0;

  /// SOH（健康状态）
  int soh = 0;

  /// 充电电流（SOP）
  double chargeCurrent = 0;

  /// 放电电流（SOP）
  double dischargeCurrent = 0;

  /// 总电流
  double totalCurrent = 0;

  /// 总电压
  double totalVoltage = 0;

  /// 短路次数
  int shortCircuitCount = 0;

  /// 充电次数
  int chargeCount = 0;

  /// 循环次数
  int cycleCount = 0;

  /// 充电总时间
  int totalChargeTime = 0;

  /// 放电总时间
  int totalDischargeTime = 0;

  /// 最大充电间隔时间
  int maxChargeInterval = 0;

  /// 最大放电间隔时间
  int maxDischargeInterval = 0;

  /// 均衡状态
  int balanceStatus = 0;

  /// 工作状态
  int workStatus = 0;

  /// 故障状态
  int faultStatus = 0;

  /// 故障等级
  int faultLevel = 0;

  /// 最大压差
  double maxVoltageDifference = 0;

  /// MOS温度
  double mosTemperature = 0;

  /// 环境温度
  double environmentTemperature = 0;

  /// 剩余容量
  double remainingCapacity = 0;

  /// 满充容量
  double fullChargeCapacity = 0;

  /// 循环容量
  double cycleCapacity = 0;

  /// 标称容量
  double nominalCapacity = 0;

  /// 充/放电剩余时间
  int remainingTime = 0;

  /// 充电MOS状态
  int chargeMosStatus = 0;

  /// 放电MOS状态
  int dischargeMosStatus = 0;

  /// 预充MOS状态
  int preChargeMosStatus = 0;

  /// 预防MOS状态
  int preProtectMosStatus = 0;

  /// 限流MOS状态
  int limitCurrentMosStatus = 0;

  BMSData86(this.rawData) {
    _parseFromRawData();
  }
  // 解析数据方法
  void _parseFromRawData() {
    if (rawData.isEmpty) {
      return;
    }
    int index = 0;
    index += 4;
    // 解析字段
    maxCellVoltage = (rawData[index] << 8 | rawData[index + 1]) / 1000.0;
    index += 2;
    minCellVoltage = (rawData[index] << 8 | rawData[index + 1]) / 1000.0;
    index += 2;
    maxCellVoltageIndex = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    minCellVoltageIndex = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    maxTempProbe = (rawData[index] << 8 | rawData[index + 1]) - 40.0;
    index += 2; // 转换温度
    minTempProbe = (rawData[index] << 8 | rawData[index + 1]) - 40.0;
    index += 2; // 转换温度
    maxTempProbeIndex = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    minTempProbeIndex = rawData[index] << 8 | rawData[index + 1];
    index += 2;

    for (int i = 0; i < 32; i++) {
      double voltage =
          (rawData[index] << 8 | rawData[index + 1]) / 1000.0; // 电压转换
      cellVoltages.add(voltage);
      index += 2;
    }

    for (int i = 0; i < 6; i++) {
      double temp = (rawData[index] << 8 | rawData[index + 1]) - 40.0; // 温度转换
      probeTemperatures.add(temp);
      index += 2;
    }

    // 解析SOC, SOH等其他字段
    soc = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    soh = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    int rawValue = (rawData[index] << 8) | rawData[index + 1];
    chargeCurrent = (rawValue - 10000) * 0.1;
    index += 2; // 充电电流
    dischargeCurrent =
        (((rawData[index] << 8) | rawData[index + 1]) - 10000) * 0.1;
    index += 2; // 放电电流
    totalCurrent = (((rawData[index] << 8) | rawData[index + 1]) - 10000) * 0.1;
    index += 2; // 总电流
    totalVoltage = (rawData[index] << 8 | rawData[index + 1]) / 10.0;
    index += 2; // 总电压

    // 解析其他数据字段：短路次数、充电次数、循环次数等
    shortCircuitCount = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    chargeCount = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    cycleCount = rawData[index] << 8 | rawData[index + 1];
    index += 2;
    totalChargeTime = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;

    // 解析放电总时间、最大充电间隔时间等
    totalDischargeTime = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;
    maxChargeInterval = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;
    maxDischargeInterval = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;

    // 解析均衡状态、工作状态、故障状态等
    balanceStatus = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;
    workStatus = (rawData[index] << 8 | rawData[index + 1]) << 16 |
        (rawData[index + 2] << 8 | rawData[index + 3]);
    index += 4;
    faultStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    faultLevel = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;

    // 解析电压差、MOS温度等
    maxVoltageDifference = (rawData[index] << 8 | rawData[index + 1]) / 1000.0;
    index += 2;
    mosTemperature = (rawData[index] << 8 | rawData[index + 1]) - 40.0;
    index += 2; // 转换温度
    environmentTemperature = (rawData[index] << 8 | rawData[index + 1]) - 40.0;
    index += 2; // 转换温度

    // 解析剩余容量、满充容量、循环容量等
    remainingCapacity = ((rawData[index] << 8 | rawData[index + 1]) << 16 |
            (rawData[index + 2] << 8 | rawData[index + 3])) /
        1000.0;
    index += 4;
    fullChargeCapacity = ((rawData[index] << 8 | rawData[index + 1]) << 16 |
            (rawData[index + 2] << 8 | rawData[index + 3])) /
        1000.0;
    index += 4;
    cycleCapacity = ((rawData[index] << 8 | rawData[index + 1]) << 16 |
            (rawData[index + 2] << 8 | rawData[index + 3])) /
        1000.0;
    index += 4;
    nominalCapacity = ((rawData[index] << 8 | rawData[index + 1]) << 16 |
            (rawData[index + 2] << 8 | rawData[index + 3])) /
        1000.0;
    index += 4;

    // 解析剩余时间、MOS状态等
    remainingTime = (rawData[index] << 8 | rawData[index + 1]);
    index += 2; // 充/放电剩余时间

    chargeMosStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    dischargeMosStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    preChargeMosStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    preProtectMosStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
    limitCurrentMosStatus = (rawData[index] << 8 | rawData[index + 1]);
    index += 2;
  }

  @override
  String toString() {
    return 'BMSData86(\n'
        '  最大单体电压: $maxCellVoltage,\n'
        '  最小单体电压: $minCellVoltage,\n'
        '  最大单体电压编号: $maxCellVoltageIndex,\n'
        '  最小单体电压编号: $minCellVoltageIndex,\n'
        '  电芯探头最高温度: $maxTempProbe,\n'
        '  电芯探头最低温度: $minTempProbe,\n'
        '  电芯探头最高温度编号: $maxTempProbeIndex,\n'
        '  电芯探头最低温度编号: $minTempProbeIndex,\n'
        '  单体电池电压: $cellVoltages,\n'
        '  探针温度: $probeTemperatures,\n'
        '  电池状态 (SOC): $soc,\n'
        '  健康状态 (SOH): $soh,\n'
        '  充电电流: $chargeCurrent,\n'
        '  放电电流: $dischargeCurrent,\n'
        '  总电流: $totalCurrent,\n'
        '  总电压: $totalVoltage,\n'
        '  短路次数: $shortCircuitCount,\n'
        '  充电次数: $chargeCount,\n'
        '  循环次数: $cycleCount,\n'
        '  充电总时间: $totalChargeTime,\n'
        '  放电总时间: $totalDischargeTime,\n'
        '  最大充电间隔时间: $maxChargeInterval,\n'
        '  最大放电间隔时间: $maxDischargeInterval,\n'
        '  均衡状态: $balanceStatus,\n'
        '  工作状态: $workStatus,\n'
        '  故障状态: $faultStatus,\n'
        '  故障等级: $faultLevel,\n'
        '  最大压差: $maxVoltageDifference,\n'
        '  MOS温度: $mosTemperature,\n'
        '  环境温度: $environmentTemperature,\n'
        '  剩余容量: $remainingCapacity,\n'
        '  满充容量: $fullChargeCapacity,\n'
        '  循环容量: $cycleCapacity,\n'
        '  标称容量: $nominalCapacity,\n'
        '  充/放电剩余时间: $remainingTime,\n'
        '  充电MOS状态: $chargeMosStatus,\n'
        '  放电MOS状态: $dischargeMosStatus,\n'
        '  预充MOS状态: $preChargeMosStatus,\n'
        '  预防MOS状态: $preProtectMosStatus,\n'
        '  限流MOS状态: $limitCurrentMosStatus,\n'
        ')';
  }
}
