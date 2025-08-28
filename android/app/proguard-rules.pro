-keep class com.pauldemarco.flutter_blue.Protos* { *; }
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

-keep class android.R$* { *; }
-keep public class com.yourpackage.image_gallery_saver.** { *; }

-keep class com.zing.zalo.**{ *; }
-keep enum com.zing.zalo.**{ *; }
-keep interface com.zing.zalo.**{ *; }

-keep class com.amap.api.maps2d.**{*;}
-keep class com.amap.api.mapcore2d.**{*;}
-keep class com.amap.api.navi.**{*;}
-keep class com.autonavi.**{*;}
-keep class com.amap.api.location.**{*;}
-keep class com.amap.api.fence.**{*;}
-keep class com.loc.**{*;}
-keep class com.autonavi.aps.amapapi.model.**{*;}
-keep class com.lib.flutter_blue_plus.* { *; }


# 防止 shared_preferences 被混淆
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Flutter 基础类（你已经加了，可以再确认一下）
-keep class io.flutter.** { *; }
