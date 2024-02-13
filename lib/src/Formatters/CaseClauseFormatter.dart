import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CaseClauseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CaseClauseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CaseClauseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CaseClause)
            throw FormatException('Not a CaseClause: ${node.runtimeType}');

        formatState.copyEntity(node.caseKeyword, astVisitor, '$methodName/caseKeyword');
        formatState.copyEntity(node.guardedPattern, astVisitor, '$methodName/guardedPattern');
    }
}
