/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class MethodInvocationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MethodInvocationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'MethodInvocationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! MethodInvocation)
            throw FormatException('Not a MethodInvocation: ${node.runtimeType}');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target'); // covered by tests
        formatState.copyEntity(node.operator, astVisitor, '$methodName/node.operator'); // covered by tests
        formatState.copyEntity(node.methodName, astVisitor, '$methodName/node.methodName'); // covered by tests
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments'); // TODO
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList'); // covered by tests
    }
}
*/
