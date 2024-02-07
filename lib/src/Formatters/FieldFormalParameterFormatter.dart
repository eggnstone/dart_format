import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FieldFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FieldFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FieldFormalParameterFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! FieldFormalParameter)
            throw FormatException('Not a FieldFormalParameter: ${node.runtimeType}');

        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword');
        formatState.copyEntity(node.thisKeyword, astVisitor, '$methodName/node.thisKeyword');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
    }
}
