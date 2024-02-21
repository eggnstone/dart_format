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
import '../Tools/ContentTypeTools.dart';
import '../Tools/HttpTools.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
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

            /*stdin.handleError(
            (Object error, StackTrace stackTrace)
            {
            logError('$METHOD_NAME: Quitting because stdin.handleError()/onError called: $error');
            terminate = true;
            terminateWithError = true;
            }
            );*/

            stdin.listen(
                (List<int> event)
                {
                    final String input = systemEncoding.decode(event);
                    logDebug('$METHOD_NAME: Unexpected input via stdin.listen()/onData: ${StringTools.toDisplayString(input, Constants.MAX_DEBUG_LENGTH)}');
                }
                ,
                onDone: ()
                {
                    logDebug('$METHOD_NAME: Quitting because stdin.listen()/onDone called.');
                    terminate = true;
                }
                ,
                onError: (Object error, StackTrace stackTrace)
                {
                    logError('$METHOD_NAME: Quitting because stdin.listen()/onError called: $error');
                    terminate = true;
                    terminateWithError = true;
                }
            );

            while (!terminate)
                await Future<void>.delayed(const Duration(milliseconds: Constants.WEB_SERVICE_HANDLER_WAIT_FOR_TERMINATE_IN_MILLISECONDS));

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
        return HttpTools.flushAndClose(request);
    }

    Future<void> _handleGetFavIcon(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.binary;
        await request.response.addStream(File('assets/favicon.ico').openRead());
        return HttpTools.flushAndClose(request);
    }

    Future<void> _handleGetFormat(HttpRequest request)
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.text;
        request.response.writeln('You need to use POST to access /format');
        return HttpTools.flushAndClose(request);
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
        return HttpTools.flushAndClose(request);
    }

    Future<void> _handleGetQuit(HttpRequest request, {Function()? onQuit})
    async
    {
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.html;
        request.response.writeln(_getHtmlStart('Quit'));
        request.response.writeln('<b>dart_format is terminating ...</b>');
        request.response.writeln(_getHtmlEnd());
        await HttpTools.flushAndClose(request);
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
        return HttpTools.flushAndClose(request);
    }

    Future<void> _handlePostFormat(HttpRequest request)
    async
    {
        const String METHOD_NAME = '$CLASS_NAME._handlePostFormat';
        //logDebug('$METHOD_NAME: Request: ${request.contentLength}');

        try
        {
            //logDebug('Request.contentLength: request.contentLength: ${request.contentLength}');

            final List<String>? contentTypeList = request.headers['content-type'];
            //logDebug('contentTypeList: $contentTypeList');
            final String? contentType = contentTypeList?.first;
            //logDebug('contentType: $contentType');
            if (contentType == null)
                throw DartFormatException.error('No content-type header found.');

            final String? boundary = ContentTypeTools.getBoundary(contentType);
            //logDebug('boundary: $boundary');
            if (boundary == null)
                throw DartFormatException.error('No boundary found.');

            final Stream<MimeMultipart> mimeMultiPartStreams = MimeMultipartTransformer(boundary).bind(request);

            final List<MimeMultipart> mimeMultiParts = await mimeMultiPartStreams.toList();
            //logDebug('mimeMultiParts: ${mimeMultiParts.length}');
            if (mimeMultiParts.length != 2)
                throw DartFormatException.error('Expected 2 parts, got ${mimeMultiParts.length}.');

            //logDebug('mimeMultiParts[0].headers: ${mimeMultiParts[0].headers}');
            final String? contentType0 = mimeMultiParts[0].headers['content-type'];
            //logDebug('contentType0: $contentType0');
            final String? charset0 = ContentTypeTools.getCharset(contentType0);
            //logDebug('charset0: $charset0');

            //logDebug('mimeMultiParts[1].headers: ${mimeMultiParts[1].headers}');
            final String? contentType1 = mimeMultiParts[1].headers['content-type'];
            //logDebug('contentType1: $contentType1');
            final String? charset1 = ContentTypeTools.getCharset(contentType1);
            //logDebug('charset1: $charset1');

            final Encoding? encoding0 = Encoding.getByName(charset0);
            final Encoding? encoding1 = Encoding.getByName(charset1);

            if (encoding0 == null)
                throw DartFormatException.error('Cannot find decoder for charset "$charset0".');

            if (encoding1 == null)
                throw DartFormatException.error('Cannot find decoder for charset "$charset1".');

            final String mimeMultiPart0 = await encoding0.decodeStream(mimeMultiParts[0]);
            final String mimeMultiPart1 = await encoding1.decodeStream(mimeMultiParts[1]);

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
            //logDebug('text: ${StringTools.toDisplayString(text)}');

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
        on DartFormatException catch (e, st)
        {
            logErrorObject(METHOD_NAME, e, st);
            request.response.statusCode = HttpStatus.ok;
            request.response.headers.contentType = ContentType.text;
            request.response.headers.add('X-DartFormat-Result', 'Fail');
            request.response.headers.add('X-DartFormat-Exception', jsonEncode(e.toJson()));
        }
        on Exception catch (e, st)
        {
            logErrorObject(METHOD_NAME, e, st);
            final DartFormatException dartFormatException = DartFormatException.error(e.toString());
            request.response.statusCode = HttpStatus.ok;
            request.response.headers.contentType = ContentType.text;
            request.response.headers.add('X-DartFormat-Result', 'Fail');
            request.response.headers.add('X-DartFormat-Exception', jsonEncode(dartFormatException.toJson()));
        }
        /*// ignore: avoid_catching_errors
        on Error catch (e, st)
        {
        // necessary?
        logErrorObject(METHOD_NAME, e, st);

        final DartFormatException dartFormatException = DartFormatException.error(e.toString());
        request.response.statusCode = HttpStatus.ok;
        request.response.headers.contentType = ContentType.text;
        request.response.headers.add('X-DartFormat-Result', 'Fail');
        request.response.headers.add('X-DartFormat-Exception', jsonEncode(dartFormatException.toJson()));
        }*/
        finally
        {
            //logDebug('$METHOD_NAME: Calling flushAndClose');
            await HttpTools.flushAndClose(request);
        }
    }

    Future<void> _handleRequest(HttpRequest request, {Function()? onQuit})
    async
    {
        const String METHOD_NAME = '$CLASS_NAME._handleRequest';
        final DateTime startTime = DateTime.now();

        final int requestCount = ++_requestCount;
        logDebug('$METHOD_NAME START #$requestCount: ${request.method} ${request.uri}');

        // TODO: timeout?
        try
        {
            if (request.method == 'GET')
            {
                await _handleGet(request, onQuit: onQuit);
            }
            else if (request.method == 'POST')
            {
                await _handlePost(request);
            }
            else
            {
                request.response.statusCode = HttpStatus.badRequest;
                await HttpTools.flushAndClose(request);
            }
        }
        on Exception catch (e)
        {
            logError('$METHOD_NAME Exception: $e');
            writelnToStdErr('Exception: $e');
            request.response.statusCode = HttpStatus.internalServerError;
            request.response.headers.contentType = ContentType.text;
            request.response.writeln('Exception: $e');
            await HttpTools.flushAndClose(request);
        }
        /*// ignore: avoid_catching_errors
        on Error catch (e, st)
        {
        // necessary?
        logErrorObject(METHOD_NAME, e, st);
        }*/
        finally
        {
            logDebug('$METHOD_NAME END   #$requestCount: ${request.method} ${request.uri} took ${DateTime.now().difference(startTime).inMilliseconds / 1000}s');
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
        await HttpTools.flushAndClose(request);
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
