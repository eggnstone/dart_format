// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JsonResponse _$JsonResponseFromJson(Map<String, dynamic> json) =>
    _JsonResponse(
      statusCode: (json['StatusCode'] as num).toInt(),
      status: json['Status'] as String,
      currentVersion: json['CurrentVersion'] as String?,
      latestVersion: json['LatestVersion'] as String?,
      message: json['Message'] as String?,
    );

Map<String, dynamic> _$JsonResponseToJson(_JsonResponse instance) =>
    <String, dynamic>{
      'StatusCode': instance.statusCode,
      'Status': instance.status,
      'CurrentVersion': ?instance.currentVersion,
      'LatestVersion': ?instance.latestVersion,
      'Message': ?instance.message,
    };
