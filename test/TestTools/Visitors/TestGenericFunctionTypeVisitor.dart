import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestGenericFunctionTypeVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestGenericFunctionTypeVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitGenericFunctionType(GenericFunctionType node)
    => formatState.consumeText(offset, end, text, 'TestGenericFunctionTypeVisitor');
}
