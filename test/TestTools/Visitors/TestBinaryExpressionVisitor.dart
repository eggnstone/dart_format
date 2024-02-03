import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestBinaryExpressionVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestBinaryExpressionVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitBinaryExpression(BinaryExpression node)
    => formatState.consumeText(offset, end, text, 'TestBinaryExpressionVisitor');
}
