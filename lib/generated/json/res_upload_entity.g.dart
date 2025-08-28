import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_upload_entity.dart';

ResUploadEntity $ResUploadEntityFromJson(Map<String, dynamic> json) {
  final ResUploadEntity resUploadEntity = ResUploadEntity();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    resUploadEntity.url = url;
  }
  final String? fullurl = jsonConvert.convert<String>(json['fullurl']);
  if (fullurl != null) {
    resUploadEntity.fullurl = fullurl;
  }
  return resUploadEntity;
}

Map<String, dynamic> $ResUploadEntityToJson(ResUploadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['fullurl'] = entity.fullurl;
  return data;
}

extension ResUploadEntityExtension on ResUploadEntity {
  ResUploadEntity copyWith({
    String? url,
    String? fullurl,
  }) {
    return ResUploadEntity()
      ..url = url ?? this.url
      ..fullurl = fullurl ?? this.fullurl;
  }
}