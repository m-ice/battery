import 'package:battery/app_library.dart';
import 'package:battery/common/enum/bms.dart';

extension BlueDatasExtension on BMS {
  List<int> intData() {
    List<int> data = [];
    // // 添加从机地址（比如 0x01）
    data.add(0x01);

    // 添加功能码（比如 0x04 代表读数据）
    data.add(fc);

    // 添加起始地址（高字节 + 低字节）
    data.add((datas >> 8) & 0xFF); // 高字节
    data.add(datas & 0xFF); // 低字节

    // 计算数据长度（每个地址的字节数 * 地址数量）
    int byteCount = count; // 因为 HEX、ASCII、WORD 每个地址都是 2 个字节

    // 添加读取的字节数（高字节 + 低字节）
    data.add((byteCount >> 8) & 0xFF); // 高字节
    data.add(byteCount & 0xFF); // 低字节

    return data;
  }

  ///发送蓝牙数据
  List<int> modbus() {
    List<int> data = intData(); // 计算 CRC 前的数据
    int crc = data.crc();
    int crcLo = crc & 0xFF; // 低字节
    int crcHi = (crc >> 8) & 0xFF; // 高字节
    // 发送完整 Modbus 帧
    List<int> modbusFrame = [...data, crcHi, crcLo];
    return modbusFrame;
  }

  ///发送密码数据
  List<int> passWordModbus(String password) {
    List<int> data = [];
    // // 添加从机地址（比如 0x01）
    data.add(0x01);

    // 添加功能码（比如 0x04 代表读数据）
    data.add(fc);

    // 添加起始地址（高字节 + 低字节）
    data.add((datas >> 8) & 0xFF); // 高字节
    data.add(datas & 0xFF); // 低字节

    List<int> pwdBytes = password.codeUnits; // 转为ASCII码列表
    final dataPassword = pwdBytes.passwordModbus();
    data.addAll(dataPassword);

    int crc = data.crc();
    int crcLo = crc & 0xFF; // 低字节
    int crcHi = (crc >> 8) & 0xFF; // 高字节
    // 发送完整 Modbus 帧
    List<int> modbusFrame = [...data, crcHi, crcLo];
    return modbusFrame;
  }

  ///设置指令
  List<int> setup(int password) {
    List<int> data = [];
    // // 添加从机地址（比如 0x01）
    data.add(0x01);

    // 添加功能码（比如 0x04 代表读数据）
    data.add(fc);

    // 添加起始地址（高字节 + 低字节）
    data.add((datas >> 8) & 0xFF); // 高字节
    data.add(datas & 0xFF); // 低字节

    data.add((password >> 8) & 0xFF); // 高字节
    data.add(password & 0xFF); // 低字节

    int crc = data.crc();
    int crcLo = crc & 0xFF; // 低字节
    int crcHi = (crc >> 8) & 0xFF; // 高字节
    // 发送完整 Modbus 帧
    List<int> modbusFrame = [...data, crcHi, crcLo];
    return modbusFrame;
  }
}
