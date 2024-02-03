import 'dart:convert';

class Config
{
    static const bool ADD_NEW_LINE_AFTER_CLOSING_BRACE_DEFAULT = true;
    static const bool ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE = false;

    static const bool ADD_NEW_LINE_AFTER_OPENING_BRACE_DEFAULT = true;
    static const bool ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE = false;

    static const bool ADD_NEW_LINE_AFTER_SEMICOLON_DEFAULT = true;
    static const bool ADD_NEW_LINE_AFTER_SEMICOLON_NONE = false;

    static const bool ADD_NEW_LINE_AT_END_OF_TEXT_DEFAULT = true;
    static const bool ADD_NEW_LINE_AT_END_OF_TEXT_NONE = false;

    static const bool ADD_NEW_LINE_BEFORE_CLOSING_BRACE_DEFAULT = true;
    static const bool ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE = false;

    static const bool ADD_NEW_LINE_BEFORE_OPENING_BRACE_DEFAULT = true;
    static const bool ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE = false;

    static const int INDENTATION_SPACES_PER_LEVEL_DEFAULT = 4;
    static const int INDENTATION_SPACES_PER_LEVEL_NONE = -1;

    static const int MAX_EMPTY_LINES_DEFAULT = 1;
    static const int MAX_EMPTY_LINES_NONE = -1;

    static const bool REMOVE_TRAILING_COMMAS_DEFAULT = true;
    static const bool REMOVE_TRAILING_COMMAS_NONE = false;

    final bool addNewLineAfterClosingBrace;
    final bool addNewLineAfterOpeningBrace;
    final bool addNewLineAfterSemicolon;
    final bool addNewLineAtEndOfText;
    final bool addNewLineBeforeClosingBrace;
    final bool addNewLineBeforeOpeningBrace;
    final int indentationSpacesPerLevel;
    final int maxEmptyLines;
    final bool removeTrailingCommas;

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

    factory Config.fromJson(String? configText)
    {
        if (configText == null)
            return const Config.all();

        final dynamic json = jsonDecode(configText);
        return Config.none(
            addNewLineAfterClosingBrace: json['AddNewLineAfterClosingBrace'] ?? ADD_NEW_LINE_AFTER_CLOSING_BRACE_NONE,
            addNewLineAfterOpeningBrace: json['AddNewLineAfterOpeningBrace'] ?? ADD_NEW_LINE_AFTER_OPENING_BRACE_NONE,
            addNewLineAfterSemicolon: json['AddNewLineAfterSemicolon'] ?? ADD_NEW_LINE_AFTER_SEMICOLON_NONE,
            addNewLineAtEndOfText: json['AddNewLineAtEndOfText'] ?? ADD_NEW_LINE_AT_END_OF_TEXT_NONE,
            addNewLineBeforeClosingBrace: json['AddNewLineBeforeClosingBrace'] ?? ADD_NEW_LINE_BEFORE_CLOSING_BRACE_NONE,
            addNewLineBeforeOpeningBrace: json['AddNewLineBeforeOpeningBrace'] ?? ADD_NEW_LINE_BEFORE_OPENING_BRACE_NONE,
            indentationSpacesPerLevel: json['IndentationSpacesPerLevel'] ?? INDENTATION_SPACES_PER_LEVEL_NONE,
            maxEmptyLines: json['MaxEmptyLines'] ?? MAX_EMPTY_LINES_NONE,
            removeTrailingCommas: json['RemoveTrailingCommas'] ?? REMOVE_TRAILING_COMMAS_NONE
        );
    }
}
