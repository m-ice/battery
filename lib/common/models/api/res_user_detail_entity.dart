import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_user_detail_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_user_detail_entity.g.dart';

@JsonSerializable()
class ResUserDetailEntity {
	ResUserDetailsUserinfo? userinfo;

	ResUserDetailEntity();

	factory ResUserDetailEntity.fromJson(Map<String, dynamic> json) => $ResUserDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResUserDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResUserDetailsUserinfo {
	int? id = 0;
	@JSONField(name: 'group_id')
	int? groupId = 0;
	String? username = '';
	String? nickname = '';
	String? password = '';
	String? salt = '';
	String? email = '';
	String? mobile = '';
	String? avatar = '';
	int? level = 0;
	int? gender = 0;
	dynamic birthday;
	String? bio = '';
	String? money = '';
	int? score = 0;
	int? successions = 0;
	int? maxsuccessions = 0;
	int? prevtime = 0;
	int? logintime = 0;
	String? loginip = '';
	int? loginfailure = 0;
	String? joinip = '';
	dynamic jointime;
	int? createtime = 0;
	int? updatetime = 0;
	String? token = '';
	String? status = '';
	ResUserDetailsUserinfoVerification? verification;
	dynamic realpwd;
	@JSONField(name: 'zalo_id')
	String? zaloId = '';
	@JSONField(name: 'total_distance')
	int? totalDistance = 0;
	@JSONField(name: 'spot_longitude')
	String? spotLongitude = '';
	@JSONField(name: 'spot_latitude')
	String? spotLatitude = '';
	@JSONField(name: 'spot_address')
	String? spotAddress = '';
	@JSONField(name: 'total_duration')
	int? totalDuration = 0;
	String? latitude = '';
	dynamic address;
	String? longitude = '';
	String? url = '';

	ResUserDetailsUserinfo();

	factory ResUserDetailsUserinfo.fromJson(Map<String, dynamic> json) => $ResUserDetailsUserinfoFromJson(json);

	Map<String, dynamic> toJson() => $ResUserDetailsUserinfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ResUserDetailsUserinfoVerification {
	int? email = 0;
	int? mobile = 0;

	ResUserDetailsUserinfoVerification();

	factory ResUserDetailsUserinfoVerification.fromJson(Map<String, dynamic> json) => $ResUserDetailsUserinfoVerificationFromJson(json);

	Map<String, dynamic> toJson() => $ResUserDetailsUserinfoVerificationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}