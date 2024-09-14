// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForPartsWithDeclarationsFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForPartsWithDeclarationsFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithDeclarationsFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForPartsWithDeclarations)
            throw FormatException('Not a ForPartsWithDeclarations: ${node.runtimeType}');

        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables');
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator', config.space0);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition', config.space1);
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator', config.space0);
        formatState.acceptListWithComma(node.updaters, null, astVisitor, '$methodName/node.updaters', config.space1);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
