import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_locationAreaList_entity.dart';

ResLocationAreaListEntity $ResLocationAreaListEntityFromJson(
    Map<String, dynamic> json) {
  final ResLocationAreaListEntity resLocationAreaListEntity = ResLocationAreaListEntity();
  final List<ResLocationAreaListList>? list = (json['list'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ResLocationAreaListList>(
          e) as ResLocationAreaListList)
      .toList();
  if (list != null) {
    resLocationAreaListEntity.list = list;
  }
  return resLocationAreaListEntity;
}

Map<String, dynamic> $ResLocationAreaListEntityToJson(
    ResLocationAreaListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['list'] = entity.list?.map((v) => v.toJson()).toList();
  return data;
}

extension ResLocationAreaListEntityExtension on ResLocationAreaListEntity {
  ResLocationAreaListEntity copyWith({
    List<ResLocationAreaListList>? list,
  }) {
    return ResLocationAreaListEntity()
      ..list = list ?? this.list;
  }
}

ResLocationAreaListList $ResLocationAreaListListFromJson(
    Map<String, dynamic> json) {
  final ResLocationAreaListList resLocationAreaListList = ResLocationAreaListList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    resLocationAreaListList.id = id;
  }
  final int? deviceId = jsonConvert.convert<int>(json['device_id']);
  if (deviceId != null) {
    resLocationAreaListList.deviceId = deviceId;
  }
  final String? areaId = jsonConvert.convert<String>(json['area_id']);
  if (areaId != null) {
    resLocationAreaListList.areaId = areaId;
  }
  final int? createtime = jsonConvert.convert<int>(json['createtime']);
  if (createtime != null) {
    resLocationAreaListList.createtime = createtime;
  }
  final String? areaName = jsonConvert.convert<String>(json['area_name']);
  if (areaName != null) {
    resLocationAreaListList.areaName = areaName;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    resLocationAreaListList.userId = userId;
  }
  return resLocationAreaListList;
}

Map<String, dynamic> $ResLocationAreaListListToJson(
    ResLocationAreaListList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['device_id'] = entity.deviceId;
  data['area_id'] = entity.areaId;
  data['createtime'] = entity.createtime;
  data['area_name'] = entity.areaName;
  data['user_id'] = entity.userId;
  return data;
}

extension ResLocationAreaListListExtension on ResLocationAreaListList {
  ResLocationAreaListList copyWith({
    int? id,
    int? deviceId,
    String? areaId,
    int? createtime,
    String? areaName,
    int? userId,
  }) {
    return ResLocationAreaListList()
      ..id = id ?? this.id
      ..deviceId = deviceId ?? this.deviceId
      ..areaId = areaId ?? this.areaId
      ..createtime = createtime ?? this.createtime
      ..areaName = areaName ?? this.areaName
      ..userId = userId ?? this.userId;
  }
}