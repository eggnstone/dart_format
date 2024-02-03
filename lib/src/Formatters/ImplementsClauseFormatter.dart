import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ImplementsClauseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ImplementsClauseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ImplementsClauseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ImplementsClause)
            throw FormatException('Not an ImplementsClause: ${node.runtimeType}');

        formatState.copyEntity(node.implementsKeyword, astVisitor, '$methodName/node.withKeyword');
        formatState.acceptList(node.interfaces, astVisitor, '$methodName/node.interfaces');
    }
}
