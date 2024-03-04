// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dart_format/dart_format.dart';

void main(List<String> arguments)
{
    const String unformattedText = 'class C{void m(){print("Hello world");}}';
    print('Unformatted text:');
    print('$unformattedText\n');

    final Config configAll = Config.all();
    final Formatter formatter = Formatter(configAll);
    final String formattedText = formatter.format(unformattedText);
    print('Formatted text:');
    print(formattedText);

    final Config configAllMinusSemicolon = Config.all(addNewLineAfterSemicolon: false);
    print('Config "all settings enabled" with AddNewLineAfterSemicolon turned off:');
    print(jsonEncode(configAllMinusSemicolon.toJson()));

    print('');

    final Config configNonePlusSemicolon = Config.none(addNewLineAfterSemicolon: true);
    print('Config "no settings enabled" with AddNewLineAfterSemicolon turned on:');
    print(jsonEncode(configNonePlusSemicolon.toJson()));
}

/*
Output:

Unformatted text:
class C{void m(){print("Hello world");}}

Formatted text:
class C
{
    void m()
    {
        print("Hello world");
    }
}

Config "all settings enabled" with AddNewLineAfterSemicolon turned off:
{"AddNewLineAfterClosingBrace":true,"AddNewLineAfterOpeningBrace":true,"AddNewLineAfterSemicolon":false,"AddNewLineAtEndOfText":true,"AddNewLineBeforeClosingBrace":true,"AddNewLineBeforeOpeningBrace":true,"IndentationSpacesPerLevel":4,"MaxEmptyLines":1,"RemoveTrailingCommas":true}

Config "no settings enabled" with AddNewLineAfterSemicolon turned on:
{"AddNewLineAfterClosingBrace":false,"AddNewLineAfterOpeningBrace":false,"AddNewLineAfterSemicolon":true,"AddNewLineAtEndOfText":false,"AddNewLineBeforeClosingBrace":false,"AddNewLineBeforeOpeningBrace":false,"IndentationSpacesPerLevel":-1,"MaxEmptyLines":-1,"RemoveTrailingCommas":false}
*/
