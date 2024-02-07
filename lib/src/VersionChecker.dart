import 'dart:convert';

import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:http/http.dart' as Http; // ignore: library_prefixes

import 'Data/Version.dart';

class VersionChecker
{
    static Future<Version?> getLatestVersion()
    async
    {
        const String versionsUrl = 'https://pub.dartlang.org/packages/dart_format.json';

        try
        {
            final Http.Response response = await Http.get(Uri.parse(versionsUrl));
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
}
