import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestParameters.dart';
import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none();
    final Formatter formatter = Formatter(config);

    for (final String comment in TestParameters.comments)
        group('Comments (class, ${StringTools.toDisplayString(comment)})', ()
            {
                test('Comment before class declaration', ()
                    {
                        final String inputText = '${comment}class C{}';
                        final String expectedText = '${comment}class C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                // TODO
                /*test('Comment after newline before class declaration', ()
                {
                    final String inputText = '\n${comment}class C{}';
                    final String expectedText = '\n${comment}class C{}';

                    final String actualText = formatter.format(inputText);

                    TestTools.expectX(actualText, equals(expectedText));
                });*/

                test('Comment before annotation before class declaration', ()
                    {
                        final String inputText = '$comment@a class C{}';
                        final String expectedText = '$comment@a class C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before annotations before class declaration with space', ()
                    {
                        final String inputText = '$comment@a @b class C{}';
                        final String expectedText = '$comment@a @b class C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before annotations before class declaration without space', ()
                    {
                        final String inputText = '$comment@a@b class C{}';
                        final String expectedText = '$comment@a@b class C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment after annotation before class declaration', ()
                    {
                        final String inputText = '@a${comment}class C{}';
                        final String expectedText = '@a${comment}class C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before newline before class declaration', ()
                    {
                        final String inputText = '$comment\nclass C{}';
                        final String expectedText = '$comment\nclass C{}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment in class declaration', ()
                    {
                        final String inputText = 'class C{$comment}';
                        final String expectedText = 'class C{$comment}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                // TODO
                /*test('Comment after class declaration', ()
                {
                    final String inputText = 'class C{}$comment';
                    final String expectedText = 'class C{}$comment';

                    final String actualText = formatter.format(inputText);

                    TestTools.expectX(actualText, equals(expectedText));
                });

                test('Comment before newline after class declaration', ()
                {
                    final String inputText = 'class C{}$comment\n';
                    final String expectedText = 'class C{}$comment\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expectX(actualText, equals(expectedText));
                });*/
            }
        );
}
