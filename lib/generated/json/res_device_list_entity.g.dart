import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_device_list_entity.dart';

ResDeviceListEntity $ResDeviceListEntityFromJson(Map<String, dynamic> json) {
  final ResDeviceListEntity resDeviceListEntity = ResDeviceListEntity();
  final List<
      ResDeviceListDeviceList>? deviceList = (json['device_list'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ResDeviceListDeviceList>(
          e) as ResDeviceListDeviceList).toList();
  if (deviceList != null) {
    resDeviceListEntity.deviceList = deviceList;
  }
  return resDeviceListEntity;
}

Map<String, dynamic> $ResDeviceListEntityToJson(ResDeviceListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['device_list'] = entity.deviceList?.map((v) => v.toJson()).toList();
  return data;
}

extension ResDeviceListEntityExtension on ResDeviceListEntity {
  ResDeviceListEntity copyWith({
    List<ResDeviceListDeviceList>? deviceList,
  }) {
    return ResDeviceListEntity()
      ..deviceList = deviceList ?? this.deviceList;
  }
}

ResDeviceListDeviceList $ResDeviceListDeviceListFromJson(
    Map<String, dynamic> json) {
  final ResDeviceListDeviceList resDeviceListDeviceList = ResDeviceListDeviceList();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    resDeviceListDeviceList.name = name;
  }
  final String? imei = jsonConvert.convert<String>(json['imei']);
  if (imei != null) {
    resDeviceListDeviceList.imei = imei;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    resDeviceListDeviceList.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    resDeviceListDeviceList.userId = userId;
  }
  return resDeviceListDeviceList;
}

Map<String, dynamic> $ResDeviceListDeviceListToJson(
    ResDeviceListDeviceList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['imei'] = entity.imei;
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  return data;
}

extension ResDeviceListDeviceListExtension on ResDeviceListDeviceList {
  ResDeviceListDeviceList copyWith({
    String? name,
    String? imei,
    int? id,
    int? userId,
  }) {
    return ResDeviceListDeviceList()
      ..name = name ?? this.name
      ..imei = imei ?? this.imei
      ..id = id ?? this.id
      ..userId = userId ?? this.userId;
  }
}