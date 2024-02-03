import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestConstructorFieldInitializerVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestConstructorFieldInitializerVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitConstructorFieldInitializer(ConstructorFieldInitializer node)
    => formatState.consumeText(offset, end, text, 'TestConstructorFieldInitializerVisitor');
}
