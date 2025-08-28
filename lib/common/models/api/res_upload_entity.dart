import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_upload_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_upload_entity.g.dart';

@JsonSerializable()
class ResUploadEntity {
	String url = '';
	String fullurl = '';

	ResUploadEntity();

	factory ResUploadEntity.fromJson(Map<String, dynamic> json) => $ResUploadEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResUploadEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}