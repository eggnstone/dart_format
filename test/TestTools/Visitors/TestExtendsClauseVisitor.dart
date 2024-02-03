import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestExtendsClauseVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestExtendsClauseVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitExtendsClause(ExtendsClause node)
    => formatState.consumeText(offset, end, text, 'TestExtendsClauseVisitor');
}
