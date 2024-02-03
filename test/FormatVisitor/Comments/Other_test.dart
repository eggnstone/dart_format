import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestParameters.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none();
    final Formatter formatter = Formatter(config);

    for (final String comment in TestParameters.comments)
        group('Comments (${StringTools.toDisplayString(comment)})', ()
            {
                test('Simple comment', ()
                    {
                        final String inputText = comment;
                        final String expectedText = comment;

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment after block start', ()
                    {
                        final String inputText = 'void f(){{${comment}a;}}';
                        final String expectedText = 'void f(){{${comment}a;}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before block end', ()
                    {
                        final String inputText = 'void f(){{a;$comment}}';
                        final String expectedText = 'void f(){{a;$comment}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment after function block start', ()
                    {
                        final String inputText = 'void f(){${comment}a;}';
                        final String expectedText = 'void f(){${comment}a;}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before function block end', ()
                    {
                        final String inputText = 'void f(){a;$comment}';
                        final String expectedText = 'void f(){a;$comment}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before expression statement', ()
                    {
                        final String inputText = 'void f(){${comment}a;}';
                        final String expectedText = 'void f(){${comment}a;}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment in depth-2 block before expression statement', ()
                    {
                        final String inputText = 'void f(){{{${comment}a();}}}';
                        final String expectedText = 'void f(){{{${comment}a();}}}';

                        final Formatter formatter = Formatter(config);
                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );
            }
        );
}
