// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class RecordPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    RecordPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'RecordPatternFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! RecordPattern)
            throw FormatException('Not a RecordPattern: ${node.runtimeType}');

        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftParenthesis'));
        formatState.acceptListWithComma(node.fields, node.rightParenthesis, astVisitor, '$methodName/node.fields');
        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightParenthesis'));

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
