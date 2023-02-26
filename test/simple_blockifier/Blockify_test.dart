import 'package:dart_format/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/isimple_block.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/simple_instruction_block.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/simple_whitespace_block.dt.g.dart';
import 'package:test/test.dart';

void main() 
{
    // Actual tests are in https://github.com/eggnstone/DartFormatJetbrainsPlugin
    test('emptyText', ()
    {
        const String inputText = '';
        const List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });
}
