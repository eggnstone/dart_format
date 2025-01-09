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

Map<String, dynamic> _$$JsonResponseImplToJson(_$JsonResponseImpl instance) =>
    <String, dynamic>{
      'StatusCode': instance.statusCode,
      'Status': instance.status,
      if (instance.currentVersion case final value?) 'CurrentVersion': value,
      if (instance.latestVersion case final value?) 'LatestVersion': value,
      if (instance.message case final value?) 'Message': value,
    };
