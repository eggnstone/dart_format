import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('SplitBlockCommentsAndJoin', ()
        {
            test('/*/', ()
                {
                    const String inputText = '/*/';

                    void f() => StringTools.splitBlockCommentsAndJoin(
                        inputText,
                        onMatch: StringBuffer.new,
                        onNonMatch: StringBuffer.new
                    );

                    expect(f, throwsA(isA<DartFormatException>()));
                }
            );

            test('/*/*/', ()
                {
                    const String inputText = '/*/*/';

                    void f() => StringTools.splitBlockCommentsAndJoin(
                        inputText,
                        onMatch: StringBuffer.new,
                        onNonMatch: StringBuffer.new
                    );

                    expect(f, throwsA(isA<DartFormatException>()));
                }
            );

            test('/*/ */', ()
                {
                    const String inputText =
                    '/*/ */';

                    final String actualText = StringTools.splitBlockCommentsAndJoin(
                        inputText,
                        onMatch: StringBuffer.new,
                        onNonMatch: StringBuffer.new
                    );

                    TestTools.expect(actualText, equals(inputText));
                }
            );
        }
    );
}
