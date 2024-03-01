// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class TypeParameterListFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TypeParameterListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'TypeParameterListFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! TypeParameterList)
            throw FormatException('Not a TypeParameterList: ${node.runtimeType}');

        formatState.copyEntity(node.leftBracket, astVisitor, onGetSource: ()=>'$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.typeParameters, node.rightBracket, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.rightBracket, astVisitor,onGetSource: ()=> '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
