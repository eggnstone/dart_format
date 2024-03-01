// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! ImplementsClause)
            throw FormatException('Not an ImplementsClause: ${node.runtimeType}');

        formatState.copyEntity(node.implementsKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.implementsKeyword'));
        formatState.acceptListWithComma(node.interfaces, null, astVisitor, '$methodName/interfaces');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
