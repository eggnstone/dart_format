// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/source/line_info.dart';

import 'Constants/Constants.dart';
import 'Data/Config.dart';
import 'Data/IntTuple.dart';
import 'Exceptions/DartFormatException.dart';
import 'FormatState.dart';
import 'FormatVisitor.dart';
import 'Tools/FormatTools.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Tools/TextTools.dart';

/// The Formatter class is the main class of the package.
class Formatter
{
    final Config _config;

    /// Create a new Formatter with the given configuration.
    Formatter(Config config) : _config = config;

    /// Format the given string.
    String format(String s)
    {
        if (Constants.DEBUG_FORMATTER)
        {
            logInternal('# Formatter.format()');
            logInternal('  ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
            logInternal('  indentationSpacesPerLevel: ${_config.indentationSpacesPerLevel}');
            logInternal('  maxEmptyLines: ${_config.maxEmptyLines}');
        }

        final String cleanedS = s.replaceAll('\r', '');
        final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: cleanedS, throwIfDiagnostics: false);

        final List<Diagnostic> errors = parseResult.errors;
        if (errors.isNotEmpty)
            _logAndThrowWarning(errors.first.message, parseResult.lineInfo.getLocation(errors.first.offset));

        final DateTime startDateTime = DateTime.now();
        final DateTime maxDateTime = startDateTime.add(const Duration(seconds: Constants.MAX_FORMAT_TIME_IN_SECONDS));
        final FormatState formatState = FormatState(
            parseResult,
            indentationSpacesPerLevel: _config.indentationSpacesPerLevel,
            maxDateTime: maxDateTime,
            removeTrailingCommas: _config.removeTrailingCommas,
            startDateTime: startDateTime
        );

        final FormatVisitor visitor = FormatVisitor(config: _config, formatState: formatState);
        formatState.compilationUnit.accept(visitor);
        String result = formatState.getResult();

        final TextTools textTools = TextTools(_config);
        result = textTools.removeEmptyLines(result);
        //result = FormatTools.resolveRelativeIndentations(result);
        result = textTools.addNewLineAtEndOfText(result);

        return _verifyResult(cleanedS, result, parseResult.lineInfo);
    }

    void _logWarning(String s)
    {
        if (Constants.DEBUG_FORMAT_STATE)
            logInternalWarning(s);
    }

    void _logAndThrowWarning(String message, CharacterLocation location)
    {
        _logWarning(message);
        throw DartFormatException.warning(message, location);
    }

    String _verifyResult(String s, String result, LineInfo lineInfo)
    {
        // Remove all spaces and line breaks, but reduce spaces between letters to one space, otherwise changes like "await Future<>" to "awaitFuture<>" are not detected.

        if (Constants.DEBUG_FORMATTER) logInternal('Input:                   ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
        final String condensedInput = StringTools.condense(s);
        if (Constants.DEBUG_FORMATTER) logInternal('condensedInput:          ${StringTools.toDisplayString(condensedInput, Constants.MAX_DEBUG_LENGTH)}');

        if (Constants.DEBUG_FORMATTER) logInternal('result:                  ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}');
        final String cleanedResult = FormatTools.removeIndentTags(FormatTools.removeIgnoreTags(result));
        if (Constants.DEBUG_FORMATTER) logInternal('cleanedResult:           ${StringTools.toDisplayString(cleanedResult, Constants.MAX_DEBUG_LENGTH)}');
        final String condensedCleanedResult = StringTools.condense(cleanedResult);
        if (Constants.DEBUG_FORMATTER) logInternal('condensedCleanedResult:  ${StringTools.toDisplayString(condensedCleanedResult, Constants.MAX_DEBUG_LENGTH)}');

        if (condensedCleanedResult == condensedInput)
        {
            final String resolvedResult = FormatTools.resolveIndents(FormatTools.resolveIgnores(result));
            if (Constants.DEBUG_FORMATTER)
            {
                logInternal('  result:         ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}"');
                logInternal('  resolvedResult: ${StringTools.toDisplayString(resolvedResult, Constants.MAX_DEBUG_LENGTH)}"');
            }
            return resolvedResult;
        }

        final IntTuple positions = StringTools.findDiff(s, result);

        final String message1;
        final String message2;
        CharacterLocation? reportLocation;

        if (positions == createEmptyIntTuple())
        {
            message1 = 'Internal error: Invalid changes detected but no differences to show.';
            message2 =
            'Input:  ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}\n'
            'Result: ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}\n'
            'condensedInput:  ${StringTools.toDisplayString(condensedInput, Constants.MAX_DEBUG_LENGTH)}\n'
            'condensedResult: ${StringTools.toDisplayString(condensedCleanedResult, Constants.MAX_DEBUG_LENGTH)}';
        }
        else
        {
            reportLocation = lineInfo.getLocation(positions.item1);
            final CharacterLocation location1 = lineInfo.getLocation(positions.item1);
            final CharacterLocation location2 = lineInfo.getLocation(positions.item2);
            message1 = 'Internal error: Invalid changes detected at index ${location1.lineNumber},${location1.columnNumber} / ${location2.lineNumber},${location2.columnNumber}';
            message2 =
            'Same:   ${StringTools.toDisplayStringCutAtFront(result.substring(0, positions.item2), Constants.MAX_DEBUG_LENGTH)}\n'
            'Input:  ${StringTools.toDisplayString(s.substring(positions.item1), Constants.MAX_DEBUG_LENGTH)}\n'
            'Result: ${StringTools.toDisplayString(result.substring(positions.item2), Constants.MAX_DEBUG_LENGTH)}\n'
            'condensedInput:  ${StringTools.toDisplayString(condensedInput, Constants.MAX_DEBUG_LENGTH)}\n'
            'condensedResult: ${StringTools.toDisplayString(condensedCleanedResult, Constants.MAX_DEBUG_LENGTH)}';

            if (Constants.DEBUG_FORMATTER) logInternal('Invalid changes detected:\n-----\n$result\n-----');
        }

        if (Constants.DEBUG_FORMATTER)
        {
            logInternal('$message1\n$message2');

            final IntTuple positions2 = StringTools.findDiff(condensedInput, condensedCleanedResult);
            if (positions2 == createEmptyIntTuple())
            {
                logInternal('Nothing found, even when comparing condensedInput and condensedResultWithIgnores.');
                logInternal('condensedInput:\n$condensedInput');
                logInternal('condensedResult:\n$condensedCleanedResult');
            }
            else
            {
                final String message2a =
                    'Same:            ${StringTools.toDisplayStringCutAtFront(condensedCleanedResult.substring(0, positions2.item2), Constants.MAX_DEBUG_LENGTH)}\n'
                    'condensedInput:  ${StringTools.toDisplayString(condensedInput.substring(positions2.item1), Constants.MAX_DEBUG_LENGTH)}\n'
                    'condensedResult: ${StringTools.toDisplayString(condensedCleanedResult.substring(positions2.item2), Constants.MAX_DEBUG_LENGTH)}';
                logInternal('\n$message2a');
            }
        }

        throw DartFormatException.error('$message1|$message2', reportLocation);
    }
}
