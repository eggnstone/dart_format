import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:meta/meta.dart';

import 'SimpleVisitor.dart';

class TestVisitor<T extends AstNode> extends SimpleVisitor
{
    final int offset;
    final int end;
    final String text;

    late FormatState _formatState;
    late int _index = -1;

    @protected
    FormatState get formatState
    => _formatState;

    set formatState(FormatState formatState)
    => _formatState = formatState;

    @protected
    int get index
    => _index;

    set index(int index)
    => _index = index;

    TestVisitor(this.offset, this.text) : end = offset + text.length;

    @override
    void visit(AstNode node)
    {
        if (node is! T)
            throw Exception('Expected ${T} as TestVisitor #${index} but got ${node.runtimeType}');

        formatState.consumeText(offset, end, text, 'TestVisitor<${node.runtimeType}>');
    }
}
