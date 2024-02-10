import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CascadeExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CascadeExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CascadeExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CascadeExpression)
            throw FormatException('Not a CascadeExpression: ${node.runtimeType}');

        formatState.copyEntity(node.target, astVisitor, '$methodName/node.target');
        formatState.acceptList(node.cascadeSections, astVisitor, '$methodName/node.cascadeSections');
    }
}
