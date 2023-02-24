import 'package:dart_format/src/blockifier/Blockifier.dart';
import 'package:test/test.dart';

void main()
{
    test('Blockify empty string', () {
        final Blockifier blockifier = Blockifier();
        expect(blockifier.blockify(''), '');
    });
}
