import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestClassDeclarationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestClassDeclarationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitClassDeclaration(ClassDeclaration node)
    => formatState.consumeText(offset, end, text, 'TestClassDeclarationVisitor');
}
