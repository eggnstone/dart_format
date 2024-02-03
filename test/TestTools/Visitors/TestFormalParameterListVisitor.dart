import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestFormalParameterListVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestFormalParameterListVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitFormalParameterList(FormalParameterList node)
    => formatState.consumeText(offset, end, text, 'TestFormalParameterListVisitor');
}
