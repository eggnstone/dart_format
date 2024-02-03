import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestConstructorNameVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestConstructorNameVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitConstructorName(ConstructorName node)
    => formatState.consumeText(offset, end, text, 'TestConstructorNameVisitor');
}
