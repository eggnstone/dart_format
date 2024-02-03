import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DefaultFormalParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DefaultFormalParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DefaultFormalParameterFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! DefaultFormalParameter)
            throw FormatException('Not a DefaultFormalParameter: ${node.runtimeType}');

        formatState.copyEntity(node.parameter, astVisitor, '$methodName/node.parameter');
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator');
        formatState.copyEntity(node.defaultValue, astVisitor, '$methodName/node.defaultValue');
    }
}
