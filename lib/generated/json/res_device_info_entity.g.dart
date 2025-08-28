import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_device_info_entity.dart';

ResDeviceInfoEntity $ResDeviceInfoEntityFromJson(Map<String, dynamic> json) {
  final ResDeviceInfoEntity resDeviceInfoEntity = ResDeviceInfoEntity();
  final ResDeviceInfoDeviceInfo? deviceInfo = jsonConvert.convert<
      ResDeviceInfoDeviceInfo>(json['device_info']);
  if (deviceInfo != null) {
    resDeviceInfoEntity.deviceInfo = deviceInfo;
  }
  return resDeviceInfoEntity;
}

Map<String, dynamic> $ResDeviceInfoEntityToJson(ResDeviceInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['device_info'] = entity.deviceInfo?.toJson();
  return data;
}

extension ResDeviceInfoEntityExtension on ResDeviceInfoEntity {
  ResDeviceInfoEntity copyWith({
    ResDeviceInfoDeviceInfo? deviceInfo,
  }) {
    return ResDeviceInfoEntity()
      ..deviceInfo = deviceInfo ?? this.deviceInfo;
  }
}

ResDeviceInfoDeviceInfo $ResDeviceInfoDeviceInfoFromJson(
    Map<String, dynamic> json) {
  final ResDeviceInfoDeviceInfo resDeviceInfoDeviceInfo = ResDeviceInfoDeviceInfo();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    resDeviceInfoDeviceInfo.name = name;
  }
  final String? imei = jsonConvert.convert<String>(json['imei']);
  if (imei != null) {
    resDeviceInfoDeviceInfo.imei = imei;
  }
  final String? spotLongitude = jsonConvert.convert<String>(
      json['spot_longitude']);
  if (spotLongitude != null) {
    resDeviceInfoDeviceInfo.spotLongitude = spotLongitude;
  }
  final String? spotLatitude = jsonConvert.convert<String>(
      json['spot_latitude']);
  if (spotLatitude != null) {
    resDeviceInfoDeviceInfo.spotLatitude = spotLatitude;
  }
  final String? spotAddress = jsonConvert.convert<String>(json['spot_address']);
  if (spotAddress != null) {
    resDeviceInfoDeviceInfo.spotAddress = spotAddress;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    resDeviceInfoDeviceInfo.duration = duration;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    resDeviceInfoDeviceInfo.distance = distance;
  }
  return resDeviceInfoDeviceInfo;
}

Map<String, dynamic> $ResDeviceInfoDeviceInfoToJson(
    ResDeviceInfoDeviceInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['imei'] = entity.imei;
  data['spot_longitude'] = entity.spotLongitude;
  data['spot_latitude'] = entity.spotLatitude;
  data['spot_address'] = entity.spotAddress;
  data['duration'] = entity.duration;
  data['distance'] = entity.distance;
  return data;
}

extension ResDeviceInfoDeviceInfoExtension on ResDeviceInfoDeviceInfo {
  ResDeviceInfoDeviceInfo copyWith({
    String? name,
    String? imei,
    String? spotLongitude,
    String? spotLatitude,
    String? spotAddress,
    int? duration,
    double? distance,
  }) {
    return ResDeviceInfoDeviceInfo()
      ..name = name ?? this.name
      ..imei = imei ?? this.imei
      ..spotLongitude = spotLongitude ?? this.spotLongitude
      ..spotLatitude = spotLatitude ?? this.spotLatitude
      ..spotAddress = spotAddress ?? this.spotAddress
      ..duration = duration ?? this.duration
      ..distance = distance ?? this.distance;
  }
}