import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestWithClauseVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestWithClauseVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitWithClause(WithClause node)
    => formatState.consumeText(offset, end, text, 'TestWithClauseVisitor');
}
