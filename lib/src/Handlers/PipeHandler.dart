import 'dart:convert';
import 'dart:io';

import '../Config.dart';
import '../ErrorCodes.dart';
import '../Exceptions/DartFormatException.dart';
import '../Formatter.dart';
import '../Tools/LogTools.dart';

class PipeHandler
{
    final String? configText;
    final bool errorsAsJson;

    PipeHandler(this.configText, {required this.errorsAsJson});

    Future<int> run()
    async
    {
        DartFormatException? dartFormatException;

        try
        {
            final String inputText = _readInput();
            if (inputText.isEmpty) 
                return 0;

            final Config config = Config.fromJson(configText);
            final Formatter formatter = Formatter(config);
            final String formattedText = formatter.format(inputText);
            if (formattedText.isEmpty)
                throw DartFormatException.error('No output generated.');

            writeToStdOut(formattedText, preventLoggingToTempFile: true);
            return 0;
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

        return ErrorCodes.PIPE_HANDLER__FAIL;
    }

    String _readInput()
    {
        final StringBuffer sb = StringBuffer();
        String? inputLine;

        while ((inputLine = stdin.readLineSync(encoding: utf8, retainNewlines: true)) != null)
            sb.write(inputLine);

        return sb.toString();
    }
}
