import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Format/Formatter.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Config config = Config.experimental();
    final Formatter formatter = Formatter(config);

    group('Formatter.format: leading comment before declaration', ()
        {
            test('// line-comment at file start is not prefixed with a space', ()
                {
                    const String inputText = '// ignore_for_file: T\n\nclass C\n{\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );

            test('/// doc-comment at file start is not prefixed with a space', ()
                {
                    const String inputText = '/// Top-level docs.\nclass C\n{\n}\n';

                    final String actualText = formatter.format(inputText);

                    TestTools.expect(actualText, equals(inputText));
                }
            );
        }
    );
}
