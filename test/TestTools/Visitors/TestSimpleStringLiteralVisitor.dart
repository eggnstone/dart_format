import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestSimpleStringLiteralVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestSimpleStringLiteralVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitSimpleStringLiteral(SimpleStringLiteral node)
    => formatState.consumeText(offset, end, text, 'TestSimpleStringLiteralVisitor');
}
