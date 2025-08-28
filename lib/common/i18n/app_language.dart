// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:battery/app_library.dart';

import 'index.dart';
import 'package:intl/intl.dart';
// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLanguage with Translations {
  AppLanguage();

  static AppLanguage? _current;

  static AppLanguage get current {
    assert(_current != null,
        'No instance of AppLanguage was loaded. Try to initialize the AppLanguage delegate before accessing AppLanguage.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLanguage> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) async {
      Intl.defaultLocale = localeName;
      final instance = AppLanguage();
      AppLanguage._current = instance;
      return instance;
    });
    // final instance = AppLanguage();
    // AppLanguage._current = instance;
    // return instance;
  }

  static Locale? get locale => Get.deviceLocale;

  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'vi': vi,
        'en_US': en_US,
        'zh_CN': zh_CN,
      };

  static const List languages = [
    Locale('vi', 'US'),
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  static Future<bool> initializeMessages(String localeName) {
    return SynchronousFuture(true);
  }

  static AppLanguage of(BuildContext context) {
    final instance = AppLanguage.maybeOf(context);
    assert(instance != null,
        'No instance of AppLanguage present in the widget tree. Did you add AppLanguage.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLanguage? maybeOf(BuildContext context) {
    return Localizations.of<AppLanguage>(context, AppLanguage);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLanguage> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLanguage> load(Locale locale) => AppLanguage.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
