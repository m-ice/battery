import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_trajectoryInfo_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_trajectoryInfo_entity.g.dart';

@JsonSerializable()
class ResTrajectoryInfoEntity {
	List<ResTrajectoryInfoList>? list = [];
	ResTrajectoryInfoInfo? info;

	ResTrajectoryInfoEntity();

	factory ResTrajectoryInfoEntity.fromJson(Map<String, dynamic> json) => $ResTrajectoryInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryInfoList {
	int? id = 0;
	@JSONField(name: 'device_id')
	int? deviceId = 0;
	String? longitude = '';
	String? latitude = '';
	String? address = '';
	@JSONField(name: 'is_start')
	int? isStart = 0;
	double? distance;
	int? duration = 0;
	@JSONField(name: 'group_id')
	int? groupId = 0;
	int? createtime = 0;

	ResTrajectoryInfoList();

	factory ResTrajectoryInfoList.fromJson(Map<String, dynamic> json) => $ResTrajectoryInfoListFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryInfoListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryInfoInfo {
	@JSONField(name: 'start_location')
	ResTrajectoryInfoInfoStartLocation? startLocation;
	@JSONField(name: 'end_location')
	ResTrajectoryInfoInfoEndLocation? endLocation;
	double? distance;
	String? duration = '';
	@JSONField(name: 'avg_speed')
	int? avgSpeed = 0;
	@JSONField(name: 'group_id')
	String? groupId = '';

	ResTrajectoryInfoInfo();

	factory ResTrajectoryInfoInfo.fromJson(Map<String, dynamic> json) => $ResTrajectoryInfoInfoFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryInfoInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryInfoInfoStartLocation {
	String? createtime = '';
	String? time = '';
	String? longitude = '';
	String? latitude = '';
	String? address = '';

	ResTrajectoryInfoInfoStartLocation();

	factory ResTrajectoryInfoInfoStartLocation.fromJson(Map<String, dynamic> json) => $ResTrajectoryInfoInfoStartLocationFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryInfoInfoStartLocationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryInfoInfoEndLocation {
	String? createtime = '';
	String? time = '';
	String? longitude = '';
	String? latitude = '';
	String? address = '';

	ResTrajectoryInfoInfoEndLocation();

	factory ResTrajectoryInfoInfoEndLocation.fromJson(Map<String, dynamic> json) => $ResTrajectoryInfoInfoEndLocationFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryInfoInfoEndLocationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}