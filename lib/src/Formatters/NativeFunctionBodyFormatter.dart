// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class NativeFunctionBodyFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    NativeFunctionBodyFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'NativeFunctionBodyFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! NativeFunctionBody)
            throw FormatException('Not a NativeFunctionBody: ${node.runtimeType}');

        formatState.copyEntity(node.nativeKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.nativeKeyword'));
        formatState.copyEntity(node.stringLiteral, astVisitor, onGetStack: () => SimpleStack('$methodName/node.stringLiteral'));
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
