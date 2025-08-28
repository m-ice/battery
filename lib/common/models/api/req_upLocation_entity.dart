import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/req_upLocation_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/req_upLocation_entity.g.dart';

@JsonSerializable()
class ReqUpLocationEntity {
	@JSONField(name: 'device_id')
	String? deviceId = '';
	String? longitude = '';
	String? latitude = '';
	String? address = '';
	@JSONField(name: 'is_start')
	String? isStart = '';
	String? distance = '';
	String? duration = '';

	ReqUpLocationEntity();

	factory ReqUpLocationEntity.fromJson(Map<String, dynamic> json) => $ReqUpLocationEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReqUpLocationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}