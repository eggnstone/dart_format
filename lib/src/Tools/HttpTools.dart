import 'dart:io';

import 'LogTools.dart';

class HttpTools
{
    static Future<void> flushAndClose(HttpRequest request)
    async
    {
        logDebug('Flushing response');
        await request.response.flush();

        logDebug('Waiting 100ms before closing response');
        await Future<void>.delayed(const Duration(milliseconds: 100));

        logDebug('Closing response');
        await request.response.close();

        logDebug('Response closed');
    }
}
