import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestEnumConstantDeclarationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestEnumConstantDeclarationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitEnumConstantDeclaration(EnumConstantDeclaration node)
    => formatState.consumeText(offset, end, text, 'TestEnumConstantDeclarationVisitor');
}
