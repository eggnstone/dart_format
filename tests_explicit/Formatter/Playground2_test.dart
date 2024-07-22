import 'package:dart_format/dart_format.dart';
import 'package:dart_format/src/Analyzer.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';
import 'package:test/test.dart';

import '../../test/TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    test('Playground 1', ()
        {
            const String inputText = 'int f(int i)=>switch(i){0=>0,_=>1,/**/};';
            const String expectedText = inputText;

            Analyzer().analyze(inputText);

            final Config config = Config.none();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
    );

    test('Playground 2', ()
        {
            const String inputText = 'int f(int i)=>switch(i)\n{\n0=>0,_=>1,/**/\n};';
            const String expectedText = inputText;

            Analyzer().analyze(inputText);

            final Config config = Config.none();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
    );

    test('Playground 3', ()
        {
            const String inputText = 'int f(int i)=>switch(i){\n_=>1,/**/};';
            const String expectedText = inputText;

            Analyzer().analyze(inputText);

            final Config config = Config.none();
            final Formatter formatter = Formatter(config);
            final String actualText = formatter.format(inputText);

            TestTools.expect(actualText, equals(expectedText));
            logDebug('actualText:\n\n${StringTools.toDisplayString(actualText)}\n\n$actualText');
        }
    );
}
