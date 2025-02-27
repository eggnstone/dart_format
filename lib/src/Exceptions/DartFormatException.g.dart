// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DartFormatException.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DartFormatException _$DartFormatExceptionFromJson(Map<String, dynamic> json) =>
    _DartFormatException(
      message: json['Message'] as String,
      type: $enumDecode(_$FailTypeEnumMap, json['Type']),
      line: (json['Line'] as num?)?.toInt(),
      column: (json['Column'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DartFormatExceptionToJson(
        _DartFormatException instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Type': _$FailTypeEnumMap[instance.type]!,
      if (instance.line case final value?) 'Line': value,
      if (instance.column case final value?) 'Column': value,
    };

const _$FailTypeEnumMap = {
  FailType.error: 'Error',
  FailType.warning: 'Warning',
};
