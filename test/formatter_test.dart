import 'package:dart_format/dart_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() 
{
    test('Format empty string', ()
    {
        final formatter = Formatter();
        expect(formatter.format(""), "");
    });
}
