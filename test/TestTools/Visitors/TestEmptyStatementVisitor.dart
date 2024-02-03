import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestEmptyStatementVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestEmptyStatementVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitEmptyStatement(EmptyStatement node)
    => formatState.consumeText(offset, end, text, 'TestEmptyStatementVisitor');
}
