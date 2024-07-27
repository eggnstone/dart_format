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
        group('Comments (if, ${StringTools.toDisplayString(comment)})', ()
            {
                test('Comment in "else" block', ()
                    {
                        final String inputText = 'void f(){if(true){}else{$comment}}';
                        final String expectedText = 'void f(){if(true){}else{$comment}}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment in "if" block', ()
                    {
                        final String inputText = 'void f(){if(true){$comment}}';
                        final String expectedText = 'void f(){if(true){$comment}}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before "if"', ()
                    {
                        final String inputText = 'void f(){${comment}if(true);}';
                        final String expectedText = 'void f(){${comment}if(true);}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment before "if" in "if" block', ()
                    {
                        final String inputText = 'void f(){if(true){${comment}if(true);}}';
                        final String expectedText = 'void f(){if(true){${comment}if(true);}}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );

                test('Comment in "else"', ()
                    {
                        final String inputText = 'void f(){if(true){}else{${comment}a();}}';
                        final String expectedText = 'void f(){if(true){}else{${comment}a();}}';

                        final String actualText = formatterNone.format(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );
            }
        );
}
