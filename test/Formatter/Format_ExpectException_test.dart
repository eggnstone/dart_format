import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    const Config config = Config.none(maxEmptyLines: 0);
    final Formatter formatter = Formatter(config);

    group('Formatter.format: expecting exception', ()
        {
            test('<html>', ()
                {
                    const String inputText = '<html>';

                    void f() =>  formatter.format(inputText);
                    expect(f, throwsA(isA<DartFormatException>()));
                }
            );

            test('x;', ()
                {
                    const String inputText = 'x;';

                    void f() => formatter.format(inputText);
                    expect(f, throwsA(isA<DartFormatException>()));
                }
            );
        }
    );
}
