import 'package:battery/app_library.dart';

class AppGlobalController extends GetxController {
  getLanguageLocale() {
    // TODO 记得修改语言
    int? languageIndex = SpUtil.getInt(Constants.languageKey, defValue: 1);
    // int? languageIndex = SpUtil.getInt(Constants.languageKey, defValue: 2);
    LogUtil.d("语言类型下标 $languageIndex");
    if (languageIndex != null &&
        languageIndex >= 0 &&
        languageIndex < AppLanguage.delegate.supportedLocales.length) {
      Get.updateLocale(AppLanguage.delegate.supportedLocales[languageIndex]);
      Constants.languageIndex = languageIndex;
      Constants.languageLocale =
          AppLanguage.delegate.supportedLocales[languageIndex];
    }
  }
}
