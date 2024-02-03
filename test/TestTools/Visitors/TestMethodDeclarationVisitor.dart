import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestMethodDeclarationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestMethodDeclarationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitMethodDeclaration(MethodDeclaration node)
    => formatState.consumeText(offset, end, text, 'TestMethodDeclarationVisitor');
}
