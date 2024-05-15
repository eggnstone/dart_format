// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JsonResponseImpl _$$JsonResponseImplFromJson(Map<String, dynamic> json) =>
    _$JsonResponseImpl(
      statusCode: (json['StatusCode'] as num).toInt(),
      status: json['Status'] as String,
      currentVersion: json['CurrentVersion'] as String?,
      latestVersion: json['LatestVersion'] as String?,
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

  writeNotNull('CurrentVersion', instance.currentVersion);
  writeNotNull('LatestVersion', instance.latestVersion);
  writeNotNull('Message', instance.message);
  return val;
}
