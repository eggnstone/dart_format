import 'package:dart_format/src/kotlin/simple_blockifier/simple_blockifier.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/isimple_block.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/simple_instruction_block.dt.g.dart';
import 'package:dart_format/src/kotlin/simple_blocks/simple_whitespace_block.dt.g.dart';
import 'package:test/test.dart';

void main() 
{
    test('emptyText', ()
    {
        const String inputText = '';
        const List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('oneWhitespace', ()
    {
        const String inputText = ' ';

        final SimpleWhitespaceBlock block = SimpleWhitespaceBlock(' ');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('twoWhitespaces', ()
    {
        const String inputText = '  ';

        final SimpleWhitespaceBlock block = SimpleWhitespaceBlock('  ');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('unexpectedEndInSimpleInstruction', ()
    {
        const String inputText = 'abc()';

        final SimpleBlockifier blockifier = SimpleBlockifier();
        expect(() => blockifier.blockify(inputText), throwsException);
    });

    test('oneSimpleInstructionSemicolonOnly', ()
    {
        const String inputText = ';';

        final SimpleInstructionBlock block = SimpleInstructionBlock(';');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('oneSimpleInstruction', ()
    {
        const String inputText = 'abc();';

        final SimpleInstructionBlock block = SimpleInstructionBlock('abc();');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('twoSimpleInstructions', ()
    {
        const String inputText = 'abc();def();';

        final SimpleInstructionBlock block1 = SimpleInstructionBlock('abc();');
        final SimpleInstructionBlock block2 = SimpleInstructionBlock('def();');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block1, block2];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('twoSimpleInstructionsWithWhitespaceInTheMiddle', ()
    {
        const String inputText = 'abc();\ndef();';

        final SimpleInstructionBlock block1 = SimpleInstructionBlock('abc();');
        final SimpleWhitespaceBlock block2 = SimpleWhitespaceBlock('\n');
        final SimpleInstructionBlock block3 = SimpleInstructionBlock('def();');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block1, block2, block3];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('twoSimpleInstructionsWithWhitespacesAround', ()
    {
        const String inputText = '\nabc();\ndef();\n';

        final SimpleWhitespaceBlock block1 = SimpleWhitespaceBlock('\n');
        final SimpleInstructionBlock block2 = SimpleInstructionBlock('abc();');
        final SimpleWhitespaceBlock block3 = SimpleWhitespaceBlock('\n');
        final SimpleInstructionBlock block4 = SimpleInstructionBlock('def();');
        final SimpleWhitespaceBlock block5 = SimpleWhitespaceBlock('\n');
        final List<ISimpleBlock> expectedBlocks = <ISimpleBlock>[block1, block2, block3, block4, block5];

        final SimpleBlockifier blockifier = SimpleBlockifier();
        final List<ISimpleBlock> actualBlocks = blockifier.blockify(inputText);

        expect(actualBlocks, equals(expectedBlocks));
    });

    test('unexpectedEndInCurlyBracketBlock', ()
    {
        const String inputText = '{';

        final SimpleBlockifier blockifier = SimpleBlockifier();
        expect(() => blockifier.blockify(inputText), throwsException);
    });

    test('unexpectedEndInRoundBracketBlock', ()
    {
        const String inputText = '(';

        final SimpleBlockifier blockifier = SimpleBlockifier();
        expect(() => blockifier.blockify(inputText), throwsException);
    });

    test('unexpectedEndInSquareBracketBlock', ()
    {
        const String inputText = '[';

        final SimpleBlockifier blockifier = SimpleBlockifier();
        expect(() => blockifier.blockify(inputText), throwsException);
    });

    test('unexpectedClosingCurlyBracket', ()
    {
        const String inputText = 'a}';

        final SimpleBlockifier blockifier = SimpleBlockifier();
        expect(() => blockifier.blockify(inputText), throwsException);
    });
}
