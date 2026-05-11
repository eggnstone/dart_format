// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ConstructorFieldInitializerFormatter extends IFormatter
{
    static const String CLASS_NAME = 'ConstructorFieldInitializerFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ConstructorFieldInitializerFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        if (Constants.DEBUG_I_FORMATTER) log('START $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ConstructorFieldInitializer)
            throw FormatException('Not a ConstructorFieldInitializer: ${node.runtimeType}');

        formatState.copyEntity(node.thisKeyword, astVisitor, '$CLASS_NAME/node.thisKeyword');
        formatState.copyEntity(node.period, astVisitor, '$CLASS_NAME/node.period', config.space0);
        formatState.copyEntity(node.fieldName, astVisitor, '$CLASS_NAME/node.fieldName', config.space0);
        formatState.copyEntity(node.equals, astVisitor, '$CLASS_NAME/node.equals', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$CLASS_NAME/node.expression', config.space1);

        if (Constants.DEBUG_I_FORMATTER) log('END   $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
