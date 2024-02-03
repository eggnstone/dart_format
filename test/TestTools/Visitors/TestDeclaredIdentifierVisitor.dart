import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestDeclaredIdentifierVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestDeclaredIdentifierVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitDeclaredIdentifier(DeclaredIdentifier node)
    => formatState.consumeText(offset, end, text, 'TestDeclaredIdentifierVisitor');
}
