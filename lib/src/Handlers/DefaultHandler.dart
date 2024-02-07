import 'dart:io';

import '../Config.dart';
import '../Constants/ExitCodes.dart';
import '../Formatter.dart';
import '../Tools/LogTools.dart';
import '../Tools/VersionTools.dart';

class DefaultHandler
{
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
        logDebug('DefaultHandler.run START');

        final bool isNewerVersionAvailable = await VersionTools(writeToStdOut: true).isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);
        final int exitCodeForSuccess = isNewerVersionAvailable ? ExitCodes.SUCCESS_AND_NEW_VERSION_AVAILABLE : ExitCodes.SUCCESS;

        final Config config = Config.fromJson(configText);
        final Formatter formatter = Formatter(config);
        for (final String fileName in fileNames)
        {
            writelnToStdOut('  Processing $fileName');

            final File inputFile = File(fileName);
            final String inputText = inputFile.readAsStringSync();
            final String result = formatter.format(inputText);
            if (result == inputText && !isDryRun)
            {
                //logDebug('    No changes made.');
                continue;
            }

            final File outputFile = isDryRun ? File('$fileName.formatted.dart') : inputFile;
            outputFile.writeAsStringSync(result);
        }

        logDebug('DefaultHandler.run END with SUCCESS');
        return exitCodeForSuccess;
    }
}
