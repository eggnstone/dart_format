import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestExpressionStatementVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestExpressionStatementVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitExpressionStatement(ExpressionStatement node)
    => formatState.consumeText(offset, end, text, 'TestExpressionStatementVisitor');
}
