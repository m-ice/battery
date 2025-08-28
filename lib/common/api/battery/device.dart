import 'package:battery/common/models/api/msg_data_entity.dart';
import 'package:battery/common/models/api/req_agreement_entity.dart';
import 'package:battery/common/models/api/req_device_list_entity.dart';
import 'package:battery/common/models/api/req_upLocation_entity.dart';
import 'package:battery/common/models/api/res_device_info_entity.dart';
import 'package:battery/common/models/api/res_device_list_entity.dart';
import 'package:battery/common/models/api/res_locationAreaList_entity.dart';
import 'package:battery/common/models/api/res_trajectoryInfo_entity.dart';
import 'package:battery/common/models/api/res_trajectoryLists_entity.dart';
import 'package:battery/common/models/api/res_user_entity.dart';
import 'package:battery/common/services/battery_http.dart';
import 'package:battery/common/utils/toast.dart';

class DeviceApis {
  ///添加设备
  static Future<ResUserEntity?> add({
    required ResDeviceListDeviceList resDeviceListDeviceList,
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/device/add',
      data: resDeviceListDeviceList.toJson(),
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      // showCustomToast(message: data.msg);
      return null;
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///设备列表
  static Future<ResDeviceListEntity?> list() async {
    var res = await BatteryHttpService.to.post(
      '/api/device/list',
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      // showCustomToast(message: data.msg);
      return ResDeviceListEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///设备信息
  static Future<ResDeviceInfoEntity?> info(String deviceId) async {
    var res = await BatteryHttpService.to
        .post('/api/device/info', data: {"device_id": deviceId});
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      // showCustomToast(message: data.msg);
      return ResDeviceInfoEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///协议
  static Future<ReqAgreementEntity?> agreement({
    String type = '1',
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/index/agreement',
      data: {
        'type': type,
      },
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      // showCustomToast(message: data.msg);
      return ReqAgreementEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///历史轨迹
  static Future<ResTrajectoryListsEntity?> trajectoryList({
    String page = '1',
    String size = '10',
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/device/trajectoryList',
      data: {
        'page': page,
        'size': size,
      },
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      return ResTrajectoryListsEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///历史轨迹
  static Future<void> updateTrajectoryEndAddress({
    String address = '10',
    String groupId = '10',
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/device/updateTrajectoryEndAddress',
      data: {'address': address, 'group_id': groupId},
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
    } else {
      showCustomToast(message: data.msg);
    }
  }

  ///历史轨迹
  static Future<ResTrajectoryInfoEntity?> trajectoryInfo({
    String groupId = '1',
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/device/trajectoryInfo',
      data: {
        'group_id': groupId,
      },
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      return ResTrajectoryInfoEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///历史点亮上传
  static Future<void> upLocationArea({
    String deviceId = '1',
    String areaName = '1',
  }) async {
    var res = await BatteryHttpService.to.post('/api/device/upLocationArea',
        data: {
          'device_id': deviceId,
          'area_id': areaName,
          'area_name': areaName
        });
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
    } else {
      showCustomToast(message: data.msg);
    }
  }

  ///历史点亮
  static Future<ResLocationAreaListEntity?> locationAreaList() async {
    var res = await BatteryHttpService.to.post(
      '/api/device/locationAreaList',
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
      return ResLocationAreaListEntity.fromJson(data.data);
    } else {
      showCustomToast(message: data.msg);
      return null;
    }
  }

  ///上传定位
  static Future<void> upLocation({
    required ReqUpLocationEntity reqData,
  }) async {
    var res = await BatteryHttpService.to.post(
      '/api/device/upLocation',
      data: reqData.toJson(),
    );
    var data = MsgDataEntity.fromJson(res.data);
    if (data.code == 1) {
    } else {
      showCustomToast(message: data.msg);
    }
  }
}
