import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForPartsWithExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForPartsWithExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForPartsWithExpression)
            throw FormatException('Not a ForPartsWithExpression: ${node.runtimeType}');

        formatState.copyEntity(node.initialization, astVisitor, '$methodName/node.initialization'); // covered by tests
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator'); // covered by tests
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition'); // covered by tests
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator'); // covered by tests
        formatState.acceptList(node.updaters, astVisitor, '$methodName/node.updaters'); // covered by tests
    }
}
