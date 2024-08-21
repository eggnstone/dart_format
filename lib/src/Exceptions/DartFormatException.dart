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
    /// Create a new DartFormatException with the given message and type.
    const factory DartFormatException({
        /// The message of the exception.
        @JsonKey(name: 'Message') required String message,
        /// The type of the exception.
        @JsonKey(name: 'Type') required FailType type,
        /// The line number where the exception occurred.
        @JsonKey(includeIfNull: false, name: 'Line') int? line,
        /// The column number where the exception occurred.
        @JsonKey(includeIfNull: false, name: 'Column') int? column
    }) = _DartFormatException;

    /// Create a new error DartFormatException with the given message.
    factory DartFormatException.error(String message, [CharacterLocation? location])
    => DartFormatException(message: message, type: FailType.error, line: location?.lineNumber, column: location?.columnNumber);

    /// Create a new warning DartFormatException with the given message.
    factory DartFormatException.warning(String message, [CharacterLocation? location])
    => DartFormatException(message: message, type: FailType.warning, line: location?.lineNumber, column: location?.columnNumber);

    /// Create a new DartFormatException from the given JSON.
    factory DartFormatException.fromJson(Map<String, dynamic> json)
    => _$DartFormatExceptionFromJson(json);
}
