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
        for (final String comment2 in TestParameters.comments)
            group('Comments (${StringTools.toDisplayString(comment)}, ${StringTools.toDisplayString(comment2)})', ()
                {
                    test('Comment before "for"', ()
                        {
                            final String inputText = 'void f(){${comment}a;${comment2}for(;;);}';
                            final String expectedText = 'void f(){${comment}a;${comment2}for(;;);}';

                            final String actualText = formatterNone.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );

                    test('Comment before variable declaration statement in function', ()
                        {
                            final String inputText = 'void f(){${comment}a;${comment2}int i;}';
                            final String expectedText = 'void f(){${comment}a;${comment2}int i;}';

                            final String actualText = formatterNone.format(inputText);

                            TestTools.expect(actualText, equals(expectedText));
                        }
                    );
                }
            );
}
