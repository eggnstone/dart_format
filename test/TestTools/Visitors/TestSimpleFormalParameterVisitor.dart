import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestSimpleFormalParameterVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestSimpleFormalParameterVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitSimpleFormalParameter(SimpleFormalParameter node)
    => formatState.consumeText(offset, end, text, 'TestSimpleFormalParameterVisitor');
}
