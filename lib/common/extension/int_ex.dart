import 'dart:math';

extension IntExtension on int {
  // 生成6字节随机数
  List<int> generateRandomBytes() {
    Random random = Random();
    List<int> randomBytes = List.generate(this, (index) => random.nextInt(256));
    return randomBytes;
  }
}
