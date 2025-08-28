import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/res_user_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/res_user_entity.g.dart';

@JsonSerializable()
class ResUserEntity {
  late ResUserUserinfo userinfo;

  ResUserEntity();

  factory ResUserEntity.fromJson(Map<String, dynamic> json) =>
      $ResUserEntityFromJson(json);

  Map<String, dynamic> toJson() => $ResUserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ResUserUserinfo {
  int id = 0;
  String username = '';
  String nickname = '';
  String mobile = '';
  String avatar = '';
  int score = 0;
  String token = '';
  @JSONField(name: 'user_id')
  int userId = 0;
  @JSONField(name: 'total_distance')
  int totalDistance = 0;
  @JSONField(name: 'spot_longitude')
  int spotLongitude = 0;
  @JSONField(name: 'spot_latitude')
  int spotLatitude = 0;
  @JSONField(name: 'spot_address')
  int spotAddress = 0;
  @JSONField(name: 'total_duration')
  int totalDuration = 0;
  int createtime = 0;
  int expiretime = 0;
  @JSONField(name: 'expires_in')
  int expiresIn = 0;

  ResUserUserinfo();

  factory ResUserUserinfo.fromJson(Map<String, dynamic> json) =>
      $ResUserUserinfoFromJson(json);

  Map<String, dynamic> toJson() => $ResUserUserinfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
