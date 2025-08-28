import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_device_info_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_device_info_entity.g.dart';

@JsonSerializable()
class ResDeviceInfoEntity {
	@JSONField(name: 'device_info')
	ResDeviceInfoDeviceInfo? deviceInfo;

	ResDeviceInfoEntity();

	factory ResDeviceInfoEntity.fromJson(Map<String, dynamic> json) => $ResDeviceInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResDeviceInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResDeviceInfoDeviceInfo {
	String? name = '';
	String? imei = '';
	@JSONField(name: 'spot_longitude')
	String? spotLongitude = '';
	@JSONField(name: 'spot_latitude')
	String? spotLatitude = '';
	@JSONField(name: 'spot_address')
	String? spotAddress = '';
	int? duration = 0;
	double? distance;

	ResDeviceInfoDeviceInfo();

	factory ResDeviceInfoDeviceInfo.fromJson(Map<String, dynamic> json) => $ResDeviceInfoDeviceInfoFromJson(json);

	Map<String, dynamic> toJson() => $ResDeviceInfoDeviceInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}