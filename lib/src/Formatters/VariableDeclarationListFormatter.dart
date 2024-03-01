// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class VariableDeclarationListFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    VariableDeclarationListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'VariableDeclarationListFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! VariableDeclarationList)
            throw FormatException('Not a VariableDeclarationList: ${node.runtimeType}');

        formatState.copyEntity(node.lateKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.lateKeyword'));
        formatState.copyEntity(node.keyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.keyword'));
        formatState.copyEntity(node.type, astVisitor, onGetStack: () => SimpleStack('$methodName/node.type'));
        formatState.acceptListWithComma(node.variables, null, astVisitor, '$methodName/node.variables');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
