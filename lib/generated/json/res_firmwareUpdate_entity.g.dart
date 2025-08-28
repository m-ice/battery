import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_firmwareUpdate_entity.dart';

ResFirmwareUpdateEntity $ResFirmwareUpdateEntityFromJson(
    Map<String, dynamic> json) {
  final ResFirmwareUpdateEntity resFirmwareUpdateEntity = ResFirmwareUpdateEntity();
  final ResFirmwareUpdateInfo? info = jsonConvert.convert<
      ResFirmwareUpdateInfo>(json['info']);
  if (info != null) {
    resFirmwareUpdateEntity.info = info;
  }
  return resFirmwareUpdateEntity;
}

Map<String, dynamic> $ResFirmwareUpdateEntityToJson(
    ResFirmwareUpdateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info?.toJson();
  return data;
}

extension ResFirmwareUpdateEntityExtension on ResFirmwareUpdateEntity {
  ResFirmwareUpdateEntity copyWith({
    ResFirmwareUpdateInfo? info,
  }) {
    return ResFirmwareUpdateEntity()
      ..info = info ?? this.info;
  }
}

ResFirmwareUpdateInfo $ResFirmwareUpdateInfoFromJson(
    Map<String, dynamic> json) {
  final ResFirmwareUpdateInfo resFirmwareUpdateInfo = ResFirmwareUpdateInfo();
  final String? newversion = jsonConvert.convert<String>(json['newversion']);
  if (newversion != null) {
    resFirmwareUpdateInfo.newversion = newversion;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    resFirmwareUpdateInfo.url = url;
  }
  return resFirmwareUpdateInfo;
}

Map<String, dynamic> $ResFirmwareUpdateInfoToJson(
    ResFirmwareUpdateInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['newversion'] = entity.newversion;
  data['url'] = entity.url;
  return data;
}

extension ResFirmwareUpdateInfoExtension on ResFirmwareUpdateInfo {
  ResFirmwareUpdateInfo copyWith({
    String? newversion,
    String? url,
  }) {
    return ResFirmwareUpdateInfo()
      ..newversion = newversion ?? this.newversion
      ..url = url ?? this.url;
  }
}