// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DoStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DoStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DoStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! DoStatement)
            throw FormatException('Not a DoStatement: ${node.runtimeType}');

        formatState.copyEntity(node.doKeyword, astVisitor, onGetSource: ()=>'$methodName/node.doKeyword');
        formatState.copyEntity(node.body, astVisitor, onGetSource: ()=>'$methodName/node.body');
        formatState.copyEntity(node.whileKeyword, astVisitor, onGetSource: ()=>'$methodName/node.whileKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.leftParenthesis');
        formatState.copyEntity(node.condition, astVisitor, onGetSource: ()=>'$methodName/node.condition');
        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.rightParenthesis');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
