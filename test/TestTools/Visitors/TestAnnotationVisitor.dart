import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestAnnotationVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestAnnotationVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitAnnotation(Annotation node)
    => formatState.consumeText(offset, end, text, 'TestAnnotationVisitor');
}
