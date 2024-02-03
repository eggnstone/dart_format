import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestExpressionFunctionBodyVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestExpressionFunctionBodyVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitExpressionFunctionBody(ExpressionFunctionBody node)
    => formatState.consumeText(offset, end, text, 'TestExpressionFunctionBodyVisitor');
}
