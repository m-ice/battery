import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_trajectoryLists_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_trajectoryLists_entity.g.dart';

@JsonSerializable()
class ResTrajectoryListsEntity {
	ResTrajectoryListsPageinfo? pageinfo;
	List<ResTrajectoryListsList>? list = [];
	ResTrajectoryListsInfo? info;

	ResTrajectoryListsEntity();

	factory ResTrajectoryListsEntity.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryListsPageinfo {
	int? total = 0;
	@JSONField(name: 'per_page')
	String? perPage = '';
	@JSONField(name: 'current_page')
	int? currentPage = 0;
	@JSONField(name: 'last_page')
	int? lastPage = 0;

	ResTrajectoryListsPageinfo();

	factory ResTrajectoryListsPageinfo.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsPageinfoFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsPageinfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryListsList {
	@JSONField(name: 'start_location')
	ResTrajectoryListsListStartLocation? startLocation;
	@JSONField(name: 'end_location')
	ResTrajectoryListsListEndLocation? endLocation;
	double? distance;
	String? duration = '';
	@JSONField(name: 'avg_speed')
	int? avgSpeed = 0;
	@JSONField(name: 'group_id')
	int? groupId = 0;

	ResTrajectoryListsList();

	factory ResTrajectoryListsList.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsListFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryListsListStartLocation {
	String? createtime = '';
	String? time = '';
	String? longitude = '';
	String? latitude = '';
	String? address = '';

	ResTrajectoryListsListStartLocation();

	factory ResTrajectoryListsListStartLocation.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsListStartLocationFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsListStartLocationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryListsListEndLocation {
	String? createtime = '';
	String? time = '';
	String? longitude = '';
	String? latitude = '';
	String? address = '';

	ResTrajectoryListsListEndLocation();

	factory ResTrajectoryListsListEndLocation.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsListEndLocationFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsListEndLocationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResTrajectoryListsInfo {
	double? distance;
	String? duration = '';
	int? day = 0;

	ResTrajectoryListsInfo();

	factory ResTrajectoryListsInfo.fromJson(Map<String, dynamic> json) => $ResTrajectoryListsInfoFromJson(json);

	Map<String, dynamic> toJson() => $ResTrajectoryListsInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}