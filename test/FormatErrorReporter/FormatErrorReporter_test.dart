import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/source/line_info.dart';
import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/FormatErrorReporter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

FormatErrorReporter _newReporter([String content = 'AAA\nBBBB\nCC'])
{
    final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: content, throwIfDiagnostics: false);
    return FormatErrorReporter(parseResult);
}

void main()
{
    TestTools.init();

    group('FormatErrorReporter.getLocation', ()
        {
            test('returns line/column for a valid offset', ()
                {
                    final CharacterLocation? location = _newReporter().getLocation(5);
                    expect(location, isNotNull);
                    expect(location!.lineNumber, equals(2));
                    expect(location.columnNumber, equals(2));
                }
            );
        }
    );

    group('FormatErrorReporter.getPositionInfo', ()
        {
            test('formats line and column from a valid offset', ()
                {
                    expect(_newReporter().getPositionInfo(0), equals('Line 1, column 1'));
                    expect(_newReporter().getPositionInfo(5), equals('Line 2, column 2'));
                }
            );
        }
    );

    group('FormatErrorReporter.logAndThrowError', ()
        {
            test('throws DartFormatException with the given message', ()
                {
                    final FormatErrorReporter reporter = _newReporter();
                    expect(
                        () => reporter.logAndThrowError('boom'),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', equals('boom')))
                    );
                }
            );
        }
    );

    group('FormatErrorReporter.logAndThrowErrorWithOffset', ()
        {
            test('appends position info to the message', ()
                {
                    final FormatErrorReporter reporter = _newReporter();
                    expect(
                        () => reporter.logAndThrowErrorWithOffset('Bad token:', null, 5),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', equals('Bad token: (Line 2, column 2)')))
                    );
                }
            );

            test('appends additionalText after position info when provided', ()
                {
                    final FormatErrorReporter reporter = _newReporter();
                    expect(
                        () => reporter.logAndThrowErrorWithOffset('Bad:', 'extra', 0),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', equals('Bad: (Line 1, column 1) extra')))
                    );
                }
            );
        }
    );

    group('FormatErrorReporter.logAndThrowErrorWithOffsets', ()
        {
            test('formats both positions with the delimiter and the source tag', ()
                {
                    final FormatErrorReporter reporter = _newReporter();
                    expect(
                        () => reporter.logAndThrowErrorWithOffsets('Range:', '-', null, 0, 5, 'SRC'),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', equals('Range: (Line 1, column 1) - (Line 2, column 2) (SRC)')))
                    );
                }
            );

            test('appends additionalText between offsets and source tag', ()
                {
                    final FormatErrorReporter reporter = _newReporter();
                    expect(
                        () => reporter.logAndThrowErrorWithOffsets('Range:', '<', 'extra', 0, 5, 'SRC'),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', equals('Range: (Line 1, column 1) < (Line 2, column 2) extra (SRC)')))
                    );
                }
            );
        }
    );
}
