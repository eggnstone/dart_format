import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class TypeArgumentListFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TypeArgumentListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'TypeArgumentListFormatter.format';
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! TypeArgumentList)
            throw FormatException('Not a TypeArgumentList: ${node.runtimeType}');

        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        //formatState.pushLevel('$methodName/node.leftBracket', IndentationType.single);
        formatState.acceptListWithComma(node.arguments, node.rightBracket, astVisitor, '$methodName/node.arguments');
        //formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
