import 'package:battery/common/extension/int_ex.dart';
import 'package:battery/common/values/blue_value.dart';
import 'package:my_tool_kit/my_tool_kit.dart';

extension BlueDatasExtension on List<int> {
  ///错误校验
  int crc() {
    int hi = 0xFF;
    int lo = 0xFF;
    int i;
    for (int len = 0; len < length; len++) {
      i = hi ^ this[len];
      hi = lo ^ modbusCRCHi[i];
      lo = modbusCRCLo[i];
    }
    return (hi << 8) + lo;
  }

  // 密码的crc
  List<int> calculateCRC32() {
    const int INIT = 0xffffffff;
    const int XOROT = 0xffffffff;
    int crcValue = INIT;

    // Loop through each byte of the data
    for (int i = 0; i < length; i++) {
      crcValue = crc32cTable[(crcValue ^ this[i]) & 0xFF] ^ (crcValue >> 8);
    }

    // XOR result with XOROT and return it as 4 bytes in a List<int>
    crcValue ^= XOROT;

    // Return the CRC32 result as 4 bytes (List<int>)
    return [
      (crcValue >> 24) & 0xFF, // highest byte
      (crcValue >> 16) & 0xFF,
      (crcValue >> 8) & 0xFF,
      crcValue & 0xFF // lowest byte
    ];
  }

  ///判断接受的数据是否正确
  bool verifyModbusCRC() {
    if (length < 3) return false; // 至少要有地址、功能码和 CRC

    // 分割数据，去掉 CRC 进行校验
    List<int> dataWithoutCRC = sublist(0, length - 2);
    int receivedCrcHi = this[length - 2]; // 高字节
    int receivedCrcLo = this[length - 1]; // 低字节
    int receivedCrc = (receivedCrcHi << 8) | receivedCrcLo; // 组合成完整 CRC

    // 计算 CRC
    int calculatedCrc = dataWithoutCRC.crc();
    // 校验 CRC 是否匹配
    return calculatedCrc == receivedCrc;
  }

  ///密码的蓝牙数据
  List<int> passwordModbus() {
    // 1. 生成 6 字节的随机数
    List<int> randomBytes = 6.generateRandomBytes();
    String hexString =
        randomBytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
    MyLog.d("随机数 $hexString");
    // 2. 4字节密钥
    int key = 0x19871323; // 示例密钥
    List<int> keyBytes = [
      (key >> 24) & 0xFF, // 高字节
      (key >> 16) & 0xFF,
      (key >> 8) & 0xFF,
      key & 0xFF // 低字节
    ];
    String keyhexString =
        keyBytes.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
    MyLog.d("key $keyhexString");
    // 3. 参数传入的 4字节 SN 号
    // sn 已经是传入的 4字节数据
    String thishexString =
        map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
    MyLog.d("sn $thishexString");
    // 组合成一个数据包
    List<int> data = randomBytes + keyBytes + this;

    // 计算 CRC32 校验和
    List<int> crc32Result = data.calculateCRC32();
    String crc32ResulthexString =
        crc32Result.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
    MyLog.d("验证码 $crc32ResulthexString");
    // 将 CRC32 校验结果和 randomBytes 拼接（获取低字节）
    List<int> crcLo = randomBytes + crc32Result;
    String crcLoResulthexString =
        crcLo.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
    MyLog.d("crcLo $crcLoResulthexString");
    return crcLo;
  }
}
