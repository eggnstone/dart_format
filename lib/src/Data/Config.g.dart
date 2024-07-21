// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigImpl _$$ConfigImplFromJson(Map<String, dynamic> json) => _$ConfigImpl(
      addNewLineAfterClosingBrace: json['AddNewLineAfterClosingBrace'] as bool,
      addNewLineAfterOpeningBrace: json['AddNewLineAfterOpeningBrace'] as bool,
      addNewLineAfterSemicolon: json['AddNewLineAfterSemicolon'] as bool,
      addNewLineAtEndOfText: json['AddNewLineAtEndOfText'] as bool,
      addNewLineBeforeClosingBrace:
          json['AddNewLineBeforeClosingBrace'] as bool,
      addNewLineBeforeOpeningBrace:
          json['AddNewLineBeforeOpeningBrace'] as bool,
      indentationSpacesPerLevel:
          (json['IndentationSpacesPerLevel'] as num).toInt(),
      maxEmptyLines: (json['MaxEmptyLines'] as num).toInt(),
      removeTrailingCommas: json['RemoveTrailingCommas'] as bool,
      breakSetOrMapLiterals: json['BreakSetOrMapLiterals'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConfigImplToJson(_$ConfigImpl instance) =>
    <String, dynamic>{
      'AddNewLineAfterClosingBrace': instance.addNewLineAfterClosingBrace,
      'AddNewLineAfterOpeningBrace': instance.addNewLineAfterOpeningBrace,
      'AddNewLineAfterSemicolon': instance.addNewLineAfterSemicolon,
      'AddNewLineAtEndOfText': instance.addNewLineAtEndOfText,
      'AddNewLineBeforeClosingBrace': instance.addNewLineBeforeClosingBrace,
      'AddNewLineBeforeOpeningBrace': instance.addNewLineBeforeOpeningBrace,
      'IndentationSpacesPerLevel': instance.indentationSpacesPerLevel,
      'MaxEmptyLines': instance.maxEmptyLines,
      'RemoveTrailingCommas': instance.removeTrailingCommas,
      'BreakSetOrMapLiterals': instance.breakSetOrMapLiterals,
    };
