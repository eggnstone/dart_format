import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestSwitchPatternCaseVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestSwitchPatternCaseVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitSwitchPatternCase(SwitchPatternCase node)
    => formatState.consumeText(offset, end, text, 'TestSwitchPatternCaseVisitor');
}
