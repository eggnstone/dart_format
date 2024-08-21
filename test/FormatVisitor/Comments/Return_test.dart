import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestParameters.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    for (final String comment in TestParameters.comments)
        group('Comments (return, ${StringTools.toDisplayString(comment)})', ()
            {
                test('Comment before "return"', ()
                    {
                        final String inputText = 'void f(){${comment}return;}';
                        final String expectedText = 'void f(){${comment}return;}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment after "return"', ()
                    {
                        final String inputText = 'void f(){return;$comment}';
                        final String expectedText = 'void f(){return;$comment}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );
            }
        );
}
