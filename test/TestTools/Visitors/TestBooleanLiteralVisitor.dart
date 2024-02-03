import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestBooleanLiteralVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestBooleanLiteralVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitBooleanLiteral(BooleanLiteral node)
    => formatState.consumeText(offset, end, text, 'TestBooleanLiteralVisitor');
}
