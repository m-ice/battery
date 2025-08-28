import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/res_user_detail_entity.dart';

ResUserDetailEntity $ResUserDetailEntityFromJson(Map<String, dynamic> json) {
  final ResUserDetailEntity resUserDetailEntity = ResUserDetailEntity();
  final ResUserDetailsUserinfo? userinfo = jsonConvert.convert<
      ResUserDetailsUserinfo>(json['userinfo']);
  if (userinfo != null) {
    resUserDetailEntity.userinfo = userinfo;
  }
  return resUserDetailEntity;
}

Map<String, dynamic> $ResUserDetailEntityToJson(ResUserDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userinfo'] = entity.userinfo?.toJson();
  return data;
}

extension ResUserDetailEntityExtension on ResUserDetailEntity {
  ResUserDetailEntity copyWith({
    ResUserDetailsUserinfo? userinfo,
  }) {
    return ResUserDetailEntity()
      ..userinfo = userinfo ?? this.userinfo;
  }
}

ResUserDetailsUserinfo $ResUserDetailsUserinfoFromJson(
    Map<String, dynamic> json) {
  final ResUserDetailsUserinfo resUserDetailsUserinfo = ResUserDetailsUserinfo();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    resUserDetailsUserinfo.id = id;
  }
  final int? groupId = jsonConvert.convert<int>(json['group_id']);
  if (groupId != null) {
    resUserDetailsUserinfo.groupId = groupId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    resUserDetailsUserinfo.username = username;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    resUserDetailsUserinfo.nickname = nickname;
  }
  final String? password = jsonConvert.convert<String>(json['password']);
  if (password != null) {
    resUserDetailsUserinfo.password = password;
  }
  final String? salt = jsonConvert.convert<String>(json['salt']);
  if (salt != null) {
    resUserDetailsUserinfo.salt = salt;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    resUserDetailsUserinfo.email = email;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    resUserDetailsUserinfo.mobile = mobile;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    resUserDetailsUserinfo.avatar = avatar;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    resUserDetailsUserinfo.level = level;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    resUserDetailsUserinfo.gender = gender;
  }
  final dynamic birthday = json['birthday'];
  if (birthday != null) {
    resUserDetailsUserinfo.birthday = birthday;
  }
  final String? bio = jsonConvert.convert<String>(json['bio']);
  if (bio != null) {
    resUserDetailsUserinfo.bio = bio;
  }
  final String? money = jsonConvert.convert<String>(json['money']);
  if (money != null) {
    resUserDetailsUserinfo.money = money;
  }
  final int? score = jsonConvert.convert<int>(json['score']);
  if (score != null) {
    resUserDetailsUserinfo.score = score;
  }
  final int? successions = jsonConvert.convert<int>(json['successions']);
  if (successions != null) {
    resUserDetailsUserinfo.successions = successions;
  }
  final int? maxsuccessions = jsonConvert.convert<int>(json['maxsuccessions']);
  if (maxsuccessions != null) {
    resUserDetailsUserinfo.maxsuccessions = maxsuccessions;
  }
  final int? prevtime = jsonConvert.convert<int>(json['prevtime']);
  if (prevtime != null) {
    resUserDetailsUserinfo.prevtime = prevtime;
  }
  final int? logintime = jsonConvert.convert<int>(json['logintime']);
  if (logintime != null) {
    resUserDetailsUserinfo.logintime = logintime;
  }
  final String? loginip = jsonConvert.convert<String>(json['loginip']);
  if (loginip != null) {
    resUserDetailsUserinfo.loginip = loginip;
  }
  final int? loginfailure = jsonConvert.convert<int>(json['loginfailure']);
  if (loginfailure != null) {
    resUserDetailsUserinfo.loginfailure = loginfailure;
  }
  final String? joinip = jsonConvert.convert<String>(json['joinip']);
  if (joinip != null) {
    resUserDetailsUserinfo.joinip = joinip;
  }
  final dynamic jointime = json['jointime'];
  if (jointime != null) {
    resUserDetailsUserinfo.jointime = jointime;
  }
  final int? createtime = jsonConvert.convert<int>(json['createtime']);
  if (createtime != null) {
    resUserDetailsUserinfo.createtime = createtime;
  }
  final int? updatetime = jsonConvert.convert<int>(json['updatetime']);
  if (updatetime != null) {
    resUserDetailsUserinfo.updatetime = updatetime;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    resUserDetailsUserinfo.token = token;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    resUserDetailsUserinfo.status = status;
  }
  final ResUserDetailsUserinfoVerification? verification = jsonConvert.convert<
      ResUserDetailsUserinfoVerification>(json['verification']);
  if (verification != null) {
    resUserDetailsUserinfo.verification = verification;
  }
  final dynamic realpwd = json['realpwd'];
  if (realpwd != null) {
    resUserDetailsUserinfo.realpwd = realpwd;
  }
  final String? zaloId = jsonConvert.convert<String>(json['zalo_id']);
  if (zaloId != null) {
    resUserDetailsUserinfo.zaloId = zaloId;
  }
  final int? totalDistance = jsonConvert.convert<int>(json['total_distance']);
  if (totalDistance != null) {
    resUserDetailsUserinfo.totalDistance = totalDistance;
  }
  final String? spotLongitude = jsonConvert.convert<String>(
      json['spot_longitude']);
  if (spotLongitude != null) {
    resUserDetailsUserinfo.spotLongitude = spotLongitude;
  }
  final String? spotLatitude = jsonConvert.convert<String>(
      json['spot_latitude']);
  if (spotLatitude != null) {
    resUserDetailsUserinfo.spotLatitude = spotLatitude;
  }
  final String? spotAddress = jsonConvert.convert<String>(json['spot_address']);
  if (spotAddress != null) {
    resUserDetailsUserinfo.spotAddress = spotAddress;
  }
  final int? totalDuration = jsonConvert.convert<int>(json['total_duration']);
  if (totalDuration != null) {
    resUserDetailsUserinfo.totalDuration = totalDuration;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    resUserDetailsUserinfo.latitude = latitude;
  }
  final dynamic address = json['address'];
  if (address != null) {
    resUserDetailsUserinfo.address = address;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    resUserDetailsUserinfo.longitude = longitude;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    resUserDetailsUserinfo.url = url;
  }
  return resUserDetailsUserinfo;
}

Map<String, dynamic> $ResUserDetailsUserinfoToJson(
    ResUserDetailsUserinfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['group_id'] = entity.groupId;
  data['username'] = entity.username;
  data['nickname'] = entity.nickname;
  data['password'] = entity.password;
  data['salt'] = entity.salt;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['avatar'] = entity.avatar;
  data['level'] = entity.level;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  data['bio'] = entity.bio;
  data['money'] = entity.money;
  data['score'] = entity.score;
  data['successions'] = entity.successions;
  data['maxsuccessions'] = entity.maxsuccessions;
  data['prevtime'] = entity.prevtime;
  data['logintime'] = entity.logintime;
  data['loginip'] = entity.loginip;
  data['loginfailure'] = entity.loginfailure;
  data['joinip'] = entity.joinip;
  data['jointime'] = entity.jointime;
  data['createtime'] = entity.createtime;
  data['updatetime'] = entity.updatetime;
  data['token'] = entity.token;
  data['status'] = entity.status;
  data['verification'] = entity.verification?.toJson();
  data['realpwd'] = entity.realpwd;
  data['zalo_id'] = entity.zaloId;
  data['total_distance'] = entity.totalDistance;
  data['spot_longitude'] = entity.spotLongitude;
  data['spot_latitude'] = entity.spotLatitude;
  data['spot_address'] = entity.spotAddress;
  data['total_duration'] = entity.totalDuration;
  data['latitude'] = entity.latitude;
  data['address'] = entity.address;
  data['longitude'] = entity.longitude;
  data['url'] = entity.url;
  return data;
}

extension ResUserDetailsUserinfoExtension on ResUserDetailsUserinfo {
  ResUserDetailsUserinfo copyWith({
    int? id,
    int? groupId,
    String? username,
    String? nickname,
    String? password,
    String? salt,
    String? email,
    String? mobile,
    String? avatar,
    int? level,
    int? gender,
    dynamic birthday,
    String? bio,
    String? money,
    int? score,
    int? successions,
    int? maxsuccessions,
    int? prevtime,
    int? logintime,
    String? loginip,
    int? loginfailure,
    String? joinip,
    dynamic jointime,
    int? createtime,
    int? updatetime,
    String? token,
    String? status,
    ResUserDetailsUserinfoVerification? verification,
    dynamic realpwd,
    String? zaloId,
    int? totalDistance,
    String? spotLongitude,
    String? spotLatitude,
    String? spotAddress,
    int? totalDuration,
    String? latitude,
    dynamic address,
    String? longitude,
    String? url,
  }) {
    return ResUserDetailsUserinfo()
      ..id = id ?? this.id
      ..groupId = groupId ?? this.groupId
      ..username = username ?? this.username
      ..nickname = nickname ?? this.nickname
      ..password = password ?? this.password
      ..salt = salt ?? this.salt
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..avatar = avatar ?? this.avatar
      ..level = level ?? this.level
      ..gender = gender ?? this.gender
      ..birthday = birthday ?? this.birthday
      ..bio = bio ?? this.bio
      ..money = money ?? this.money
      ..score = score ?? this.score
      ..successions = successions ?? this.successions
      ..maxsuccessions = maxsuccessions ?? this.maxsuccessions
      ..prevtime = prevtime ?? this.prevtime
      ..logintime = logintime ?? this.logintime
      ..loginip = loginip ?? this.loginip
      ..loginfailure = loginfailure ?? this.loginfailure
      ..joinip = joinip ?? this.joinip
      ..jointime = jointime ?? this.jointime
      ..createtime = createtime ?? this.createtime
      ..updatetime = updatetime ?? this.updatetime
      ..token = token ?? this.token
      ..status = status ?? this.status
      ..verification = verification ?? this.verification
      ..realpwd = realpwd ?? this.realpwd
      ..zaloId = zaloId ?? this.zaloId
      ..totalDistance = totalDistance ?? this.totalDistance
      ..spotLongitude = spotLongitude ?? this.spotLongitude
      ..spotLatitude = spotLatitude ?? this.spotLatitude
      ..spotAddress = spotAddress ?? this.spotAddress
      ..totalDuration = totalDuration ?? this.totalDuration
      ..latitude = latitude ?? this.latitude
      ..address = address ?? this.address
      ..longitude = longitude ?? this.longitude
      ..url = url ?? this.url;
  }
}

ResUserDetailsUserinfoVerification $ResUserDetailsUserinfoVerificationFromJson(
    Map<String, dynamic> json) {
  final ResUserDetailsUserinfoVerification resUserDetailsUserinfoVerification = ResUserDetailsUserinfoVerification();
  final int? email = jsonConvert.convert<int>(json['email']);
  if (email != null) {
    resUserDetailsUserinfoVerification.email = email;
  }
  final int? mobile = jsonConvert.convert<int>(json['mobile']);
  if (mobile != null) {
    resUserDetailsUserinfoVerification.mobile = mobile;
  }
  return resUserDetailsUserinfoVerification;
}

Map<String, dynamic> $ResUserDetailsUserinfoVerificationToJson(
    ResUserDetailsUserinfoVerification entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  return data;
}

extension ResUserDetailsUserinfoVerificationExtension on ResUserDetailsUserinfoVerification {
  ResUserDetailsUserinfoVerification copyWith({
    int? email,
    int? mobile,
  }) {
    return ResUserDetailsUserinfoVerification()
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile;
  }
}