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
      protocol: json['Protocol'] as String?,
      address: json['Address'] as String?,
      port: (json['Port'] as num?)?.toInt(),
      processId: (json['ProcessId'] as num?)?.toInt(),
      logFilePath: json['LogFilePath'] as String?,
      logFileName: json['LogFileName'] as String?,
      message: json['Message'] as String?,
    );

Map<String, dynamic> _$JsonResponseToJson(_JsonResponse instance) =>
    <String, dynamic>{
      'StatusCode': instance.statusCode,
      'Status': instance.status,
      'CurrentVersion': ?instance.currentVersion,
      'LatestVersion': ?instance.latestVersion,
      'Protocol': ?instance.protocol,
      'Address': ?instance.address,
      'Port': ?instance.port,
      'ProcessId': ?instance.processId,
      'LogFilePath': ?instance.logFilePath,
      'LogFileName': ?instance.logFileName,
      'Message': ?instance.message,
    };
