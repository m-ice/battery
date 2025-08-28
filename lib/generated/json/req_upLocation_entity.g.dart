import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/req_upLocation_entity.dart';

ReqUpLocationEntity $ReqUpLocationEntityFromJson(Map<String, dynamic> json) {
  final ReqUpLocationEntity reqUpLocationEntity = ReqUpLocationEntity();
  final String? deviceId = jsonConvert.convert<String>(json['device_id']);
  if (deviceId != null) {
    reqUpLocationEntity.deviceId = deviceId;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    reqUpLocationEntity.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    reqUpLocationEntity.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    reqUpLocationEntity.address = address;
  }
  final String? isStart = jsonConvert.convert<String>(json['is_start']);
  if (isStart != null) {
    reqUpLocationEntity.isStart = isStart;
  }
  final String? distance = jsonConvert.convert<String>(json['distance']);
  if (distance != null) {
    reqUpLocationEntity.distance = distance;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    reqUpLocationEntity.duration = duration;
  }
  return reqUpLocationEntity;
}

Map<String, dynamic> $ReqUpLocationEntityToJson(ReqUpLocationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['device_id'] = entity.deviceId;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  data['is_start'] = entity.isStart;
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  return data;
}

extension ReqUpLocationEntityExtension on ReqUpLocationEntity {
  ReqUpLocationEntity copyWith({
    String? deviceId,
    String? longitude,
    String? latitude,
    String? address,
    String? isStart,
    String? distance,
    String? duration,
  }) {
    return ReqUpLocationEntity()
      ..deviceId = deviceId ?? this.deviceId
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address
      ..isStart = isStart ?? this.isStart
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration;
  }
}