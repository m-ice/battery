import 'dart:ui';

/// 常量
class Constants {
  /// 服务 api
  static const apiUrl = 'http://43.139.126.111:166/';

  ///谷歌的key
  static String apiKey =
      'AIzaSyBDPvr3ZhMqSJNPaxJM1ZKfQZm10H-JMYs'; // 请替换为你的 API Key
  ///用户信息
  static String userInfo = 'userInfo';

  ///用户的账号密码
  static String userNamePassWord = 'userNamePassWord';

  /// 缓存图片宽度
  static const int kCacheImageWidth = 700;

  /// 设计稿尺寸
  static const Size designSize = Size(375, 812);

  /// 登录用户的ID
  static String userId = '001';
  static String languageKey = '001$userId';
  static int languageIndex = 1;
  static Locale? languageLocale;

  /// 高德地图的key
  // static const AMapApiKey amapApiKeys = AMapApiKey(
  //     androidKey: 'fb98043a460f5301010ac0cf229e46e6',
  //     iosKey: '11921d280f98bc5590d4c560f1d5e762');

  // /// 高德地图的初始化配置
  // static const AMapPrivacyStatement amapPrivacyStatement =
  //     AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}
