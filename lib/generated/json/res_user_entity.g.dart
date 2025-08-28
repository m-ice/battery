import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_user_entity.dart';

ResUserEntity $ResUserEntityFromJson(Map<String, dynamic> json) {
  final ResUserEntity resUserEntity = ResUserEntity();
  final ResUserUserinfo? userinfo = jsonConvert.convert<ResUserUserinfo>(
      json['userinfo']);
  if (userinfo != null) {
    resUserEntity.userinfo = userinfo;
  }
  return resUserEntity;
}

Map<String, dynamic> $ResUserEntityToJson(ResUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userinfo'] = entity.userinfo.toJson();
  return data;
}

extension ResUserEntityExtension on ResUserEntity {
  ResUserEntity copyWith({
    ResUserUserinfo? userinfo,
  }) {
    return ResUserEntity()
      ..userinfo = userinfo ?? this.userinfo;
  }
}

ResUserUserinfo $ResUserUserinfoFromJson(Map<String, dynamic> json) {
  final ResUserUserinfo resUserUserinfo = ResUserUserinfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    resUserUserinfo.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    resUserUserinfo.username = username;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    resUserUserinfo.nickname = nickname;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    resUserUserinfo.mobile = mobile;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    resUserUserinfo.avatar = avatar;
  }
  final int? score = jsonConvert.convert<int>(json['score']);
  if (score != null) {
    resUserUserinfo.score = score;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    resUserUserinfo.token = token;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    resUserUserinfo.userId = userId;
  }
  final int? totalDistance = jsonConvert.convert<int>(json['total_distance']);
  if (totalDistance != null) {
    resUserUserinfo.totalDistance = totalDistance;
  }
  final int? spotLongitude = jsonConvert.convert<int>(json['spot_longitude']);
  if (spotLongitude != null) {
    resUserUserinfo.spotLongitude = spotLongitude;
  }
  final int? spotLatitude = jsonConvert.convert<int>(json['spot_latitude']);
  if (spotLatitude != null) {
    resUserUserinfo.spotLatitude = spotLatitude;
  }
  final int? spotAddress = jsonConvert.convert<int>(json['spot_address']);
  if (spotAddress != null) {
    resUserUserinfo.spotAddress = spotAddress;
  }
  final int? totalDuration = jsonConvert.convert<int>(json['total_duration']);
  if (totalDuration != null) {
    resUserUserinfo.totalDuration = totalDuration;
  }
  final int? createtime = jsonConvert.convert<int>(json['createtime']);
  if (createtime != null) {
    resUserUserinfo.createtime = createtime;
  }
  final int? expiretime = jsonConvert.convert<int>(json['expiretime']);
  if (expiretime != null) {
    resUserUserinfo.expiretime = expiretime;
  }
  final int? expiresIn = jsonConvert.convert<int>(json['expires_in']);
  if (expiresIn != null) {
    resUserUserinfo.expiresIn = expiresIn;
  }
  return resUserUserinfo;
}

Map<String, dynamic> $ResUserUserinfoToJson(ResUserUserinfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['nickname'] = entity.nickname;
  data['mobile'] = entity.mobile;
  data['avatar'] = entity.avatar;
  data['score'] = entity.score;
  data['token'] = entity.token;
  data['user_id'] = entity.userId;
  data['total_distance'] = entity.totalDistance;
  data['spot_longitude'] = entity.spotLongitude;
  data['spot_latitude'] = entity.spotLatitude;
  data['spot_address'] = entity.spotAddress;
  data['total_duration'] = entity.totalDuration;
  data['createtime'] = entity.createtime;
  data['expiretime'] = entity.expiretime;
  data['expires_in'] = entity.expiresIn;
  return data;
}

extension ResUserUserinfoExtension on ResUserUserinfo {
  ResUserUserinfo copyWith({
    int? id,
    String? username,
    String? nickname,
    String? mobile,
    String? avatar,
    int? score,
    String? token,
    int? userId,
    int? totalDistance,
    int? spotLongitude,
    int? spotLatitude,
    int? spotAddress,
    int? totalDuration,
    int? createtime,
    int? expiretime,
    int? expiresIn,
  }) {
    return ResUserUserinfo()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..nickname = nickname ?? this.nickname
      ..mobile = mobile ?? this.mobile
      ..avatar = avatar ?? this.avatar
      ..score = score ?? this.score
      ..token = token ?? this.token
      ..userId = userId ?? this.userId
      ..totalDistance = totalDistance ?? this.totalDistance
      ..spotLongitude = spotLongitude ?? this.spotLongitude
      ..spotLatitude = spotLatitude ?? this.spotLatitude
      ..spotAddress = spotAddress ?? this.spotAddress
      ..totalDuration = totalDuration ?? this.totalDuration
      ..createtime = createtime ?? this.createtime
      ..expiretime = expiretime ?? this.expiretime
      ..expiresIn = expiresIn ?? this.expiresIn;
  }
}