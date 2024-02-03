import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestCatchClauseParameterVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestCatchClauseParameterVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitCatchClauseParameter(CatchClauseParameter node)
    => formatState.consumeText(offset, end, text, 'TestCatchClauseParameterVisitor');
}
