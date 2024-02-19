import 'dart:io';

class HttpTools
{
    static Future<void> flushAndClose(HttpRequest request)
    async
    {
        //logDebug('Flushing response');
        await request.response.flush();

        //logDebug('Closing response');
        await request.response.close();
    }
}
