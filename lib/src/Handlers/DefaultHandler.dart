import 'dart:io';

import '../Constants/Constants.dart';
import '../Constants/ExitCodes.dart';
import '../Data/Config.dart';
import '../Formatter.dart';
import '../Tools/InfoTools.dart';
import '../Tools/LogTools.dart';
import '../Tools/VersionTools.dart';

class DefaultHandler
{
    static const String CLASS_NAME = 'DefaultHandler';

    final String? configText;
    final List<String> fileNames;
    final bool isCheck;
    final bool skipVersionCheck;

    DefaultHandler({
        required this.fileNames,
        required this.isCheck,
        required this.skipVersionCheck,
        this.configText
    });

    Future<int> run()
    async
    {
        const String METHOD_NAME = '$CLASS_NAME.run';
        _logDebug('$METHOD_NAME START');

        InfoTools.writeCopyrightToStdOut();

        // The "newer version available" notice is printed to stdout for the
        // user; the exit code stays 0 on success so scripts/CI don't trip on
        // a cosmetic upgrade prompt.
        await VersionTools(writeToStdOut: true).isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);

        final Config config = Config.fromJsonText(configText);
        final Formatter formatter = Formatter(config);
        int changedCount = 0;
        int unchangedCount = 0;
        for (final String fileName in fileNames)
        {
            final File inputFile = File(fileName);
            final String inputText = inputFile.readAsStringSync();
            final String result = formatter.format(inputText);
            final bool wouldChange = result != inputText;

            if (!wouldChange)
            {
                unchangedCount++;
                continue;
            }

            changedCount++;

            if (isCheck)
            {
                writelnToStdOut('Would format $fileName');
                continue;
            }

            inputFile.writeAsStringSync(result);
            writelnToStdOut('Formatted $fileName');
        }

        if (isCheck)
            writelnToStdOut('$changedCount file(s) would be formatted, $unchangedCount left unchanged.');
        else
            writelnToStdOut('$changedCount file(s) formatted, $unchangedCount left unchanged.');

        if (isCheck)
        {
            if (changedCount > 0)
            {
                writelnToStdOut('Check FAILED: $changedCount file(s) need formatting.');
                _logDebug('$METHOD_NAME with CHECK_FAILURE');
                return ExitCodes.FAILURE;
            }

            writelnToStdOut('Check OK: all files are already formatted.');
        }

        _logDebug('$METHOD_NAME with SUCCESS');
        return ExitCodes.SUCCESS;
    }

    void _logDebug(String s)
    {
        if (Constants.DEBUG_DART_FORMAT_HANDLERS)
            logDebug(s);
    }
}
