import 'dart:convert';
import 'dart:io';

import '../Constants/Constants.dart';
import '../Constants/ExitCodes.dart';
import '../Data/Config.dart';
import '../Exceptions/DartFormatException.dart';
import '../Formatter.dart';
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

        final bool isNewerVersionAvailable = await VersionTools().isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);
        final int exitCodeForSuccess = isNewerVersionAvailable ? ExitCodes.SUCCESS_AND_NEW_VERSION_AVAILABLE : ExitCodes.SUCCESS;        

        try
        {
            final Config config = Config.fromJsonText(configText);
            final Formatter formatter = Formatter(config);
            final String inputText = await _readInput();
            final String formattedText = formatter.format(inputText);
            writeToStdOut(formattedText, preventLoggingToTempFile: true);

            _logDebug('$METHOD_NAME END with SUCCESS');
            return exitCodeForSuccess;
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
            writelnToStdErr('${dartFormatException.type.name}: ${dartFormatException.message}');

        _logDebug('$METHOD_NAME END with ERROR');
        return ExitCodes.ERROR;
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
