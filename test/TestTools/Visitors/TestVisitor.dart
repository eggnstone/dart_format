// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:meta/meta.dart';

import 'SimpleVisitor.dart';

class TestVisitor<T extends AstNode> extends SimpleVisitor
{
    final int offset;
    final int end;
    final String text;
    final String? appendText;

    late FormatState _formatState;

    @protected
    FormatState get formatState
    => _formatState;

    set formatState(FormatState formatState)
    => _formatState = formatState;

    TestVisitor(this.offset, this.text, [this.appendText]) : end = offset + text.length;

    @override
    void visit(AstNode node)
    {
        if (node is! T)
            throw Exception('Expected ${T} but got ${node.runtimeType}');

        //logDebug('TestVisitor<${node.runtimeType}>: ${StringTools.toDisplayString(node)} = ${StringTools.toDisplayString(_formatState.getText(node.offset, node.end))}');
        formatState.consumeText(offset, end, text, 'TestVisitor<${node.runtimeType}>');

        if (appendText != null)
            formatState.addText(appendText!, 'TestVisitor<${node.runtimeType}>');
    }
}
