import 'dart:io';

import '../Config.dart';
import '../Formatter.dart';
import '../Tools/LogTools.dart';

class DefaultHandler
{
    final List<String> fileNames;
    final bool isDryRun;
    final String? configText;

    DefaultHandler({required this.fileNames, required this.isDryRun, this.configText});

    Future<int> run()
    async
    {
        final Config config = Config.fromJson(configText);
        final Formatter formatter = Formatter(config);
        for (final String fileName in fileNames)
        {
            writelnToStdOut('  Processing $fileName');

            final File inputFile = File(fileName);
            final String inputText = inputFile.readAsStringSync();
            final String result = formatter.format(inputText);

            final File outputFile = isDryRun ? File('$fileName.formatted.dart') : inputFile;
            outputFile.writeAsStringSync(result);
        }

        return 0;
    }
}
