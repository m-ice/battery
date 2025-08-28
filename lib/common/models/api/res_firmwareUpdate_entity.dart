import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_firmwareUpdate_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_firmwareUpdate_entity.g.dart';

@JsonSerializable()
class ResFirmwareUpdateEntity {
	ResFirmwareUpdateInfo? info;

	ResFirmwareUpdateEntity();

	factory ResFirmwareUpdateEntity.fromJson(Map<String, dynamic> json) => $ResFirmwareUpdateEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResFirmwareUpdateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResFirmwareUpdateInfo {
	String? newversion = '';
	String? url = '';

	ResFirmwareUpdateInfo();

	factory ResFirmwareUpdateInfo.fromJson(Map<String, dynamic> json) => $ResFirmwareUpdateInfoFromJson(json);

	Map<String, dynamic> toJson() => $ResFirmwareUpdateInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}