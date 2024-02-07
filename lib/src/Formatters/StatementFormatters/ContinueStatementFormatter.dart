import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ContinueStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ContinueStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ContinueStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ContinueStatement)
            throw FormatException('Not a ContinueStatement: ${node.runtimeType}');

        formatState.copyEntity(node.continueKeyword,astVisitor, '$methodName/node.continueKeyword');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
