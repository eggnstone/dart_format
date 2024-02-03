import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestFunctionExpressionVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestFunctionExpressionVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitFunctionExpression(FunctionExpression node)
    => formatState.consumeText(offset, end, text, 'TestFunctionExpressionVisitor');
}
