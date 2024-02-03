import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class TryStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TryStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'TryStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! TryStatement)
            throw FormatException('Not a TryStatement: ${node.runtimeType}');

        formatState.copyEntity(node.tryKeyword, astVisitor, '$methodName/node.tryKeyword'); // covered by tests
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
        formatState.acceptList(node.catchClauses, astVisitor, '$methodName/node.catchClauses');
        formatState.copyEntity(node.finallyKeyword, astVisitor, '$methodName/node.finallyKeyword');// covered by tests
        formatState.copyEntity(node.finallyBlock, astVisitor, '$methodName/node.finallyBlock');// covered by tests
    }
}
