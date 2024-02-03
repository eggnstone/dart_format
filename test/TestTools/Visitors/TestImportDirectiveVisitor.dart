import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestImportDirectiveVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestImportDirectiveVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitImportDirective(ImportDirective node)
    => formatState.consumeText(offset, end, text, 'TestImportDirectiveVisitor');
}
