import 'package:dart_format/dart_format.dart';
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
        group('Comments (method, ${StringTools.toDisplayString(comment)})', ()
            {
                test('Comment before method declaration', ()
                    {
                        final String inputText = 'class C{${comment}void m(){}}';
                        final String expectedText = 'class C{${comment}void m(){}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Newline and comment before method declaration', ()
                    {
                        final String inputText = 'class C{\n${comment}void m(){}}';
                        final String expectedText = 'class C{\n${comment}void m(){}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before annotated static method declaration', ()
                    {
                        final String inputText = 'class C{$comment@a static void m(){}}';
                        final String expectedText = 'class C{$comment@a static void m(){}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment and newline before method declaration', ()
                    {
                        final String inputText = 'class C{$comment\nvoid m(){}}';
                        final String expectedText = 'class C{$comment\nvoid m(){}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment in method declaration', ()
                    {
                        final String inputText = 'class C{void m(){$comment}}';
                        final String expectedText = 'class C{void m(){$comment}}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment after method declaration', ()
                    {
                        final String inputText = 'class C{void m(){}$comment}';
                        final String expectedText = 'class C{void m(){}$comment}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment and newline after method declaration', ()
                    {
                        final String inputText = 'class C{void m(){}$comment\n}';
                        final String expectedText = 'class C{void m(){}$comment\n}';

                        final String actualText = formatter.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );
            }
        );
}
