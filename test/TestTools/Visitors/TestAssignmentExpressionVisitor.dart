import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestAssignmentExpressionVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestAssignmentExpressionVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitAssignmentExpression(AssignmentExpression node)
    => formatState.consumeText(offset, end, text, 'TestAssignmentExpressionVisitor');
}
