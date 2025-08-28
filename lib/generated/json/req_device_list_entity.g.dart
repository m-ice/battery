import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/req_device_list_entity.dart';

ReqDeviceListEntity $ReqDeviceListEntityFromJson(Map<String, dynamic> json) {
  final ReqDeviceListEntity reqDeviceListEntity = ReqDeviceListEntity();
  final List<
      ReqDeviceListDeviceList>? deviceList = (json['device_list'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ReqDeviceListDeviceList>(
          e) as ReqDeviceListDeviceList).toList();
  if (deviceList != null) {
    reqDeviceListEntity.deviceList = deviceList;
  }
  return reqDeviceListEntity;
}

Map<String, dynamic> $ReqDeviceListEntityToJson(ReqDeviceListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['device_list'] = entity.deviceList.map((v) => v.toJson()).toList();
  return data;
}

extension ReqDeviceListEntityExtension on ReqDeviceListEntity {
  ReqDeviceListEntity copyWith({
    List<ReqDeviceListDeviceList>? deviceList,
  }) {
    return ReqDeviceListEntity()
      ..deviceList = deviceList ?? this.deviceList;
  }
}

ReqDeviceListDeviceList $ReqDeviceListDeviceListFromJson(
    Map<String, dynamic> json) {
  final ReqDeviceListDeviceList reqDeviceListDeviceList = ReqDeviceListDeviceList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    reqDeviceListDeviceList.name = name;
  }
  final String? imei = jsonConvert.convert<String>(json['imei']);
  if (imei != null) {
    reqDeviceListDeviceList.imei = imei;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    reqDeviceListDeviceList.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    reqDeviceListDeviceList.userId = userId;
  }
  return reqDeviceListDeviceList;
}

Map<String, dynamic> $ReqDeviceListDeviceListToJson(
    ReqDeviceListDeviceList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['imei'] = entity.imei;
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  return data;
}

extension ReqDeviceListDeviceListExtension on ReqDeviceListDeviceList {
  ReqDeviceListDeviceList copyWith({
    String? name,
    String? imei,
    int? id,
    int? userId,
  }) {
    return ReqDeviceListDeviceList()
      ..name = name ?? this.name
      ..imei = imei ?? this.imei
      ..id = id ?? this.id
      ..userId = userId ?? this.userId;
  }
}