// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DartFormatException.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DartFormatExceptionImpl _$$DartFormatExceptionImplFromJson(
        Map<String, dynamic> json) =>
    _$DartFormatExceptionImpl(
      message: json['Message'] as String,
      type: $enumDecode(_$FailTypeEnumMap, json['Type']),
      line: json['Line'] as int?,
      column: json['Column'] as int?,
    );

Map<String, dynamic> _$$DartFormatExceptionImplToJson(
    _$DartFormatExceptionImpl instance) {
  final val = <String, dynamic>{
    'Message': instance.message,
    'Type': _$FailTypeEnumMap[instance.type]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Line', instance.line);
  writeNotNull('Column', instance.column);
  return val;
}

const _$FailTypeEnumMap = {
  FailType.error: 'Error',
  FailType.warning: 'Warning',
};
