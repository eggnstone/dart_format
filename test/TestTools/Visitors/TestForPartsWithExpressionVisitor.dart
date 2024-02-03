import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestForPartsWithExpressionVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestForPartsWithExpressionVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitForPartsWithExpression(ForPartsWithExpression node)
    => formatState.consumeText(offset, end, text, 'visitForPartsWithExpression');
}
