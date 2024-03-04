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
    final bool isDryRun;
    final bool skipVersionCheck;

    DefaultHandler({
        required this.fileNames,
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

        final Config config = Config.fromJsonText(configText);
        final Formatter formatter = Formatter(config);
        for (final String fileName in fileNames)
        {
            writelnToStdOut('  Processing $fileName');

            final File inputFile = File(fileName);
            final String inputText = inputFile.readAsStringSync();
            final String result = formatter.format(inputText);
            if (result == inputText && !isDryRun)
            {
                //_logDebug('    No changes made.');
                continue;
            }

            final File outputFile = isDryRun ? File('$fileName.formatted.dart') : inputFile;
            outputFile.writeAsStringSync(result);
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
