import 'dart:convert';

import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Formatter.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config configAll = Config.all();
    final Formatter formatterAll = Formatter(configAll);

    test('Euro sign must not be changed to question mark', ()
        {
            const int euroInt = 0x20AC;
            const String euroText = '€';
            const String inputText = "String euro='$euroText';\n";
            const String expectedText = inputText;

            final String actualText = formatterAll.format(inputText);

            expect(euroText, equals(String.fromCharCode(euroInt)), reason: 'This test has probably been unintentionally changed. "euroText" must contain the Euro symbol.');
            TestTools.expect(actualText, equals(expectedText));
        }
    );
}
