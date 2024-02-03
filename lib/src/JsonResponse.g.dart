// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JsonResponseImpl _$$JsonResponseImplFromJson(Map<String, dynamic> json) =>
    _$JsonResponseImpl(
      statusCode: json['StatusCode'] as int,
      status: json['Status'] as String,
      message: json['Message'] as String?,
    );

Map<String, dynamic> _$$JsonResponseImplToJson(_$JsonResponseImpl instance) {
  final val = <String, dynamic>{
    'StatusCode': instance.statusCode,
    'Status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Message', instance.message);
  return val;
}
