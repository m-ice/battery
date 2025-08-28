import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/req_agreement_entity.dart';

ReqAgreementEntity $ReqAgreementEntityFromJson(Map<String, dynamic> json) {
  final ReqAgreementEntity reqAgreementEntity = ReqAgreementEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    reqAgreementEntity.id = id;
  }
  final int? adminId = jsonConvert.convert<int>(json['admin_id']);
  if (adminId != null) {
    reqAgreementEntity.adminId = adminId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    reqAgreementEntity.name = name;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    reqAgreementEntity.content = content;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    reqAgreementEntity.type = type;
  }
  final int? languageId = jsonConvert.convert<int>(json['language_id']);
  if (languageId != null) {
    reqAgreementEntity.languageId = languageId;
  }
  return reqAgreementEntity;
}

Map<String, dynamic> $ReqAgreementEntityToJson(ReqAgreementEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['admin_id'] = entity.adminId;
  data['name'] = entity.name;
  data['content'] = entity.content;
  data['type'] = entity.type;
  data['language_id'] = entity.languageId;
  return data;
}

extension ReqAgreementEntityExtension on ReqAgreementEntity {
  ReqAgreementEntity copyWith({
    int? id,
    int? adminId,
    String? name,
    String? content,
    String? type,
    int? languageId,
  }) {
    return ReqAgreementEntity()
      ..id = id ?? this.id
      ..adminId = adminId ?? this.adminId
      ..name = name ?? this.name
      ..content = content ?? this.content
      ..type = type ?? this.type
      ..languageId = languageId ?? this.languageId;
  }
}