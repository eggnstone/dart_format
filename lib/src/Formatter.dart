import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/line_info.dart';

import 'Config.dart';
import 'Constants/Constants.dart';
import 'Data/IntTuple.dart';
import 'Exceptions/DartFormatException.dart';
import 'FormatState.dart';
import 'FormatVisitor.dart';
import 'Tools/FormatTools.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Tools/TextTools.dart';

class Formatter
{
    final Config config;

    Formatter(this.config);

    String format(String s)
    {
        //throw DartFormatException.error('Formatter.format() is not implemented');
        _log('# Formatter.format()');
        _log('  ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
        _log('  indentationSpacesPerLevel: ${config.indentationSpacesPerLevel}');
        _log('  maxEmptyLines: ${config.maxEmptyLines}');

        final String sWithoutCarriageReturns = s.replaceAll('\r', '');

        final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: sWithoutCarriageReturns, throwIfDiagnostics: false);

        final List<AnalysisError> errors = parseResult.errors;
        if (errors.isNotEmpty)
            _logAndThrowWarning(errors.first.message, parseResult.lineInfo.getLocation(errors.first.offset));

        final FormatState formatState = FormatState(
            parseResult,
            indentationSpacesPerLevel: config.indentationSpacesPerLevel,
            removeTrailingCommas: config.removeTrailingCommas
        );
        final FormatVisitor visitor = FormatVisitor(config: config, formatState: formatState);
        formatState.compilationUnit.accept(visitor);
        String result = formatState.getResult();

        final TextTools textTools = TextTools(config);
        result = textTools.removeEmptyLines(result);
        result = textTools.addNewLineAtEndOfText(result);

        return _verifyResult(sWithoutCarriageReturns, result, parseResult.lineInfo);
    }

    void _log(String s)
    {
        if (Constants.DEBUG_FORMATTER)
            logInternal(s);
    }

    /*void _logError(String s)
    {
    if (Constants.DEBUG_FORMAT_STATE)
    logInternalError(s);
    }*/

    void _logWarning(String s)
    {
        if (Constants.DEBUG_FORMAT_STATE)
            logInternalWarning(s);
    }

    String _verifyResult(String s, String result, LineInfo lineInfo)
    {
        final String condensedInput = s.replaceAll(RegExp(r'\s'), '').trim();
        final String condensedResultWithIgnores = result.replaceAll(RegExp(r'\s'), '').trim();

        final String condensedResultWithoutIgnores = FormatTools.removeIgnoreTagsOnly(condensedResultWithIgnores);
        if (condensedResultWithoutIgnores == condensedInput)
        {
            _log('  result: ${StringTools.toDisplayString(result, Constants.MAX_DEBUG_LENGTH)}"');

            final String resultWithoutIgnores = FormatTools.removeIgnoreTagsCompletely(result);
            _log('  resultWithoutIgnores: ${StringTools.toDisplayString(resultWithoutIgnores, Constants.MAX_DEBUG_LENGTH)}"');
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

        _log('$message1\n$message2');

        if (Constants.DEBUG_FORMATTER)
        {
            final IntTuple positions2 = StringTools.findDiff(condensedInput, condensedResultWithIgnores);
            if (positions2 != createEmptyIntTuple())
            {
                final String message2a =
                'Same:                       ${StringTools.toDisplayStringCutAtEnd(condensedResultWithIgnores.substring(0, positions2.item2), Constants.MAX_DEBUG_LENGTH)}\n'
                'condensedInput:             ${StringTools.toDisplayString(condensedInput.substring(positions2.item1), Constants.MAX_DEBUG_LENGTH)}\n'
                'condensedResultWithIgnores: ${StringTools.toDisplayString(condensedResultWithIgnores.substring(positions2.item2), Constants.MAX_DEBUG_LENGTH)}';
                _log('\n$message2a');
            }
        }

        throw DartFormatException.error('$message1|$message2');
    }

    void _logAndThrowWarning(String message, CharacterLocation location)
    {
        _logWarning(message);
        throw DartFormatException.warning(message, location);
    }

    /*void _logAndThrowError(String message)
    {
    _logError(message);
    throw DartFormatException.error(message);
    }*/
}
