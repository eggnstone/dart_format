/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionDeclarationStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionDeclarationStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionDeclarationStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! FunctionDeclarationStatement)
            throw FormatException('Not a FunctionDeclarationStatement: ${node.runtimeType}');

        formatState.copyEntity(node.functionDeclaration, astVisitor, '$methodName/node.functionDeclaration');
    }
}
*/
