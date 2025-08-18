// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Config _$ConfigFromJson(Map<String, dynamic> json) => _Config(
  addNewLineAfterClosingBrace: json['AddNewLineAfterClosingBrace'] as bool,
  addNewLineAfterOpeningBrace: json['AddNewLineAfterOpeningBrace'] as bool,
  addNewLineAfterSemicolon: json['AddNewLineAfterSemicolon'] as bool,
  addNewLineAtEndOfText: json['AddNewLineAtEndOfText'] as bool,
  addNewLineBeforeClosingBrace: json['AddNewLineBeforeClosingBrace'] as bool,
  addNewLineBeforeOpeningBrace: json['AddNewLineBeforeOpeningBrace'] as bool,
  fixSpaces: json['FixSpaces'] as bool,
  indentationSpacesPerLevel: (json['IndentationSpacesPerLevel'] as num).toInt(),
  maxEmptyLines: (json['MaxEmptyLines'] as num).toInt(),
  removeTrailingCommas: json['RemoveTrailingCommas'] as bool,
);

Map<String, dynamic> _$ConfigToJson(_Config instance) => <String, dynamic>{
  'AddNewLineAfterClosingBrace': instance.addNewLineAfterClosingBrace,
  'AddNewLineAfterOpeningBrace': instance.addNewLineAfterOpeningBrace,
  'AddNewLineAfterSemicolon': instance.addNewLineAfterSemicolon,
  'AddNewLineAtEndOfText': instance.addNewLineAtEndOfText,
  'AddNewLineBeforeClosingBrace': instance.addNewLineBeforeClosingBrace,
  'AddNewLineBeforeOpeningBrace': instance.addNewLineBeforeOpeningBrace,
  'FixSpaces': instance.fixSpaces,
  'IndentationSpacesPerLevel': instance.indentationSpacesPerLevel,
  'MaxEmptyLines': instance.maxEmptyLines,
  'RemoveTrailingCommas': instance.removeTrailingCommas,
};
