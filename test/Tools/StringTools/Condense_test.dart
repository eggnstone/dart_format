import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Map<String, String> sets = <String, String>
    {
        '': '',
        ' ': '',
        'a': 'a',
        '#': '#',
        ' a\t': 'a',
        ' #\t': '#',
        'a b': 'a b',
        'a#b': 'a#b',
        '# +': '#+',
        '#a+': '#a+',
        'a ( ) { b }': 'a(){b}'
    };

    group('StringTools.condense', ()
        {
            for (final String key in sets.keys)
            {
                final String value = sets[key]!;
                test('${StringTools.toDisplayString(key)} => ${StringTools.toDisplayString(value)}', ()
                    {
                        final String inputText = key;
                        final String expectedText = value;

                        final String actualText = StringTools.condense(inputText);

                        TestTools.expect(actualText, equals(expectedText));
                    }
                );
            }
        }
    );
}
