import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../../Types/IndentationType.dart';
import '../IFormatter.dart';

class AssertStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AssertStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AssertStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! AssertStatement)
            throw FormatException('Not an AssertStatement: ${node.runtimeType}');

        formatState.copyEntity(node.assertKeyword, astVisitor, '$methodName/node.assertKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.comma, astVisitor, '$methodName/node.comma');
        formatState.copyEntity(node.message, astVisitor, '$methodName/node.message');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis');
        formatState.copyEntity(node.semicolon, astVisitor, '$methodName/node.semicolon');
    }
}
