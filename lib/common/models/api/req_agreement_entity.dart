import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/req_agreement_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/req_agreement_entity.g.dart';

@JsonSerializable()
class ReqAgreementEntity {
	int id = 0;
	@JSONField(name: 'admin_id')
	int adminId = 0;
	String name = '';
	String content = '';
	String type = '';
	@JSONField(name: 'language_id')
	int languageId = 0;

	ReqAgreementEntity();

	factory ReqAgreementEntity.fromJson(Map<String, dynamic> json) => $ReqAgreementEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReqAgreementEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}