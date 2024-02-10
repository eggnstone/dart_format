import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestNamedTypeVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestNamedTypeVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitNamedType(NamedType node)
    => formatState.consumeText(offset, end, text, 'TestNamedTypeVisitor');
}