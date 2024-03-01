// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SetOrMapLiteralFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SetOrMapLiteralFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SetOrMapLiteralFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! SetOrMapLiteral)
            throw FormatException('Not a SetOrMapLiteral: ${node.runtimeType}');

        formatState.copyEntity(node.constKeyword, astVisitor, onGetSource: ()=>'$methodName/node.constKeyword');
        formatState.copyEntity(node.typeArguments, astVisitor, onGetSource: ()=>'$methodName/node.typeArguments');
        formatState.copyEntity(node.leftBracket, astVisitor, onGetSource: ()=>'$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.elements, node.rightBracket, astVisitor, '$methodName/node.elements');
        formatState.copyEntity(node.rightBracket, astVisitor, onGetSource: ()=>'$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
