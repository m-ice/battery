import 'dart:io';

import 'package:battery/common/models/api/msg_data_entity.dart';
import 'package:battery/common/models/api/res_firmwareUpdate_entity.dart';
import 'package:battery/common/models/api/res_upload_entity.dart';
import 'package:battery/common/models/api/res_user_detail_entity.dart';
import 'package:battery/common/models/api/res_user_entity.dart';
import 'package:battery/common/services/battery_http.dart';
import 'package:battery/common/services/user.dart';
import 'package:battery/common/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:my_tool_kit/my_tool_kit.dart';

class UserApis {
  ///登录
  static Future<ResUserEntity?> login(
      {required String userName, required String password}) async {
    var res = await BatteryHttpService.to.post(
      '/api/user/login',
      data: {'password': password, 'account': userName},
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      return ResUserEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///修改头像
  static Future<ResUploadEntity?> upload({required String file}) async {
    try {
      // 读取文件
      File f = File(file);
      if (!f.existsSync()) {
        showCustomToast(message: "File does not exist!");
        return null;
      }

      // 构造 Multipart 请求
      var formData = FormData();
      formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(f.path,
              filename: f.uri.pathSegments.last)));

      // 发送请求
      var res = await BatteryHttpService.to.post(
        '/api/common/upload',
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      var data = MsgDataEntity.fromJson(res.data);
      if (data.code == 1) {
        showCustomToast(message: data.msg);
        return ResUploadEntity.fromJson(data.data);
      } else {
        showCustomToast(message: data.msg);
        return null;
      }
    } catch (e) {
      MyLog.d(e);
      return null;
    }
  }

  ///获取用户信息
  static Future<ResUserDetailEntity?> userinfo() async {
    var res = await BatteryHttpService.to.post(
      '/api/user/userinfo',
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      final dataDetail = ResUserDetailEntity.fromJson(data.data);
      UserService.to.user.value = UserService.to.user.value
          .copyWith(avatar: dataDetail.userinfo?.avatar);
      return dataDetail;
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///修改用户信息
  static Future<MsgDataEntity?> profile({
    String? avatar,
    String? nickname,
    String? gender,
  }) async {
    var res = await BatteryHttpService.to.post('/api/user/profile',
        data: {'avatar': avatar, 'nickname': nickname, 'gender': gender});
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      showCustomToast(message: data.msg);
      return null;
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///查询是否可以app升级
  static Future<ResFirmwareUpdateEntity?> firmwareUpdate() async {
    var res = await BatteryHttpService.to.post(
      '/api/device/firmwareUpdate',
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      return ResFirmwareUpdateEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }
}
