import 'package:dart_format/dart_format.dart';
import 'package:test/test.dart';

void main() 
{
    test('Format empty string', ()
    {
        final Formatter formatter = Formatter();
        expect(formatter.format(''), '');
    });
}
