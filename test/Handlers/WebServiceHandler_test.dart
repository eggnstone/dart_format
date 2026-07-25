import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/Handlers/WebServiceHandler.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('WebServiceHandler', ()
        {
            late WebServiceHandler handler;
            late Future<int> handlerExit;
            late int boundPort;

            setUp(()
                async
                {
                    handler = WebServiceHandler(port: 0, skipVersionCheck: true);
                    handlerExit = handler.run();
                    boundPort = await handler.ready;
                }
            );

            tearDown(()
                async
                {
                    final HttpClient client = HttpClient();
                    try
                    {
                        final HttpClientRequest request = await client.getUrl(Uri.parse('http://127.0.0.1:$boundPort/quit'));
                        final HttpClientResponse response = await request.close();
                        await response.drain<void>();
                    }
                    finally
                    {
                        client.close(force: true);
                    }

                    await handlerExit;
                }
            );

            test('POST /format with oversize Content-Length is rejected with 413', ()
                async
                {
                    final HttpClient client = HttpClient();
                    try
                    {
                        final HttpClientRequest request = await client.postUrl(Uri.parse('http://127.0.0.1:$boundPort/format'));
                        request.headers.contentType = ContentType('multipart', 'form-data', parameters: <String, String>{'boundary': '----X'});
                        request.contentLength = Constants.MAX_REQUEST_BODY_SIZE_IN_BYTES + 1;
                        request.add(List<int>.filled(Constants.MAX_REQUEST_BODY_SIZE_IN_BYTES + 1, 0x41));

                        final HttpClientResponse response = await request.close();
                        await response.drain<void>();

                        expect(response.statusCode, HttpStatus.requestEntityTooLarge);
                    }
                    finally
                    {
                        client.close(force: true);
                    }
                }
            );

            test('POST /format without Content-Length (chunked) is rejected with 411', ()
                async
                {
                    final HttpClient client = HttpClient();
                    try
                    {
                        final HttpClientRequest request = await client.postUrl(Uri.parse('http://127.0.0.1:$boundPort/format'));
                        request.headers.contentType = ContentType('multipart', 'form-data', parameters: <String, String>{'boundary': '----X'});
                        // Leaving contentLength unset forces chunked transfer encoding.
                        request.add(<int>[0x41, 0x42, 0x43]);

                        final HttpClientResponse response = await request.close();
                        await response.drain<void>();

                        expect(response.statusCode, HttpStatus.lengthRequired);
                    }
                    finally
                    {
                        client.close(force: true);
                    }
                }
            );

            test('POST /format with a valid Config formats the text', ()
                async
                {
                    final _FormatResponse response = await _postFormat(boundPort, '{"IndentationSpacesPerLevel": 2}', 'class C\n{\n    int x = 1;\n}\n');

                    expect(response.result, equals('OK'));
                    expect(response.exception, isNull);
                    expect(response.body, contains('  int x = 1;'));
                }
            );

            // The validation message is multi-line, and it travels in an HTTP
            // header — so this also pins down that jsonEncode keeps it legal there.
            test('POST /format with a camelCase option name fails with the suggestion in the header', ()
                async
                {
                    final _FormatResponse response = await _postFormat(boundPort, '{"indentationSpacesPerLevel": 2}', 'class C\n{\n}\n');

                    expect(response.result, equals('Fail'));
                    expect(response.exception, contains(r'Did you mean \"IndentationSpacesPerLevel\"?'));
                }
            );

            test('GET /status with non-loopback Host is rejected with 403', ()
                async
                {
                    final int statusCode = await _getStatusCodeWithHost(boundPort, '/status', 'evil.example');
                    expect(statusCode, HttpStatus.forbidden);
                }
            );

            test('GET /quit with non-loopback Host is rejected with 403 and does not terminate the server', ()
                async
                {
                    final int rejectedStatusCode = await _getStatusCodeWithHost(boundPort, '/quit', 'evil.example');
                    expect(rejectedStatusCode, HttpStatus.forbidden);

                    // Server should still respond to a legitimate request.
                    final int legitStatusCode = await _getStatusCodeWithHost(boundPort, '/status', '127.0.0.1');
                    expect(legitStatusCode, HttpStatus.ok);
                }
            );
        }
    );

    // Note: no automated test for requestTimeout. Future.timeout doesn't cancel
    // the inner future, so any test that forces a timeout leaves the inner work
    // running until it trips over the now-closed request/response — which dart
    // test reports as a late error. Verified manually instead. The wiring is a
    // single `await ... .timeout(d)` + `on TimeoutException catch` in
    // `WebServiceHandler._handlePostFormat`.
}

/// The interesting parts of a `POST /format` response: the `X-DartFormat-Result`
/// and `X-DartFormat-Exception` headers plus the body.
typedef _FormatResponse = ({String? result, String? exception, String body});

Future<_FormatResponse> _postFormat(int port, String configText, String text)
async
{
    const String boundary = '----X';
    const String partHeaders = 'Content-Type: text/plain; charset=utf-8';
    final String body = '--$boundary\r\n'
        '$partHeaders\r\n'
        'Content-Disposition: form-data; name="Config"\r\n'
        '\r\n'
        '$configText\r\n'
        '--$boundary\r\n'
        '$partHeaders\r\n'
        'Content-Disposition: form-data; name="Text"\r\n'
        '\r\n'
        '$text\r\n'
        '--$boundary--\r\n';
    final List<int> bytes = utf8.encode(body);

    final HttpClient client = HttpClient();
    try
    {
        final HttpClientRequest request = await client.postUrl(Uri.parse('http://127.0.0.1:$port/format'));
        request.headers.contentType = ContentType('multipart', 'form-data', parameters: <String, String>{'boundary': boundary});
        request.contentLength = bytes.length;
        request.add(bytes);

        final HttpClientResponse response = await request.close();
        final String responseBody = await utf8.decodeStream(response);
        return (
            result: response.headers.value('x-dartformat-result'),
            exception: response.headers.value('x-dartformat-exception'),
            body: responseBody
        );
    }
    finally
    {
        client.close(force: true);
    }
}

Future<int> _getStatusCodeWithHost(int port, String path, String hostHeader)
async
{
    final HttpClient client = HttpClient();
    try
    {
        final HttpClientRequest request = await client.getUrl(Uri.parse('http://127.0.0.1:$port$path'));
        request.headers.set('host', hostHeader);
        final HttpClientResponse response = await request.close();
        await response.drain<void>();
        return response.statusCode;
    }
    finally
    {
        client.close(force: true);
    }
}
