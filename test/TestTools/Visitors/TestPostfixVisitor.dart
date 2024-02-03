import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestPostfixExpressionVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestPostfixExpressionVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitPostfixExpression(PostfixExpression node)
    => formatState.consumeText(offset, end, text, 'TestPostfixExpressionVisitor');
}
