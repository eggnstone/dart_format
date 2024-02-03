import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class RethrowExpressionFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    RethrowExpressionFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'RethrowExpressionFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! RethrowExpression)
            throw FormatException('Not a RethrowExpression: ${node.runtimeType}');

        formatState.copyEntity(node.rethrowKeyword, astVisitor, '$methodName/node.rethrowKeyword'); // covered by tests
    }
}
