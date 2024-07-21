// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/error/error.dart';
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

        final String sWithoutCarriageReturns = s.replaceAll('\r', '');

        final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: sWithoutCarriageReturns, throwIfDiagnostics: false);

        final List<AnalysisError> errors = parseResult.errors;
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
        result = textTools.addNewLineAtEndOfText(result);

        return _verifyResult(sWithoutCarriageReturns, result, parseResult.lineInfo);
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
        final String condensedInput = s.replaceAll(RegExp(r'\s'), '').trim();
        final String condensedResultWithIgnores = result.replaceAll(RegExp(r'\s'), '').trim();

        final String condensedResultWithoutIgnores = FormatTools.removeIgnoreTagsOnly(condensedResultWithIgnores);
        if (condensedResultWithoutIgnores == condensedInput)
        {
            if (Constants.DEBUG_FORMATTER) logInternal('  result: ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}"');

            final String resultWithoutIgnores = FormatTools.removeIgnoreTagsCompletely(result);
            if (Constants.DEBUG_FORMATTER) logInternal('  resultWithoutIgnores: ${StringTools.toDisplayString(resultWithoutIgnores, Constants.MAX_DEBUG_LENGTH)}"');
            return resultWithoutIgnores;
        }

        final IntTuple positions = StringTools.findDiff(s, result);

        final String message1;
        final String message2;
        if (positions == createEmptyIntTuple())
        {
            message1 = 'Internal error: Invalid changes detected but no differences to show.';
            message2 =
            'Input:  ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}\n'
            'Result: ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}';
        }
        else
        {
            final CharacterLocation location1 = lineInfo.getLocation(positions.item1);
            final CharacterLocation location2 = lineInfo.getLocation(positions.item2);
            message1 = 'Internal error: Invalid changes detected at index ${location1.lineNumber},${location1.columnNumber} / ${location2.lineNumber},${location2.columnNumber}';
            message2 =
            'Same:   ${StringTools.toDisplayStringCutAtEnd(result.substring(0, positions.item2), Constants.MAX_DEBUG_LENGTH)}\n'
            'Input:  ${StringTools.toDisplayString(s.substring(positions.item1), Constants.MAX_DEBUG_LENGTH)}\n'
            'Result: ${StringTools.toDisplayString(result.substring(positions.item2), Constants.MAX_DEBUG_LENGTH)}';
        }

        if (Constants.DEBUG_FORMATTER) logInternal('$message1\n$message2');

        if (Constants.DEBUG_FORMATTER)
        {
            final IntTuple positions2 = StringTools.findDiff(condensedInput, condensedResultWithIgnores);
            if (positions2 != createEmptyIntTuple())
            {
                final String message2a =
                'Same:                       ${StringTools.toDisplayStringCutAtEnd(condensedResultWithIgnores.substring(0, positions2.item2), Constants.MAX_DEBUG_LENGTH)}\n'
                'condensedInput:             ${StringTools.toDisplayString(condensedInput.substring(positions2.item1), Constants.MAX_DEBUG_LENGTH)}\n'
                'condensedResultWithIgnores: ${StringTools.toDisplayString(condensedResultWithIgnores.substring(positions2.item2), Constants.MAX_DEBUG_LENGTH)}';
                if (Constants.DEBUG_FORMATTER) logInternal('\n$message2a');
            }
        }

        throw DartFormatException.error('$message1|$message2');
    }
}
