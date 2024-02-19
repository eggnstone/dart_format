import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Tools/StringTools.dart';

import 'SimpleVisitor.dart';
import 'TestVisitor.dart';

class MetaAstVisitor<T extends AstNode> extends SimpleVisitor
{
    final List<AstVisitor<void>>? astVisitors;
    final FormatState formatState;

    int _currentVisitorIndex = 0;

    MetaAstVisitor(this.astVisitors, this.formatState);

    int get currentVisitorIndex => _currentVisitorIndex;

    @override
    void visit(AstNode node)
    {
        try
        {
            if (astVisitors == null)
                throw Exception('Visitor #${_currentVisitorIndex + 1} expected for ${node.runtimeType} but none given at all.');

            if (_currentVisitorIndex >= astVisitors!.length)
                throw Exception('Visitor #${_currentVisitorIndex + 1} expected for ${node.runtimeType} but none left.');

            final AstVisitor<void> visitor = astVisitors![_currentVisitorIndex];
            /*
            if (visitor is! T)
            throw Exception('Visitor #${_currentVisitorIndex + 1} expected to be of type $T expected but is ${visitor.runtimeType}.');
            */

            logInfo('# ${visitor.runtimeType}(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

            if (visitor is TestVisitor)
                visitor.formatState = formatState;

            node.accept(visitor);
        }
        finally
        {
            _currentVisitorIndex++;
        }
    }
}
