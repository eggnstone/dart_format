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
    final bool isDryRun;
    final bool skipVersionCheck;

    DefaultHandler({
        required this.fileNames,
        required this.isCheck,
        required this.isDryRun,
        required this.skipVersionCheck,
        this.configText
    });

    Future<int> run()
    async
    {
        const String METHOD_NAME = '$CLASS_NAME.run';
        _logDebug('$METHOD_NAME START');

        InfoTools.writeCopyrightToStdOut();

        final bool isNewerVersionAvailable = await VersionTools(writeToStdOut: true).isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);
        final int exitCodeForSuccess = isNewerVersionAvailable ? ExitCodes.SUCCESS_AND_NEW_VERSION_AVAILABLE : ExitCodes.SUCCESS;

        final bool noWriteMode = isCheck || isDryRun;

        final Config config = Config.fromJsonText(configText);
        final Formatter formatter = Formatter(config);
        int wouldChangeCount = 0;
        int unchangedCount = 0;
        for (final String fileName in fileNames)
        {
            if (!noWriteMode)
                writelnToStdOut('  Processing $fileName');

            final File inputFile = File(fileName);
            final String inputText = inputFile.readAsStringSync();
            final String result = formatter.format(inputText);
            final bool wouldChange = result != inputText;

            if (noWriteMode)
            {
                if (wouldChange)
                {
                    wouldChangeCount++;
                    writelnToStdOut('would format $fileName');
                }
                else
                {
                    unchangedCount++;
                }
                continue;
            }

            if (!wouldChange)
                continue;

            inputFile.writeAsStringSync(result);
        }

        if (noWriteMode)
            writelnToStdOut('$wouldChangeCount file(s) would be reformatted, $unchangedCount left unchanged.');

        if (isCheck && wouldChangeCount > 0)
        {
            _logDebug('$METHOD_NAME with CHECK_FAILURE');
            return ExitCodes.ERROR;
        }

        _logDebug('$METHOD_NAME with SUCCESS');
        return exitCodeForSuccess;
    }

    void _logDebug(String s)
    {
        if (Constants.DEBUG_DART_FORMAT_HANDLERS)
            logDebug(s);
    }
}
