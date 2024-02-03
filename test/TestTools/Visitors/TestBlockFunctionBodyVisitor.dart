import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestBlockFunctionBodyVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestBlockFunctionBodyVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitBlockFunctionBody(BlockFunctionBody node)
    => formatState.consumeText(offset, end, text, 'visitBlockFunctionBody');
}
