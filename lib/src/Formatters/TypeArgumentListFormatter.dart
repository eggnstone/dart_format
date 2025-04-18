// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class TypeArgumentListFormatter extends IFormatter
{
    static const String CLASS_NAME = 'TypeArgumentListFormatter';

    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TypeArgumentListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        if (Constants.DEBUG_I_FORMATTER) log('START $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! TypeArgumentList)
            throw FormatException('Not a TypeArgumentList: ${node.runtimeType}');

        formatState.copyEntity(node.leftBracket, astVisitor, '$CLASS_NAME/node.leftBracket');
        formatState.acceptListWithComma(node.arguments, node.rightBracket, astVisitor, '$CLASS_NAME/node.arguments', leadingSpaces: config.space0, trimCommaText: config.fixSpaces);
        formatState.copyEntity(node.rightBracket, astVisitor, '$CLASS_NAME/node.rightBracket', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $CLASS_NAME(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
