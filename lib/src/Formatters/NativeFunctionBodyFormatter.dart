import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
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
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! NativeFunctionBody)
            throw FormatException('Not a NativeFunctionBody: ${node.runtimeType}');

        formatState.copyEntity(node.nativeKeyword, astVisitor, '$methodName/node.nativeKeyword');
        formatState.copyEntity(node.stringLiteral, astVisitor, '$methodName/node.stringLiteral');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
