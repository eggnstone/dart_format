import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ConstantPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConstantPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConstantPatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ConstantPattern)
            throw FormatException('Not a ConstantPattern: ${node.runtimeType}');

        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
    }
}
