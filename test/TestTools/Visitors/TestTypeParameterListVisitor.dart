import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestTypeParameterListVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestTypeParameterListVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitTypeParameterList(TypeParameterList node)
    => formatState.consumeText(offset, end, text, 'TestTypeParameterListVisitor');
}
