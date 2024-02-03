import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestImplementsClauseVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestImplementsClauseVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitImplementsClause(ImplementsClause node)
    => formatState.consumeText(offset, end, text, 'TestImplementsClauseVisitor');
}
