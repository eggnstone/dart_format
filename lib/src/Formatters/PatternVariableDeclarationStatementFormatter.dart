// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class PatternVariableDeclarationStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    PatternVariableDeclarationStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'PatternVariableDeclarationStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! PatternVariableDeclarationStatement)
            throw FormatException('Not a PatternVariableDeclarationStatement: ${node.runtimeType}');

        formatState.copyEntity(node.declaration, astVisitor, '$methodName/node.declaration');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
