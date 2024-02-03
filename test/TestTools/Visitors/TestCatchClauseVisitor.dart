import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestCatchClauseVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestCatchClauseVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitCatchClause(CatchClause node)
    => formatState.consumeText(offset, end, text, 'TestCatchClauseVisitor');
}
