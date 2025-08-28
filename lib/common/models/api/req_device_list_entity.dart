import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/req_device_list_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/req_device_list_entity.g.dart';

@JsonSerializable()
class ReqDeviceListEntity {
  @JSONField(name: 'device_list')
  List<ReqDeviceListDeviceList> deviceList = [];

  ReqDeviceListEntity();

  factory ReqDeviceListEntity.fromJson(Map<String, dynamic> json) =>
      $ReqDeviceListEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReqDeviceListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ReqDeviceListDeviceList {
  String? name;
  String imei = '';
  int id = 0;
  @JSONField(name: 'user_id')
  int userId = 0;

  ReqDeviceListDeviceList();

  factory ReqDeviceListDeviceList.fromJson(Map<String, dynamic> json) =>
      $ReqDeviceListDeviceListFromJson(json);

  Map<String, dynamic> toJson() => $ReqDeviceListDeviceListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
