import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AssignedVariablePatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AssignedVariablePatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AssignedVariablePatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! AssignedVariablePattern)
            throw FormatException('Not an AssignedVariablePattern: ${node.runtimeType}');

        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
    }
}
