import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class GuardedPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    GuardedPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'GuardedPatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! GuardedPattern)
            throw FormatException('Not a GuardedPattern: ${node.runtimeType}');

        formatState.copyEntity(node.pattern, astVisitor, '$methodName/node.pattern');
        formatState.copyEntity(node.whenClause, astVisitor, '$methodName/node.whenClause');
    }
}
