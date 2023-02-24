import 'dart:developer' as developer;

import 'package:intl/intl.dart';

DateFormat _dateFormat = DateFormat('HH:mm:ss');

bool isLoggerEnabled = true;
bool useNewLogger = false; //kDebugMode;
String? logColors;
bool _isWeb = false;

void initLog({required bool isWeb})
=> _isWeb = isWeb;

void logDebug(String message)
=> _log('Debug', message);

void logInfo(String message)
=> _log('Info', message);

void logWarning(String message)
=> _log('Warn', message);

void logError(String message, [Object? error])
=> _log('Error', message, error);

void _log(String level, String message, [Object? error])
{
    if (!isLoggerEnabled)
        return;

    if (useNewLogger && !_isWeb)
    {
        final String levelPadded = level.padRight(5);
        // ignore: prefer_interpolation_to_compose_strings
        developer.log(_dateFormat.format(DateTime.now()) + ' ' + message, name: levelPadded, error: error);
    }
    else
    {
        // ignore: prefer_interpolation_to_compose_strings
        final String levelWithColonPadded = (level + ':').padRight(6);
        String messageForPrint = '${_dateFormat.format(DateTime.now())} $levelWithColonPadded $message';

        if (logColors == 'Ansi')
        {
            // https://stackoverflow.com/questions/32573654/is-there-a-way-to-create-an-orange-color-from-ansi-escape-characters
            const String COLOR_DEBUG = '\x1B[38:2:48:141:108m';
            const String COLOR_INFO = '\x1B[38:2:13:113:166m';
            const String COLOR_WARN = '\x1B[38:2:255:152:0m';
            const String COLOR_ERROR = '\x1B[38:2:255:51:44m';
            const String COLOR_RESET = '\x1B[0m';
            switch (level)
            {
                case 'Debug':
                    messageForPrint = COLOR_DEBUG + messageForPrint + COLOR_RESET;
                    break;
                case 'Info':
                    messageForPrint = COLOR_INFO + messageForPrint + COLOR_RESET;
                    break;
                case 'Warn':
                    messageForPrint = COLOR_WARN + messageForPrint + COLOR_RESET;
                    break;
                case 'Error':
                    messageForPrint = COLOR_ERROR + messageForPrint + COLOR_RESET;
                    break;
            }
        }

        // ignore: avoid_print
        print(messageForPrint);
        if (error != null)
        {
            // ignore: avoid_print
            print('         $error');
        }
    }
}
