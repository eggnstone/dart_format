import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestIfStatementVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestIfStatementVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitIfStatement(IfStatement node)
    => formatState.consumeText(offset, end, text, 'TestIfStatementVisitor');
}
