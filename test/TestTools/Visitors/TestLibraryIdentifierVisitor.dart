import 'package:analyzer/dart/ast/ast.dart';

import 'TestAstVisitor.dart';

class TestLibraryIdentifierVisitor extends TestAstVisitor
{
    final int offset;
    final int end;
    final String text;

    TestLibraryIdentifierVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visitLibraryIdentifier(LibraryIdentifier node)
    => formatState.consumeText(offset, end, text, 'TestLibraryIdentifierVisitor');
}
