import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestBlockVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestBlockVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitBlock(Block node)
    => formatState.consumeText(offset, end, text, 'visitBlock');
}
