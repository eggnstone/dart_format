import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestGuardedPatternVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestGuardedPatternVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitGuardedPattern(GuardedPattern node)
    => formatState.consumeText(offset, end, text, 'TestGuardedPatternVisitor');
}
