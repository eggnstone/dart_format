import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestConstructorDeclarationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestConstructorDeclarationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitConstructorDeclaration(ConstructorDeclaration node)
    => formatState.consumeText(offset, end, text, 'TestConstructorDeclarationVisitor');
}
