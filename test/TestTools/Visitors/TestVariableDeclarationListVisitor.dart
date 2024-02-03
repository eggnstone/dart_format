import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestVariableDeclarationListVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestVariableDeclarationListVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitVariableDeclarationList(VariableDeclarationList node)
    => formatState.consumeText(offset, end, text, 'TestVariableDeclarationListVisitor');
}
