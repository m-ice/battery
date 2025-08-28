import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_locationAreaList_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_locationAreaList_entity.g.dart';

@JsonSerializable()
class ResLocationAreaListEntity {
	List<ResLocationAreaListList>? list = [];

	ResLocationAreaListEntity();

	factory ResLocationAreaListEntity.fromJson(Map<String, dynamic> json) => $ResLocationAreaListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResLocationAreaListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResLocationAreaListList {
	int? id = 0;
	@JSONField(name: 'device_id')
	int? deviceId = 0;
	@JSONField(name: 'area_id')
	String? areaId = '';
	int? createtime = 0;
	@JSONField(name: 'area_name')
	String? areaName = '';
	@JSONField(name: 'user_id')
	int? userId = 0;

	ResLocationAreaListList();

	factory ResLocationAreaListList.fromJson(Map<String, dynamic> json) => $ResLocationAreaListListFromJson(json);

	Map<String, dynamic> toJson() => $ResLocationAreaListListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}