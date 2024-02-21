import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
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
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! VariableDeclarationList)
            throw FormatException('Not a VariableDeclarationList: ${node.runtimeType}');

        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.lateKeyword, astVisitor, '$methodName/node.lateKeyword');
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type');
        formatState.acceptListWithComma(node.variables, null, astVisitor, '$methodName/node.variables');

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
