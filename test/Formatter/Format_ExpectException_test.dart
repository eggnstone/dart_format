import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.none(maxEmptyLines: 0);
    final Formatter formatter = Formatter(config);

    group('Formatter.format: expecting exception', ()
        {
            test('<html>', ()
                {
                    const String inputText = '<html>';

                    expect(() => formatter.format(inputText), throwsA(isA<DartFormatException>()));
                }
            );

            test('x;', ()
                {
                    const String inputText = 'x;';

                    expect(() => formatter.format(inputText), throwsA(isA<DartFormatException>()));
                }
            );
        }
    );
}
