import 'package:dart_format/src/blockifier/Block.dart';
import 'package:dart_format/src/blockifier/Blockifier.dart';
import 'package:dart_format/src/blockifier/CurlyBracketBlock.dart';
import 'package:test/test.dart';

void main()
{
    test('Blockify empty string', () {
        const String inputText = '';
        const List<Block> expectedBlocks=<Block>[];

        final Blockifier blockifier = Blockifier();
        final List<Block> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('Blockify import line', () {
        const String inputText = "import 'package:dart_format/src/blockifier/Blockifier.dart';";

        const Block block = CurlyBracketBlock(inputText);
        const List<Block> expectedBlocks = <Block>[block];

        final Blockifier blockifier = Blockifier();
        final List<Block> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });
}
