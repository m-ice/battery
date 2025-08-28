import 'app_library.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return screenUtilInitBuilder(build: (Widget? child) {
      return GetMaterialApp(
        builder: (context, widget) {
          // 强制字体不随系统缩放
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: widget!,
          );
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate, //Cupertino组件的翻译回调
          GlobalMaterialLocalizations.delegate, //Material组件的翻译回调
          GlobalMaterialLocalizations.delegate, // 普通 Widget 的翻译回调
          AppLanguage.delegate, // 应用程序的翻译回调
        ],

        initialRoute: RouteNames.login,
        supportedLocales: AppLanguage.delegate.supportedLocales,
        locale: Constants.languageLocale ??
            View.of(context).platformDispatcher.locale, // 将会按照此处指定的语言翻译
        fallbackLocale: AppLanguage.fallbackLocale, // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        translations: AppLanguage(),
        getPages: RoutePages.list,
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.fz),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColorPicker.transparent,
            centerTitle: true,
            titleTextStyle: getFontStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColorPicker.f33),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.blue, // 设置全局光标颜色
            selectionColor: Colors.blue.withValues(alpha: 0.5), // 选择文本时的高亮颜色
            selectionHandleColor: Colors.blue, // 设置选择手柄颜色
          ),
          scaffoldBackgroundColor: AppColorPicker.bgf6f6f6,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
        ),
        home: child,
      );
    });
  }
}
