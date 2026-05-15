import 'dart:convert';
import 'dart:io';

import '../Constants/Constants.dart';
import '../Constants/ExitCodes.dart';
import '../Data/Config.dart';
import '../Enums/FailType.dart';
import '../Exceptions/DartFormatException.dart';
import '../Format/Formatter.dart';
import '../Tools/LogTools.dart';
import '../Tools/VersionTools.dart';

class PipeHandler
{
    static const String CLASS_NAME = 'DefaultHandler';

    final String? configText;
    final bool errorsAsJson;
    final bool skipVersionCheck;

    PipeHandler({
        required this.errorsAsJson,
        required this.skipVersionCheck,
        this.configText
    });

    Future<int> run()
    async
    {
        DartFormatException? dartFormatException;

        const String METHOD_NAME = '$CLASS_NAME.run';
        _logDebug('$METHOD_NAME START');

        // Newer-version notice is informational only; exit code stays 0 on success.
        await VersionTools().isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);

        try
        {
            final Config config = Config.fromJsonText(configText);
            final Formatter formatter = Formatter(config);
            final String inputText = await _readInput();
            final String formattedText = formatter.format(inputText);
            writeToStdOut(formattedText, preventLoggingToTempFile: true);

            _logDebug('$METHOD_NAME END with SUCCESS');
            return ExitCodes.SUCCESS;
        }
        on DartFormatException catch (e)
        {
            dartFormatException = e;
        }
        on Exception catch (e)
        {
            dartFormatException = DartFormatException.error(e.toString());
        }

        if (errorsAsJson)
            writelnToStdErr(jsonEncode(dartFormatException));
        else
            writelnToStdErr('${dartFormatException.type.displayName}: ${dartFormatException.message}');

        _logDebug('$METHOD_NAME END with FAILURE');
        return ExitCodes.FAILURE;
    }

    void _logDebug(String s)
    {
        if (Constants.DEBUG_DART_FORMAT_HANDLERS)
            logDebug(s);
    }

    Future<String> _readInput()
    async
    {
        final List<int> bytes = <int>[];
        await stdin.forEach(bytes.addAll);

        try
        {
            return utf8.decode(bytes);
        }
        on FormatException catch (e)
        {
            throw DartFormatException.error('Input on stdin is not valid UTF-8. dart_format only accepts UTF-8 encoded input. (${e.message})');
        }
    }
}
