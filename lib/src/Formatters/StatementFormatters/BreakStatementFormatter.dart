import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class BreakStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    BreakStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'BreakStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! BreakStatement)
            throw FormatException('Not a BreakStatement: ${node.runtimeType}');

        formatState.copyEntity(node.breakKeyword,astVisitor, '$methodName/node.breakKeyword'); // covered by tests
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
