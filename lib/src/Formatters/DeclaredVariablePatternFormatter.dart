import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DeclaredVariablePatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DeclaredVariablePatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DeclaredVariablePatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! DeclaredVariablePattern)
            throw FormatException('Not a DeclaredVariablePattern: ${node.runtimeType}');

        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
    }
}
