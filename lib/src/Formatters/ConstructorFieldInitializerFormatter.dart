import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ConstructorFieldInitializerFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConstructorFieldInitializerFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ConstructorFieldInitializerFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ConstructorFieldInitializer)
            throw FormatException('Not a ConstructorFieldInitializer: ${node.runtimeType}');

        formatState.copyEntity(node.thisKeyword, astVisitor, '$methodName/node.thisKeyword');
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.fieldName, astVisitor, '$methodName/node.fieldName');
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
    }
}
