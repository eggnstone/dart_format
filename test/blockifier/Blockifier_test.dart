import 'package:dart_format/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/isimple_block.dt.g.dart';
import 'package:test/test.dart';

void main()
{
    test('Blockify empty string', () {
        const String inputText = '';
        const List<ISimpleBlock> expectedBlocks=<ISimpleBlock>[];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });
}
