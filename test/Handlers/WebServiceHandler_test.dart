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
        }
    );
}
