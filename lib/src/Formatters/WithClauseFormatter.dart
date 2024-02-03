import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class WithClauseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    WithClauseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'WithClauseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! WithClause)
            throw FormatException('Not a WithClause: ${node.runtimeType}');

        formatState.copyEntity(node.withKeyword, astVisitor, '$methodName/node.withKeyword');
        formatState.acceptList(node.mixinTypes, astVisitor, '$methodName/node.mixinTypes');
    }
}
