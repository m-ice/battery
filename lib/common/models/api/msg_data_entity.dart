import 'package:battery/generated/json/base/json_field.dart';
import 'package:battery/generated/json/msg_data_entity.g.dart';
import 'dart:convert';
export 'package:battery/generated/json/msg_data_entity.g.dart';

@JsonSerializable()
class MsgDataEntity {
	int code = 0;
	String msg = '';
	String time = '';
	dynamic data;

	MsgDataEntity();

	factory MsgDataEntity.fromJson(Map<String, dynamic> json) => $MsgDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $MsgDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}