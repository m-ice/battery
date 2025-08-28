import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_trajectoryLists_entity.dart';

ResTrajectoryListsEntity $ResTrajectoryListsEntityFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsEntity resTrajectoryListsEntity = ResTrajectoryListsEntity();
  final ResTrajectoryListsPageinfo? pageinfo = jsonConvert.convert<
      ResTrajectoryListsPageinfo>(json['pageinfo']);
  if (pageinfo != null) {
    resTrajectoryListsEntity.pageinfo = pageinfo;
  }
  final List<ResTrajectoryListsList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ResTrajectoryListsList>(e) as ResTrajectoryListsList)
      .toList();
  if (list != null) {
    resTrajectoryListsEntity.list = list;
  }
  final ResTrajectoryListsInfo? info = jsonConvert.convert<
      ResTrajectoryListsInfo>(json['info']);
  if (info != null) {
    resTrajectoryListsEntity.info = info;
  }
  return resTrajectoryListsEntity;
}

Map<String, dynamic> $ResTrajectoryListsEntityToJson(
    ResTrajectoryListsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pageinfo'] = entity.pageinfo?.toJson();
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  data['info'] = entity.info?.toJson();
  return data;
}

extension ResTrajectoryListsEntityExtension on ResTrajectoryListsEntity {
  ResTrajectoryListsEntity copyWith({
    ResTrajectoryListsPageinfo? pageinfo,
    List<ResTrajectoryListsList>? list,
    ResTrajectoryListsInfo? info,
  }) {
    return ResTrajectoryListsEntity()
      ..pageinfo = pageinfo ?? this.pageinfo
      ..list = list ?? this.list
      ..info = info ?? this.info;
  }
}

ResTrajectoryListsPageinfo $ResTrajectoryListsPageinfoFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsPageinfo resTrajectoryListsPageinfo = ResTrajectoryListsPageinfo();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    resTrajectoryListsPageinfo.total = total;
  }
  final String? perPage = jsonConvert.convert<String>(json['per_page']);
  if (perPage != null) {
    resTrajectoryListsPageinfo.perPage = perPage;
  }
  final int? currentPage = jsonConvert.convert<int>(json['current_page']);
  if (currentPage != null) {
    resTrajectoryListsPageinfo.currentPage = currentPage;
  }
  final int? lastPage = jsonConvert.convert<int>(json['last_page']);
  if (lastPage != null) {
    resTrajectoryListsPageinfo.lastPage = lastPage;
  }
  return resTrajectoryListsPageinfo;
}

Map<String, dynamic> $ResTrajectoryListsPageinfoToJson(
    ResTrajectoryListsPageinfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['per_page'] = entity.perPage;
  data['current_page'] = entity.currentPage;
  data['last_page'] = entity.lastPage;
  return data;
}

extension ResTrajectoryListsPageinfoExtension on ResTrajectoryListsPageinfo {
  ResTrajectoryListsPageinfo copyWith({
    int? total,
    String? perPage,
    int? currentPage,
    int? lastPage,
  }) {
    return ResTrajectoryListsPageinfo()
      ..total = total ?? this.total
      ..perPage = perPage ?? this.perPage
      ..currentPage = currentPage ?? this.currentPage
      ..lastPage = lastPage ?? this.lastPage;
  }
}

ResTrajectoryListsList $ResTrajectoryListsListFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsList resTrajectoryListsList = ResTrajectoryListsList();
  final ResTrajectoryListsListStartLocation? startLocation = jsonConvert
      .convert<ResTrajectoryListsListStartLocation>(json['start_location']);
  if (startLocation != null) {
    resTrajectoryListsList.startLocation = startLocation;
  }
  final ResTrajectoryListsListEndLocation? endLocation = jsonConvert.convert<
      ResTrajectoryListsListEndLocation>(json['end_location']);
  if (endLocation != null) {
    resTrajectoryListsList.endLocation = endLocation;
  }
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    resTrajectoryListsList.distance = distance;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    resTrajectoryListsList.duration = duration;
  }
  final int? avgSpeed = jsonConvert.convert<int>(json['avg_speed']);
  if (avgSpeed != null) {
    resTrajectoryListsList.avgSpeed = avgSpeed;
  }
  final int? groupId = jsonConvert.convert<int>(json['group_id']);
  if (groupId != null) {
    resTrajectoryListsList.groupId = groupId;
  }
  return resTrajectoryListsList;
}

Map<String, dynamic> $ResTrajectoryListsListToJson(
    ResTrajectoryListsList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['start_location'] = entity.startLocation?.toJson();
  data['end_location'] = entity.endLocation?.toJson();
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  data['avg_speed'] = entity.avgSpeed;
  data['group_id'] = entity.groupId;
  return data;
}

extension ResTrajectoryListsListExtension on ResTrajectoryListsList {
  ResTrajectoryListsList copyWith({
    ResTrajectoryListsListStartLocation? startLocation,
    ResTrajectoryListsListEndLocation? endLocation,
    double? distance,
    String? duration,
    int? avgSpeed,
    int? groupId,
  }) {
    return ResTrajectoryListsList()
      ..startLocation = startLocation ?? this.startLocation
      ..endLocation = endLocation ?? this.endLocation
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration
      ..avgSpeed = avgSpeed ?? this.avgSpeed
      ..groupId = groupId ?? this.groupId;
  }
}

ResTrajectoryListsListStartLocation $ResTrajectoryListsListStartLocationFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsListStartLocation resTrajectoryListsListStartLocation = ResTrajectoryListsListStartLocation();
  final String? createtime = jsonConvert.convert<String>(json['createtime']);
  if (createtime != null) {
    resTrajectoryListsListStartLocation.createtime = createtime;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    resTrajectoryListsListStartLocation.time = time;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resTrajectoryListsListStartLocation.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resTrajectoryListsListStartLocation.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    resTrajectoryListsListStartLocation.address = address;
  }
  return resTrajectoryListsListStartLocation;
}

Map<String, dynamic> $ResTrajectoryListsListStartLocationToJson(
    ResTrajectoryListsListStartLocation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createtime'] = entity.createtime;
  data['time'] = entity.time;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  return data;
}

extension ResTrajectoryListsListStartLocationExtension on ResTrajectoryListsListStartLocation {
  ResTrajectoryListsListStartLocation copyWith({
    String? createtime,
    String? time,
    String? longitude,
    String? latitude,
    String? address,
  }) {
    return ResTrajectoryListsListStartLocation()
      ..createtime = createtime ?? this.createtime
      ..time = time ?? this.time
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address;
  }
}

ResTrajectoryListsListEndLocation $ResTrajectoryListsListEndLocationFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsListEndLocation resTrajectoryListsListEndLocation = ResTrajectoryListsListEndLocation();
  final String? createtime = jsonConvert.convert<String>(json['createtime']);
  if (createtime != null) {
    resTrajectoryListsListEndLocation.createtime = createtime;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    resTrajectoryListsListEndLocation.time = time;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resTrajectoryListsListEndLocation.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resTrajectoryListsListEndLocation.latitude = latitude;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    resTrajectoryListsListEndLocation.address = address;
  }
  return resTrajectoryListsListEndLocation;
}

Map<String, dynamic> $ResTrajectoryListsListEndLocationToJson(
    ResTrajectoryListsListEndLocation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createtime'] = entity.createtime;
  data['time'] = entity.time;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  return data;
}

extension ResTrajectoryListsListEndLocationExtension on ResTrajectoryListsListEndLocation {
  ResTrajectoryListsListEndLocation copyWith({
    String? createtime,
    String? time,
    String? longitude,
    String? latitude,
    String? address,
  }) {
    return ResTrajectoryListsListEndLocation()
      ..createtime = createtime ?? this.createtime
      ..time = time ?? this.time
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address;
  }
}

ResTrajectoryListsInfo $ResTrajectoryListsInfoFromJson(
    Map<String, dynamic> json) {
  final ResTrajectoryListsInfo resTrajectoryListsInfo = ResTrajectoryListsInfo();
  final double? distance = jsonConvert.convert<double>(json['distance']);
  if (distance != null) {
    resTrajectoryListsInfo.distance = distance;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    resTrajectoryListsInfo.duration = duration;
  }
  final int? day = jsonConvert.convert<int>(json['day']);
  if (day != null) {
    resTrajectoryListsInfo.day = day;
  }
  return resTrajectoryListsInfo;
}

Map<String, dynamic> $ResTrajectoryListsInfoToJson(
    ResTrajectoryListsInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  data['day'] = entity.day;
  return data;
}

extension ResTrajectoryListsInfoExtension on ResTrajectoryListsInfo {
  ResTrajectoryListsInfo copyWith({
    double? distance,
    String? duration,
    int? day,
  }) {
    return ResTrajectoryListsInfo()
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration
      ..day = day ?? this.day;
  }
}