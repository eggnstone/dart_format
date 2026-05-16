import 'dart:async';
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

    test('WebServiceHandler POST /format that exceeds requestTimeout returns a timeout DartFormatException', ()
        async
        {
            final WebServiceHandler tinyHandler = WebServiceHandler(
                port: 0,
                skipVersionCheck: true,
                requestTimeout: Duration.zero
            );
            final Future<int> exit = tinyHandler.run();
            final int port = await tinyHandler.ready;

            try
            {
                const String boundary = 'X';
                const String body =
                    '--X\r\n'
                    'Content-Disposition: form-data; name="Config"\r\n'
                    'Content-Type: text/plain; charset=utf-8\r\n'
                    '\r\n'
                    '{}\r\n'
                    '--X\r\n'
                    'Content-Disposition: form-data; name="Text"\r\n'
                    'Content-Type: text/plain; charset=utf-8\r\n'
                    '\r\n'
                    'class A {}\r\n'
                    '--X--\r\n';

                final HttpClient client = HttpClient();
                try
                {
                    final HttpClientRequest request = await client.postUrl(Uri.parse('http://127.0.0.1:$port/format'));
                    request.headers.contentType = ContentType('multipart', 'form-data', parameters: <String, String>{'boundary': boundary});
                    request.contentLength = body.length;
                    request.write(body);

                    final HttpClientResponse response = await request.close();
                    await response.drain<void>();

                    expect(response.statusCode, HttpStatus.ok);
                    expect(response.headers.value('x-dartformat-result'), 'Fail');
                    final String? exceptionJson = response.headers.value('x-dartformat-exception');
                    expect(exceptionJson, isNotNull);
                    expect(exceptionJson!.contains('timed out'), isTrue, reason: 'Expected exception message to mention timeout: $exceptionJson');
                }
                finally
                {
                    client.close(force: true);
                }
            }
            finally
            {
                final HttpClient client = HttpClient();
                try
                {
                    final HttpClientRequest request = await client.getUrl(Uri.parse('http://127.0.0.1:$port/quit'));
                    final HttpClientResponse response = await request.close();
                    await response.drain<void>();
                }
                finally
                {
                    client.close(force: true);
                }
                await exit;
            }
        }
    );
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
