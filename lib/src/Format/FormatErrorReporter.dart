import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/source/line_info.dart';

import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import '../Tools/LogTools.dart';

class FormatErrorReporter
{
    final ParseStringResult _parseResult;

    FormatErrorReporter(this._parseResult);

    CharacterLocation? getLocation(int offset)
    {
        try
        {
            return _parseResult.lineInfo.getLocation(offset);
        }
        // ignore: avoid_catching_errors
        on UnimplementedError catch (_)
        {
            // TestParseStringResult will throw an UnimplementedError.
            return null;
        }
    }

    String getPositionInfo(int offset)
    {
        try
        {
            final CharacterLocation location = _parseResult.lineInfo.getLocation(offset);
            return 'Line ${location.lineNumber}, column ${location.columnNumber}';
        }
        // ignore: avoid_catching_errors
        on UnimplementedError catch (_)
        {
            // TestParseStringResult will throw an UnimplementedError.
            return 'Offset $offset';
        }
    }

    void logAndThrowError(String message, [CharacterLocation? location])
    {
        logInternalError(message);
        throw DartFormatException.error(message, location);
    }

    void logAndThrowErrorWithOffset(String message, String? additionalText, int offset)
    {
        final String positionInfo = Constants.DEBUG_FORMAT_STATE ? '$offset, ${getPositionInfo(offset)}' : getPositionInfo(offset);

        String finalMessage = '$message ($positionInfo)';
        if (additionalText != null)
            finalMessage += ' $additionalText';

        logAndThrowError(finalMessage, getLocation(offset));
    }

    void logAndThrowErrorWithOffsets(String message, String delimiter, String? additionalText, int offset1, int offset2, String source)
    {
        final String positionInfo1 = Constants.DEBUG_FORMAT_STATE ? '$offset1, ${getPositionInfo(offset1)}' : getPositionInfo(offset1);
        final String positionInfo2 = Constants.DEBUG_FORMAT_STATE ? '$offset2, ${getPositionInfo(offset2)}' : getPositionInfo(offset2);

        String finalMessage = '$message ($positionInfo1) $delimiter ($positionInfo2)';
        if (additionalText != null)
            finalMessage += ' $additionalText';

        finalMessage += ' ($source)';
        logAndThrowError(finalMessage, getLocation(offset1));
    }
}
