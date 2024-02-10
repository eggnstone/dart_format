import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! FunctionExpression)
            throw FormatException('Not a FunctionExpression: ${node.runtimeType}');

        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters'); // covered by tests
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters'); // covered by tests
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.parameters'); // covered by tests
    }
}
