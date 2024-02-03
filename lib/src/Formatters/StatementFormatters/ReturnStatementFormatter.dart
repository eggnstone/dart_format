import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ReturnStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ReturnStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ReturnStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ReturnStatement)
            throw FormatException('Not a ReturnStatement: ${node.runtimeType}');

        formatState.copyEntity(node.returnKeyword, astVisitor, '$methodName/node.returnKeyword');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
