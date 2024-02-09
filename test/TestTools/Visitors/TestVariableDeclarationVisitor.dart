import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestVariableDeclarationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestVariableDeclarationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitVariableDeclaration(VariableDeclaration node)
    => formatState.consumeText(offset, end, text, 'TestVariableDeclarationVisitor');
}
