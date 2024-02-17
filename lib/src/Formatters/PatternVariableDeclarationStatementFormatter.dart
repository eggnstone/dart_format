import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
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
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! PatternVariableDeclarationStatement)
            throw FormatException('Not a PatternVariableDeclarationStatement: ${node.runtimeType}');

        formatState.copyEntity(node.declaration, astVisitor, '$methodName/node.declaration');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
