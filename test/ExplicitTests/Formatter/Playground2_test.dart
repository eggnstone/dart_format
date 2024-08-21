import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configNone = Config.none();
    final Formatter formatterNone = Formatter(configNone);

    group('Playground 2', ()
        {
            test('int f(int i)=>switch(i){0=>0,_=>1,/**/};', ()
                {
                    const String inputText = 'int f(int i)=>switch(i){0=>0,_=>1,/**/};';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r'int f(int i)=>switch(i)\n{\n0=>0,_=>1,/**/\n};', ()
                {
                    const String inputText = 'int f(int i)=>switch(i)\n{\n0=>0,_=>1,/**/\n};';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );

            test(r'int f(int i)=>switch(i){\n_=>1,/**/};', ()
                {
                    const String inputText = 'int f(int i)=>switch(i){\n_=>1,/**/};';
                    const String expectedText = inputText;

                    final String actualText = formatterNone.format(inputText);

                    TestTools.expect(actualText, equals(expectedText));
                    //logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
                }
            );
        }
    );
}
