import 'dart:convert';

import 'Tools/JsonTools.dart';

/// Configuration for the formatter.
class Config
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

    /// Whether to add a new line after a closing brace.
    final bool addNewLineAfterClosingBrace;
    /// Whether to add a new line after an opening brace.
    final bool addNewLineAfterOpeningBrace;
    /// Whether to add a new line after a semicolon.
    final bool addNewLineAfterSemicolon;
    /// Whether to add a new line at the end of the text.
    final bool addNewLineAtEndOfText;
    /// Whether to add a new line before a closing brace.
    final bool addNewLineBeforeClosingBrace;
    /// Whether to add a new line before an opening brace.
    final bool addNewLineBeforeOpeningBrace;
    /// The number of spaces to use for indentation. -1 = do not change indentation.
    final int indentationSpacesPerLevel;
    /// The maximum number of empty lines to allow. -1 = do not change empty lines.
    final int maxEmptyLines;
    /// Whether to remove trailing commas.
    final bool removeTrailingCommas;

    /// Create a new instance of [Config] with all options turned on.
    const Config.all({
        this.addNewLineAfterClosingBrace = ADD_NEW_LINE_AFTER_CLOSING_BRACE_DEFAULT,
        this.addNewLineAfterOpeningBrace = ADD_NEW_LINE_AFTER_OPENING_BRACE_DEFAULT,
        this.addNewLineAfterSemicolon = ADD_NEW_LINE_AFTER_SEMICOLON_DEFAULT,
        this.addNewLineAtEndOfText = ADD_NEW_LINE_AT_END_OF_TEXT_DEFAULT,
        this.addNewLineBeforeClosingBrace = ADD_NEW_LINE_BEFORE_CLOSING_BRACE_DEFAULT,
        this.addNewLineBeforeOpeningBrace = ADD_NEW_LINE_BEFORE_OPENING_BRACE_DEFAULT,
        this.indentationSpacesPerLevel = INDENTATION_SPACES_PER_LEVEL_DEFAULT,
        this.maxEmptyLines = MAX_EMPTY_LINES_DEFAULT,
        this.removeTrailingCommas = REMOVE_TRAILING_COMMAS_DEFAULT
    });

    /// Create a new instance of [Config] with all options turned off.
    const Config.none({
        this.addNewLineAfterClosingBrace = ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE,
        this.addNewLineAfterOpeningBrace = ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE,
        this.addNewLineAfterSemicolon = ADD_NEW_LINE_AFTER_SEMICOLON_NONE,
        this.addNewLineAtEndOfText = ADD_NEW_LINE_AT_END_OF_TEXT_NONE,
        this.addNewLineBeforeClosingBrace = ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE,
        this.addNewLineBeforeOpeningBrace = ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE,
        this.indentationSpacesPerLevel = INDENTATION_SPACES_PER_LEVEL_NONE,
        this.maxEmptyLines = MAX_EMPTY_LINES_NONE,
        this.removeTrailingCommas = REMOVE_TRAILING_COMMAS_NONE
    });

    /// Create a new instance of [Config] from a JSON string.
    factory Config.fromJson(String? configText)
    {
        if (configText == null)
            return const Config.all();

        final dynamic json = jsonDecode(configText);
        return Config.none(
            addNewLineAfterClosingBrace: JsonTools.get(json, 'AddNewLineAfterClosingBrace', ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE),
            addNewLineAfterOpeningBrace: JsonTools.get(json, 'AddNewLineAfterOpeningBrace', ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE),
            addNewLineAfterSemicolon: JsonTools.get(json, 'AddNewLineAfterSemicolon', ADD_NEW_LINE_AFTER_SEMICOLON_NONE),
            addNewLineAtEndOfText: JsonTools.get(json, 'AddNewLineAtEndOfText', ADD_NEW_LINE_AT_END_OF_TEXT_NONE),
            addNewLineBeforeClosingBrace: JsonTools.get(json, 'AddNewLineBeforeClosingBrace', ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE),
            addNewLineBeforeOpeningBrace: JsonTools.get(json, 'AddNewLineBeforeOpeningBrace', ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE),
            indentationSpacesPerLevel: JsonTools.get(json, 'IndentationSpacesPerLevel', INDENTATION_SPACES_PER_LEVEL_NONE),
            maxEmptyLines: JsonTools.get(json, 'MaxEmptyLines', MAX_EMPTY_LINES_NONE),
            removeTrailingCommas: JsonTools.get(json, 'RemoveTrailingCommas', REMOVE_TRAILING_COMMAS_NONE)
        );
    }
}
