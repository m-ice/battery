import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_device_list_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_device_list_entity.g.dart';

@JsonSerializable()
class ResDeviceListEntity {
	@JSONField(name: 'device_list')
	List<ResDeviceListDeviceList>? deviceList = [];

	ResDeviceListEntity();

	factory ResDeviceListEntity.fromJson(Map<String, dynamic> json) => $ResDeviceListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResDeviceListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResDeviceListDeviceList {
	String? name = '';
	String? imei = '';
	int? id = 0;
	@JSONField(name: 'user_id')
	int? userId = 0;

	ResDeviceListDeviceList();

	factory ResDeviceListDeviceList.fromJson(Map<String, dynamic> json) => $ResDeviceListDeviceListFromJson(json);

	Map<String, dynamic> toJson() => $ResDeviceListDeviceListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}