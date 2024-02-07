import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CatchClauseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CatchClauseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CatchClauseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CatchClause)
            throw FormatException('Not a CatchClause: ${node.runtimeType}');

        formatState.copyEntity(node.onKeyword, astVisitor, '$methodName/node.onKeyword'); // covered by tests
        formatState.copyEntity(node.exceptionType,astVisitor,  '$methodName/node.exceptionType'); // covered by tests
        formatState.copyEntity(node.catchKeyword, astVisitor, '$methodName/node.catchKeyword'); // covered by tests
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis'); // covered by tests
        formatState.copyEntity(node.exceptionParameter,astVisitor,  '$methodName/node.exceptionParameter'); // covered by tests
        formatState.copyEntity(node.comma, astVisitor, '$methodName/node.comma'); // covered by tests
        formatState.copyEntity(node.stackTraceParameter, astVisitor, '$methodName/node.stackTraceParameter'); // covered by tests
        formatState.copyEntity(node.rightParenthesis,astVisitor,  '$methodName/node.rightParenthesis'); // covered by tests
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body'); // covered by tests
    }
}
