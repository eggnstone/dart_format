import 'dart:io';

import '../Config.dart';
import '../Constants/Generated/VersionConstants.dart';
import '../Data/Version.dart';
import '../Formatter.dart';
import '../Tools/LogTools.dart';

class DefaultHandler
{
    final String? configText;
    final List<String> fileNames;
    final bool isDryRun;
    final Version? latestVersion;

    DefaultHandler({
        required this.fileNames,
        required this.isDryRun,
        this.configText,
        this.latestVersion
    });

    Future<int> run()
    async
    {
        if (VersionConstants.VERSION.isOlderThan(latestVersion))
        {
            writelnToStdOut('  ! Newer version available:');
            writelnToStdOut('    Current version: ${VersionConstants.VERSION}');
            writelnToStdOut('    Latest Version:  $latestVersion');
            writelnToStdOut('    Update here:     https://pub.dev/packages/dart_format');
        }
        else if (latestVersion != null)
            writelnToStdOut('  ✓ You are using the latest version: $latestVersion');

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
