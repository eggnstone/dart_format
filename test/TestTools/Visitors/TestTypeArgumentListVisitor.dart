import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestTypeArgumentListVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestTypeArgumentListVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitTypeArgumentList(TypeArgumentList node)
    => formatState.consumeText(offset, end, text, 'TestTypeArgumentListVisitor');
}
