import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestArgumentListVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestArgumentListVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitArgumentList(ArgumentList node)
    => formatState.consumeText(offset, end, text, 'TestArgumentListVisitor');
}
