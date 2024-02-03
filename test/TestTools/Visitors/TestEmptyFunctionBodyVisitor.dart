import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestEmptyFunctionBodyVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestEmptyFunctionBodyVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitEmptyFunctionBody(EmptyFunctionBody node)
    => formatState.consumeText(offset, end, text, 'TestEmptyFunctionBodyVisitor');
}
