import 'dart:convert';

import 'package:http/http.dart' as Http; // ignore: library_prefixes

import '../Constants/Generated/VersionConstants.dart';
import '../Data/Version.dart';
import 'JsonTools.dart';
import 'LogTools.dart';

class VersionTools
{
    static const String DART_FORMAT_VERSIONS_URL = 'https://pub.dartlang.org/packages/dart_format.json';

    final bool writeToStdOut;

    bool _alreadyCheckForLatestVersion = false;
    Version? _latestVersion;

    VersionTools({this.writeToStdOut = false});

    Future<bool> isNewerVersionAvailable({required bool skipVersionCheck})
    async
    {
        if (skipVersionCheck)
            return false;

        final Version? latestVersion = await getLatestVersion(skipVersionCheck: skipVersionCheck);
        if (latestVersion == null)
            return false;

        if (VersionConstants.VERSION.isOlderThan(latestVersion))
        {
            _log('! Newer version available:');
            _log('  Current version: ${VersionConstants.VERSION}');
            _log('  Latest Version:  $latestVersion');
            _log('  Update here:     https://pub.dev/packages/dart_format/install');
            return true;
        }

        _log('OK: You are using the latest version: dart_format $latestVersion');
        return false;
    }

    Future<Version?> getLatestVersion({required bool skipVersionCheck})
    async
    {
        if (skipVersionCheck)
            return null;

        if (_alreadyCheckForLatestVersion)
            return _latestVersion;

        _alreadyCheckForLatestVersion = true;

        try
        {
            final Http.Response response = await Http.get(Uri.parse(DART_FORMAT_VERSIONS_URL));
            //logDebug('Response: ${response.body}');
            final Map<String, dynamic> json = jsonDecode(response.body);
            //logDebug('json: $json');
            final String version = JsonTools.getOrThrow<List<dynamic>>(json, 'versions')[0];
            //logDebug('version: $version');

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
