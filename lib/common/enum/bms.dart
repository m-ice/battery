enum BMS {
  /// BMS 软件版本号
  d0(04, 0, 50),

  /// BMS 硬件版本号
  d96(04, 96, 86),

  ///密码配置
  d60(96, 00, 1),

  ///电池开启或关闭
  d81(97, 81, 1),

  ///蓝牙强启指令
  d82(97, 82, 1),

  ///蓝牙自动解锁
  d83(97, 83, 1);

  // 枚举的构造函数
  const BMS(this.fc, this.datas, this.count);
  //Fc
  final int fc;

  ///寄存器
  final int datas;

  ///数量
  final int count;
}
