// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'Config.freezed.dart';
part 'Config.g.dart';

/// Configuration for the formatter.
@freezed
class Config with _$Config
{
    /// Default value when all options are turned on: Whether to add a new line after a closing brace.
    static const bool ADD_NEW_LINE_AFTER_CLOSING_BRACE_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line after a closing brace.
    static const bool ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE = false;

    /// Default value when all options are turned on: Whether to add a new line after an opening brace.
    static const bool ADD_NEW_LINE_AFTER_OPENING_BRACE_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line after an opening brace.
    static const bool ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE = false;

    /// Default value when all options are turned on: Whether to add a new line after a semicolon.
    static const bool ADD_NEW_LINE_AFTER_SEMICOLON_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line after a semicolon.
    static const bool ADD_NEW_LINE_AFTER_SEMICOLON_NONE = false;

    /// Default value when all options are turned on: Whether to add a new line at the end of the text.
    static const bool ADD_NEW_LINE_AT_END_OF_TEXT_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line at the end of the text.
    static const bool ADD_NEW_LINE_AT_END_OF_TEXT_NONE = false;

    /// Default value when all options are turned on: Whether to add a new line before a closing brace.
    static const bool ADD_NEW_LINE_BEFORE_CLOSING_BRACE_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line before a closing brace.
    static const bool ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE = false;

    /// Default value when all options are turned on: Whether to add a new line before an opening brace.
    static const bool ADD_NEW_LINE_BEFORE_OPENING_BRACE_DEFAULT = true;
    /// Default value when all options are turned off: Whether to add a new line before an opening brace.
    static const bool ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE = false;

    /// Default value when all options are turned on: The number of spaces to use for indentation.
    static const int INDENTATION_SPACES_PER_LEVEL_DEFAULT = 4;
    /// Default value when all options are turned off: The number of spaces to use for indentation.
    static const int INDENTATION_SPACES_PER_LEVEL_NONE = -1;

    /// Default value when all options are turned on: The maximum number of empty lines to allow.
    static const int MAX_EMPTY_LINES_DEFAULT = 1;
    /// Default value when all options are turned off: The maximum number of empty lines to allow.
    static const int MAX_EMPTY_LINES_NONE = -1;

    /// Default value when all options are turned on: Whether to remove trailing commas.
    static const bool REMOVE_TRAILING_COMMAS_DEFAULT = true;
    /// Default value when all options are turned off: Whether to remove trailing commas.
    static const bool REMOVE_TRAILING_COMMAS_NONE = false;

    // necessary when you want to create additional methods
    const Config._();

    /// Create a new instance of [Config].
    @JsonSerializable(fieldRename: FieldRename.pascal)
    const factory Config({
        required bool addNewLineAfterClosingBrace,
        required bool addNewLineAfterOpeningBrace,
        required bool addNewLineAfterSemicolon,
        required bool addNewLineAtEndOfText,
        required bool addNewLineBeforeClosingBrace,
        required bool addNewLineBeforeOpeningBrace,
        required int indentationSpacesPerLevel,
        required int maxEmptyLines,
        required bool removeTrailingCommas
    }) = _Config;

    /// Create a new instance of [Config] with all options turned on.
    // ignore: prefer_constructors_over_static_methods
    static Config all({
        bool addNewLineAfterClosingBrace = ADD_NEW_LINE_AFTER_CLOSING_BRACE_DEFAULT,
        bool addNewLineAfterOpeningBrace = ADD_NEW_LINE_AFTER_OPENING_BRACE_DEFAULT,
        bool addNewLineAfterSemicolon = ADD_NEW_LINE_AFTER_SEMICOLON_DEFAULT,
        bool addNewLineAtEndOfText = ADD_NEW_LINE_AT_END_OF_TEXT_DEFAULT,
        bool addNewLineBeforeClosingBrace = ADD_NEW_LINE_BEFORE_CLOSING_BRACE_DEFAULT,
        bool addNewLineBeforeOpeningBrace = ADD_NEW_LINE_BEFORE_OPENING_BRACE_DEFAULT,
        int indentationSpacesPerLevel = INDENTATION_SPACES_PER_LEVEL_DEFAULT,
        int maxEmptyLines = MAX_EMPTY_LINES_DEFAULT,
        bool removeTrailingCommas = REMOVE_TRAILING_COMMAS_DEFAULT
    })
    => Config(
        addNewLineAfterClosingBrace: addNewLineAfterClosingBrace,
        addNewLineAfterOpeningBrace: addNewLineAfterOpeningBrace,
        addNewLineAfterSemicolon: addNewLineAfterSemicolon,
        addNewLineAtEndOfText: addNewLineAtEndOfText,
        addNewLineBeforeClosingBrace: addNewLineBeforeClosingBrace,
        addNewLineBeforeOpeningBrace: addNewLineBeforeOpeningBrace,
        indentationSpacesPerLevel: indentationSpacesPerLevel,
        maxEmptyLines: maxEmptyLines,
        removeTrailingCommas: removeTrailingCommas
    );

    /// Create a new instance of [Config] with all options turned off.
    // ignore: prefer_constructors_over_static_methods
    static Config none({
        bool addNewLineAfterClosingBrace = ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE,
        bool addNewLineAfterOpeningBrace = ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE,
        bool addNewLineAfterSemicolon = ADD_NEW_LINE_AFTER_SEMICOLON_NONE,
        bool addNewLineAtEndOfText = ADD_NEW_LINE_AT_END_OF_TEXT_NONE,
        bool addNewLineBeforeClosingBrace = ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE,
        bool addNewLineBeforeOpeningBrace = ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE,
        int indentationSpacesPerLevel = INDENTATION_SPACES_PER_LEVEL_NONE,
        int maxEmptyLines = MAX_EMPTY_LINES_NONE,
        bool removeTrailingCommas = REMOVE_TRAILING_COMMAS_NONE
    })
    => Config(
        addNewLineAfterClosingBrace: addNewLineAfterClosingBrace,
        addNewLineAfterOpeningBrace: addNewLineAfterOpeningBrace,
        addNewLineAfterSemicolon: addNewLineAfterSemicolon,
        addNewLineAtEndOfText: addNewLineAtEndOfText,
        addNewLineBeforeClosingBrace: addNewLineBeforeClosingBrace,
        addNewLineBeforeOpeningBrace: addNewLineBeforeOpeningBrace,
        indentationSpacesPerLevel: indentationSpacesPerLevel,
        maxEmptyLines: maxEmptyLines,
        removeTrailingCommas: removeTrailingCommas
    );

    /// Create a new instance of [Config] from a JSON string.
    factory Config.fromJsonText(String? s)
    {
        if (s == null)
            return Config.all();

        return Config.fromJson(Map<String, dynamic>.from(jsonDecode(s)));
    }

    /// Create a new instance of [Config] from a JSON object.
    factory Config.fromJson(Map<String, dynamic> json)
    => _$ConfigFromJson(json);
}
