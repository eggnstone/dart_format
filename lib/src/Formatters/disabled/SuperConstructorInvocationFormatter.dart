/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SuperConstructorInvocationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SuperConstructorInvocationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SuperConstructorInvocationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! SuperConstructorInvocation)
            throw FormatException('Not a SuperConstructorInvocation: ${node.runtimeType}');

        formatState.copyEntity(node.superKeyword, astVisitor, '$methodName/node.superKeyword');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.constructorName, astVisitor, '$methodName/node.constructorName');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');
    }
}
*/
