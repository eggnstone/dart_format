import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestSimpleIdentifierVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestSimpleIdentifierVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitSimpleIdentifier(SimpleIdentifier node)
    => formatState.consumeText(offset, end, text, 'TestSimpleIdentifierVisitor');
}
