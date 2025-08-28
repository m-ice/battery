import 'package:battery/generated/json/base/json_convert_content.dart';
import 'package:battery/common/models/api/msg_data_entity.dart';

MsgDataEntity $MsgDataEntityFromJson(Map<String, dynamic> json) {
  final MsgDataEntity msgDataEntity = MsgDataEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    msgDataEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    msgDataEntity.msg = msg;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    msgDataEntity.time = time;
  }
  final dynamic data = json['data'];
  if (data != null) {
    msgDataEntity.data = data;
  }
  return msgDataEntity;
}

Map<String, dynamic> $MsgDataEntityToJson(MsgDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['time'] = entity.time;
  data['data'] = entity.data;
  return data;
}

extension MsgDataEntityExtension on MsgDataEntity {
  MsgDataEntity copyWith({
    int? code,
    String? msg,
    String? time,
    dynamic data,
  }) {
    return MsgDataEntity()
      ..code = code ?? this.code
      ..msg = msg ?? this.msg
      ..time = time ?? this.time
      ..data = data ?? this.data;
  }
}