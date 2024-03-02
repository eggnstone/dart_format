// ignore_for_file: invalid_annotation_target

import 'package:analyzer/source/line_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../Types/FailType.dart';

part 'DartFormatException.freezed.dart';
part 'DartFormatException.g.dart';

/// The DartFormatException class is used to report errors and warnings.
@freezed
class DartFormatException with _$DartFormatException implements Exception
{
    const factory DartFormatException({
        @JsonKey(name: 'Message') required String message,
        @JsonKey(name: 'Type') required FailType type,
        @JsonKey(includeIfNull: false, name: 'Line') int? line,
        @JsonKey(includeIfNull: false, name: 'Column') int? column
    }) = _DartFormatException;

    factory DartFormatException.error(String message, CharacterLocation? location)
    => DartFormatException(message: message, type: FailType.error, line: location?.lineNumber, column: location?.columnNumber);

    factory DartFormatException.warning(String message, CharacterLocation location)
    => DartFormatException(message: message, type: FailType.warning, line: location.lineNumber, column: location.columnNumber);

    factory DartFormatException.fromJson(Map<String, dynamic> json)
    => _$DartFormatExceptionFromJson(json);
}
