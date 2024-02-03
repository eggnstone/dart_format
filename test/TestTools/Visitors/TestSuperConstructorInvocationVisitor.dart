import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestSuperConstructorInvocationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestSuperConstructorInvocationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitSuperConstructorInvocation(SuperConstructorInvocation node)
    => formatState.consumeText(offset, end, text, 'TestSuperConstructorInvocationVisitor');
}
