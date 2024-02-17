import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../Constants/ExitCodes.dart';
import '../Constants/Generated/VersionConstants.dart';
import '../Data/JsonResponse.dart';
import '../Data/Version.dart';
import '../Exceptions/DartFormatException.dart';
import '../Formatter.dart';
import '../Tools/LogTools.dart';
import '../Tools/VersionTools.dart';

class WebServiceHandler
{
    static const String CLASS_NAME = 'WebServiceHandler';
    static int _requestCount = 0;

    final bool skipVersionCheck;
    final DateTime _startTime = DateTime.now();

    WebServiceHandler({required this.skipVersionCheck});

    Future<int> run()
    async
    {
        const String METHOD_NAME = '$CLASS_NAME.run';

        final VersionTools versionTools = VersionTools();
        bool terminate = false;
        bool terminateWithError = false;

        _logDebug('$METHOD_NAME START');

        final Version? latestVersion = await versionTools.getLatestVersion(skipVersionCheck: skipVersionCheck);
        final bool isNewerVersionAvailable = await versionTools.isNewerVersionAvailable(skipVersionCheck: skipVersionCheck);
        final int exitCodeForSuccess = isNewerVersionAvailable ? ExitCodes.SUCCESS_AND_NEW_VERSION_AVAILABLE : ExitCodes.SUCCESS;

        try
        {
            HttpServer server;

            try
            {
                server = await HttpServer.bind(InternetAddress.loopbackIPv4, Constants.PREFERRED_PORT);
            }
            on SocketException
            {
                server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
            }

            server.handleError(_handleServerError);

            const String protocol = 'http';
            final String message = '$protocol://${server.address.address}:${server.port}';
            final String currentVersion = VersionConstants.VERSION.toString();
            final JsonResponse jsonResponse = JsonResponse(
                statusCode: 200, 
                status: 'OK', 
                currentVersion: currentVersion,
                latestVersion: latestVersion?.toString(),
                message: message 
            );
            writelnToStdOut(jsonEncode(jsonResponse.toJson()));

            server.listen(
                (HttpRequest request) => _handleRequest(request, onQuit: ()
                    {
                        logDebug('$METHOD_NAME: Quitting because server.listen()/onQuit called.');
                        terminate = true;
                    }
                ),
                onDone: ()
                {
                    logDebug('$METHOD_NAME: Quitting because server.listen()/onDone called.');
                    terminate = true;
                }
                ,
                onError: (Object error, StackTrace stackTrace)
                {
                    logError('$METHOD_NAME: Quitting because server.listen()/onError called: $error');
                    terminate = true;
                    terminateWithError = true;
                }
            );

            stdin.handleError(
                (Object error, StackTrace stackTrace)
                {
                    logError('$METHOD_NAME: Quitting because stdin.handleError()/onError called: $error');
                    terminate = true;
                    terminateWithError = true;
                }
            );

            while (!terminate)
                await Future<void>.delayed(const Duration(milliseconds: 500));

            if (terminateWithError)
            {
                _logDebug('$METHOD_NAME END with ERROR');
                return ExitCodes.ERROR;
            }

            _logDebug('$METHOD_NAME END with SUCCESS');
            return exitCodeForSuccess;
        }
        catch (e)
        {
            writelnToStdErr(e.toString());
            _logDebug('$METHOD_NAME END with ERROR');
            return ExitCodes.ERROR;
        }
    }

    Future<void> _handleGet(HttpRequest request, {Function()? onQuit})
    async
    {
        if (request.uri.path == '/')
            return _handleRoot(request);

        if (request.uri.path == '/favicon.ico')
            return _handleGetFavIcon(request);

        if (request.uri.path == '/format')
            return _handleGetFormat(request);

        if (request.uri.path == '/status')
            return _handleGetStatus(request);

        if (request.uri.path == '/quit')
            return _handleGetQuit(request, onQuit: onQuit);

        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
    }

    Future<void> _handleGetFavIcon(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.binary;
        await request.response.addStream(File('assets/favicon.ico').openRead());
        await request.response.close();
    }

    Future<void> _handleGetFormat(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.text;
        request.response.writeln('You need to use POST to access /format');
        await request.response.close();
    }

    Future<void> _handleGetStatus(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.html;
        request.response.writeln(_getHtmlStart('Status'));
        request.response.writeln('<b>dart_format is ready.</b>');
        request.response.writeln('<p>Started at: $_startTime</p>');
        request.response.writeln('<p>Uptime: ${DateTime.now().difference(_startTime)}</p>');
        request.response.writeln(_getHtmlEnd());
        await request.response.close();
    }

    Future<void> _handleGetQuit(HttpRequest request, {Function()? onQuit})
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.html;
        request.response.writeln(_getHtmlStart('Quit'));
        request.response.writeln('<b>dart_format is terminating ...</b>');
        request.response.writeln(_getHtmlEnd());
        await request.response.close();
        await Future<void>.delayed(const Duration(milliseconds: 100));
        onQuit?.call();
    }

    Future<void> _handlePost(HttpRequest request)
    async
    {
        //logDebug('WebServiceHandler._handlePost: Request: ${request.contentLength}');

        if (request.uri.path == '/')
            return _handleRoot(request);

        if (request.uri.path == '/format')
            return _handlePostFormat(request);

        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
    }

    Future<void> _handlePostFormat(HttpRequest request)
    async
    {
        const String METHOD_NAME = '$CLASS_NAME._handlePostFormat';
        logDebug('$METHOD_NAME: Request: ${request.contentLength}');

        try
        {
            //logDebug('Request.contentLength: request.contentLength: ${request.contentLength}');

            /*final Stream<Uint8List> x = request;

            final String body = await utf8.decodeStream(request);*/
            /*writelnToStdErr(body);
            writelnToStdErr('request.headers: ${request.headers}');
            writelnToStdErr('body.length: ${body.length}');*/

            final RegExp boundaryGet = RegExp(' boundary=(.+) ');
            final String? contentType = request.headers['content-type']?.first;
            if (contentType == null)
                throw DartFormatException.error('No content-type header found.');

            //logDebug('contentType: $contentType');
            final RegExpMatch? match = boundaryGet.firstMatch(' $contentType ');

            final String? boundary = match?.group(1);
            //logDebug('boundary: $boundary');
            if (boundary == null)
                throw DartFormatException.error('No boundary found.');

            final Stream<MimeMultipart> mimeMultiPartStreams = MimeMultipartTransformer(boundary).bind(request);

            final List<MimeMultipart> mimeMultiParts = await mimeMultiPartStreams.toList();
            //logDebug('mimeMultiParts: ${mimeMultiParts.length}');
            if (mimeMultiParts.length != 2)
                throw DartFormatException.error('Expected 2 parts, got ${mimeMultiParts.length}.');

            final String mimeMultiPart0 = await utf8.decodeStream(mimeMultiParts[0]);
            final String mimeMultiPart1 = await utf8.decodeStream(mimeMultiParts[1]);

            String? configText;
            String? text;

            if (mimeMultiParts[0].headers['content-disposition'] == 'form-data; name="Config"')
                configText = mimeMultiPart0;
            else if (mimeMultiParts[1].headers['content-disposition'] == 'form-data; name="Config"')
                configText = mimeMultiPart1;

            if (configText == null)
                throw DartFormatException.error('No part named "Config" found.');

            if (configText.isEmpty)
                throw DartFormatException.error('Part named "Config" is empty.');

            if (mimeMultiParts[0].headers['content-disposition'] == 'form-data; name="Text"')
                text = mimeMultiPart0;
            else if (mimeMultiParts[1].headers['content-disposition'] == 'form-data; name="Text"')
                text = mimeMultiPart1;

            if (text == null)
                throw DartFormatException.error('No part named "Text" found .');

            if (text.isEmpty)
                throw DartFormatException.error('Part named "Text" is empty.');

            //logDebug('configText: ${StringTools.toDisplayString(configText)}');
            final Config config = Config.fromJson(configText);
            final Formatter formatter = Formatter(config);
            final String formattedText = formatter.format(text);
            if (formattedText.isEmpty)
                throw DartFormatException.error('No output generated.');

            //logDebug('Sending formatted text: ${StringTools.toDisplayString(formattedText, Constants.MAX_DEBUG_LENGTH)}');

            request.response.statusCode = HttpStatus.ok;
            request.response.headers.contentType = ContentType.text;
            request.response.headers.add('X-DartFormat-Result', 'OK');
            request.response.write(formattedText);
        }
        on DartFormatException catch (e)
        {
            request.response.statusCode = HttpStatus.ok;
            request.response.headers.contentType = ContentType.text;
            request.response.headers.add('X-DartFormat-Result', 'Fail');
            request.response.headers.add('X-DartFormat-Exception', jsonEncode(e.toJson()));
        }
        on Exception catch (e)
        {
            final DartFormatException dartFormatException = DartFormatException.error(e.toString());
            request.response.statusCode = HttpStatus.ok;
            request.response.headers.contentType = ContentType.text;
            request.response.headers.add('X-DartFormat-Result', 'Fail');
            request.response.headers.add('X-DartFormat-Exception', jsonEncode(dartFormatException.toJson()));
        }

        await request.response.close();
    }

    Future<void> _handleRequest(HttpRequest request, {Function()? onQuit})
    async
    {
        const String METHOD_NAME = '$CLASS_NAME._handleRequest';
        final DateTime startTime = DateTime.now();

        _requestCount++;
        logDebug('$METHOD_NAME START #$_requestCount: ${request.method} ${request.uri}');

        // TODO: timeout?
        try
        {
            if (request.method == 'GET')
                return _handleGet(request, onQuit: onQuit);

            if (request.method == 'POST')
                return _handlePost(request);

            request.response.statusCode = HttpStatus.badRequest;
            await request.response.close();
        }
        on Exception catch (e)
        {
            writelnToStdErr('Exception: $e');
            request.response.statusCode = HttpStatus.internalServerError;
            request.response.headers.contentType = ContentType.text;
            request.response.writeln('Exception: $e');
            await request.response.close();
        }
        finally
        {
            logDebug('$METHOD_NAME END   #$_requestCount: ${request.method} ${request.uri} took ${DateTime.now().difference(startTime).inMilliseconds / 1000}s');
        }
    }

    Future<void> _handleRoot(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.html;
        request.response.writeln(_getHtmlStart(''));
        request.response.writeln('<p>Available GET endpoints:</p>');
        request.response.writeln('<ul>');
        request.response.writeln('<li>Get the status of the service: <a href="/status">/status</a></li>');
        request.response.writeln('<li>Terminate the service: <a href="/quit">/quit</a></li>');
        request.response.writeln('</ul>');
        request.response.writeln('<p>Available POST endpoints:</p>');
        request.response.writeln('<ul>');
        request.response.writeln('<li>');
        request.response.writeln('Format some text: <a href="/format">/format</a><br>');
        request.response.writeln('Expects a multipart body:<br><ul>');
        request.response.writeln('<li>Config as JSON in a part named "Config".</li>');
        request.response.writeln('<li>Text in a part named "Text".</li>');
        request.response.writeln('</ul></li>');
        request.response.writeln('</ul>');
        request.response.writeln(_getHtmlEnd());
        await request.response.close();
    }

    void _handleServerError(Object error, StackTrace stackTrace)
    {
        logErrorObject('WebServiceHandler._handleServerError', error, stackTrace);
    }

    String _getHtmlStart(String s)
    => '''
    <html lang="en">
    <head>
    <title>dart_format $s</title>
    </head>
    <body>
    <h1 style="text-align: center; font-family: monospace;"><!--suppress HtmlUnknownTarget --><img style="vertical-align: middle;" alt="Logo" src="/favicon.ico">&nbsp;&nbsp;dart_format $s</h1>
    ''';

    String _getHtmlEnd()
    => '</body></html>';

    void _logDebug(String s)
    {
        if (Constants.DEBUG_DART_FORMAT_HANDLERS)
            logDebug(s);
    }
}
