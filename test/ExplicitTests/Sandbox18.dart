/*
2024-12-08 12:29:26.040 Debug:  WebServiceHandler.handleRequest START #1107: POST /format
2024-12-08 12:29:26.054 Error:  In WebServiceHandler.handlePostFormat
DartFormatException(message: Expected to find '}'., type: FailType.warning, line: 166, column: 4)
#0      Formatter._logAndThrowWarning (package:dart_format/src/Formatter.dart:76:9)
#1      Formatter.format (package:dart_format/src/Formatter.dart:43:13)
#2      WebServiceHandler._handlePostFormat (package:dart_format/src/Handlers/WebServiceHandler.dart:311:52)
<asynchronous suspension>
#3      WebServiceHandler._handleRequest (package:dart_format/src/Handlers/WebServiceHandler.dart:376:17)
<asynchronous suspension>

2024-12-08 12:29:26.056 Debug:  WebServiceHandler.handleRequest END   #1107: POST /format took 0.015s (6.35 kChars, 2.36 ms/kChar, max: 73.65 ms/kChar)
*/
