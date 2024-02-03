import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestDefaultFormalParameterVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestDefaultFormalParameterVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitDefaultFormalParameter(DefaultFormalParameter node)
    => formatState.consumeText(offset, end, text, 'TestDefaultFormalParameterVisitor');
}
