import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_trajectoryInfo_entity.dart';

ResTrajectoryInfoEntity $ResTrajectoryInfoEntityFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryInfoEntity resTrajectoryInfoEntity = ResTrajectoryInfoEntity();
  final List<ResTrajectoryInfoList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ResTrajectoryInfoList>(e) as ResTrajectoryInfoList)
      .toList();
  if (list != null) {
    resTrajectoryInfoEntity.list = list;
  }
  final ResTrajectoryInfoInfo? info = jsonConvert.convert<
      ResTrajectoryInfoInfo>(json['info']);
  if (info != null) {
    resTrajectoryInfoEntity.info = info;
  }
  return resTrajectoryInfoEntity;
}

Map<String, dynamic> $ResTrajectoryInfoEntityToJson(
    ResTrajectoryInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  data['info'] = entity.info?.toJson();
  return data;
}

extension ResTrajectoryInfoEntityExtension on ResTrajectoryInfoEntity {
  ResTrajectoryInfoEntity copyWith({
    List<ResTrajectoryInfoList>? list,
    ResTrajectoryInfoInfo? info,
  }) {
    return ResTrajectoryInfoEntity()
      ..list = list ?? this.list
      ..info = info ?? this.info;
  }
}

ResTrajectoryInfoList $ResTrajectoryInfoListFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryInfoList resTrajectoryInfoList = ResTrajectoryInfoList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    resTrajectoryInfoList.id = id;
  }
  final int? deviceId = jsonConvert.convert<int>(json['device_id']);
  if (deviceId != null) {
    resTrajectoryInfoList.deviceId = deviceId;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resTrajectoryInfoList.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resTrajectoryInfoList.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    resTrajectoryInfoList.address = address;
  }
  final int? isStart = jsonConvert.convert<int>(json['is_start']);
  if (isStart != null) {
    resTrajectoryInfoList.isStart = isStart;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    resTrajectoryInfoList.distance = distance;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    resTrajectoryInfoList.duration = duration;
  }
  final int? groupId = jsonConvert.convert<int>(json['group_id']);
  if (groupId != null) {
    resTrajectoryInfoList.groupId = groupId;
  }
  final int? createtime = jsonConvert.convert<int>(json['createtime']);
  if (createtime != null) {
    resTrajectoryInfoList.createtime = createtime;
  }
  return resTrajectoryInfoList;
}

Map<String, dynamic> $ResTrajectoryInfoListToJson(
    ResTrajectoryInfoList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['device_id'] = entity.deviceId;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  data['is_start'] = entity.isStart;
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  data['group_id'] = entity.groupId;
  data['createtime'] = entity.createtime;
  return data;
}

extension ResTrajectoryInfoListExtension on ResTrajectoryInfoList {
  ResTrajectoryInfoList copyWith({
    int? id,
    int? deviceId,
    String? longitude,
    String? latitude,
    String? address,
    int? isStart,
    double? distance,
    int? duration,
    int? groupId,
    int? createtime,
  }) {
    return ResTrajectoryInfoList()
      ..id = id ?? this.id
      ..deviceId = deviceId ?? this.deviceId
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address
      ..isStart = isStart ?? this.isStart
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration
      ..groupId = groupId ?? this.groupId
      ..createtime = createtime ?? this.createtime;
  }
}

ResTrajectoryInfoInfo $ResTrajectoryInfoInfoFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryInfoInfo resTrajectoryInfoInfo = ResTrajectoryInfoInfo();
  final ResTrajectoryInfoInfoStartLocation? startLocation = jsonConvert.convert<
      ResTrajectoryInfoInfoStartLocation>(json['start_location']);
  if (startLocation != null) {
    resTrajectoryInfoInfo.startLocation = startLocation;
  }
  final ResTrajectoryInfoInfoEndLocation? endLocation = jsonConvert.convert<
      ResTrajectoryInfoInfoEndLocation>(json['end_location']);
  if (endLocation != null) {
    resTrajectoryInfoInfo.endLocation = endLocation;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    resTrajectoryInfoInfo.distance = distance;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    resTrajectoryInfoInfo.duration = duration;
  }
  final int? avgSpeed = jsonConvert.convert<int>(json['avg_speed']);
  if (avgSpeed != null) {
    resTrajectoryInfoInfo.avgSpeed = avgSpeed;
  }
  final String? groupId = jsonConvert.convert<String>(json['group_id']);
  if (groupId != null) {
    resTrajectoryInfoInfo.groupId = groupId;
  }
  return resTrajectoryInfoInfo;
}

Map<String, dynamic> $ResTrajectoryInfoInfoToJson(
    ResTrajectoryInfoInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['start_location'] = entity.startLocation?.toJson();
  data['end_location'] = entity.endLocation?.toJson();
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  data['avg_speed'] = entity.avgSpeed;
  data['group_id'] = entity.groupId;
  return data;
}

extension ResTrajectoryInfoInfoExtension on ResTrajectoryInfoInfo {
  ResTrajectoryInfoInfo copyWith({
    ResTrajectoryInfoInfoStartLocation? startLocation,
    ResTrajectoryInfoInfoEndLocation? endLocation,
    double? distance,
    String? duration,
    int? avgSpeed,
    String? groupId,
  }) {
    return ResTrajectoryInfoInfo()
      ..startLocation = startLocation ?? this.startLocation
      ..endLocation = endLocation ?? this.endLocation
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration
      ..avgSpeed = avgSpeed ?? this.avgSpeed
      ..groupId = groupId ?? this.groupId;
  }
}

ResTrajectoryInfoInfoStartLocation $ResTrajectoryInfoInfoStartLocationFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryInfoInfoStartLocation resTrajectoryInfoInfoStartLocation = ResTrajectoryInfoInfoStartLocation();
  final String? createtime = jsonConvert.convert<String>(json['createtime']);
  if (createtime != null) {
    resTrajectoryInfoInfoStartLocation.createtime = createtime;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    resTrajectoryInfoInfoStartLocation.time = time;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resTrajectoryInfoInfoStartLocation.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resTrajectoryInfoInfoStartLocation.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    resTrajectoryInfoInfoStartLocation.address = address;
  }
  return resTrajectoryInfoInfoStartLocation;
}

Map<String, dynamic> $ResTrajectoryInfoInfoStartLocationToJson(
    ResTrajectoryInfoInfoStartLocation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createtime'] = entity.createtime;
  data['time'] = entity.time;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  return data;
}

extension ResTrajectoryInfoInfoStartLocationExtension on ResTrajectoryInfoInfoStartLocation {
  ResTrajectoryInfoInfoStartLocation copyWith({
    String? createtime,
    String? time,
    String? longitude,
    String? latitude,
    String? address,
  }) {
    return ResTrajectoryInfoInfoStartLocation()
      ..createtime = createtime ?? this.createtime
      ..time = time ?? this.time
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address;
  }
}

ResTrajectoryInfoInfoEndLocation $ResTrajectoryInfoInfoEndLocationFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryInfoInfoEndLocation resTrajectoryInfoInfoEndLocation = ResTrajectoryInfoInfoEndLocation();
  final String? createtime = jsonConvert.convert<String>(json['createtime']);
  if (createtime != null) {
    resTrajectoryInfoInfoEndLocation.createtime = createtime;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    resTrajectoryInfoInfoEndLocation.time = time;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resTrajectoryInfoInfoEndLocation.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resTrajectoryInfoInfoEndLocation.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    resTrajectoryInfoInfoEndLocation.address = address;
  }
  return resTrajectoryInfoInfoEndLocation;
}

Map<String, dynamic> $ResTrajectoryInfoInfoEndLocationToJson(
    ResTrajectoryInfoInfoEndLocation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createtime'] = entity.createtime;
  data['time'] = entity.time;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  return data;
}

extension ResTrajectoryInfoInfoEndLocationExtension on ResTrajectoryInfoInfoEndLocation {
  ResTrajectoryInfoInfoEndLocation copyWith({
    String? createtime,
    String? time,
    String? longitude,
    String? latitude,
    String? address,
  }) {
    return ResTrajectoryInfoInfoEndLocation()
      ..createtime = createtime ?? this.createtime
      ..time = time ?? this.time
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address;
  }
}