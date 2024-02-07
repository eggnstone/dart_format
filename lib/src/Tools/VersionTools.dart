import 'dart:convert';

import 'package:http/http.dart' as Http; // ignore: library_prefixes

import '../Constants/Generated/VersionConstants.dart';
import '../Data/Version.dart';
import 'LogTools.dart';

class VersionTools
{
    static const String DART_FORMAT_VERSIONS_URL = 'https://pub.dartlang.org/packages/dart_format.json';

    final bool writeToStdOut;

    VersionTools({this.writeToStdOut = false});

    Future<bool> isNewerVersionAvailable({required bool skipVersionCheck})
    async
    {
        if (skipVersionCheck)
            return false;

        final Version? latestVersion =  await _getLatestVersion();
        if (latestVersion == null)
            return false;

        if (VersionConstants.VERSION.isOlderThan(latestVersion))
        {
            _log('! Newer version available:');
            _log('  Current version: ${VersionConstants.VERSION}');
            _log('  Latest Version:  $latestVersion');
            _log('  Update here:     https://pub.dev/packages/dart_format');
            return true;
        }

        _log('OK: You are using the latest version: dart_format $latestVersion');
        return false;
    }

    Future<Version?> _getLatestVersion()
    async
    {
        try
        {
            final Http.Response response = await Http.get(Uri.parse(DART_FORMAT_VERSIONS_URL));
            //logDebug('Response: ${response.body}');
            final Map<String, dynamic> json = jsonDecode(response.body);
            final String version = json['versions'][0];

            return Version.parse(version);
        }
        catch (e)
        {
            logError('VersionChecker.getLatestVersion: $e');
            return null;
        }
    }

    void _log(String s)
    {
        if (writeToStdOut)
            writelnToStdOut(s);
        else
            logDebug(s);
    }
}
