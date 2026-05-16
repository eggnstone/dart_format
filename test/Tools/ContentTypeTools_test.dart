import 'package:dart_format/src/Tools/ContentTypeTools.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('ContentTypeTools.get', ()
        {
            test('returns null on null input', ()
                {
                    expect(ContentTypeTools.get(null, 'name'), isNull);
                }
            );

            test('returns null on empty input', ()
                {
                    expect(ContentTypeTools.get('', 'name'), isNull);
                }
            );

            test('returns null when no parameters are present', ()
                {
                    expect(ContentTypeTools.get('form-data', 'name'), isNull);
                }
            );

            test('returns the value for a quoted parameter', ()
                {
                    expect(ContentTypeTools.get('form-data; name="Config"', 'name'), 'Config');
                }
            );

            test('returns the value for an unquoted parameter', ()
                {
                    expect(ContentTypeTools.get('multipart/form-data; boundary=----X', 'boundary'), '----X');
                }
            );

            test('matches the key case-insensitively', ()
                {
                    expect(ContentTypeTools.get('form-data; Name="Config"', 'name'), 'Config');
                    expect(ContentTypeTools.get('form-data; name="Config"', 'NAME'), 'Config');
                }
            );

            test('tolerates extra whitespace around the parameter', ()
                {
                    expect(ContentTypeTools.get('form-data;   name="Config"  ', 'name'), 'Config');
                }
            );

            test('strips only matched outer quotes, not inner content', ()
                {
                    expect(ContentTypeTools.get('form-data; name="a"b"', 'name'), 'a"b');
                }
            );

            test('returns null when key is not present', ()
                {
                    expect(ContentTypeTools.get('form-data; name="Config"', 'filename'), isNull);
                }
            );
        }
    );
}
