// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionTypeAliasFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionTypeAliasFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithExpressionFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FunctionTypeAlias)
            throw FormatException('Not a FunctionTypeAlias: ${node.runtimeType}');

        formatState.copyEntity(node.typedefKeyword, astVisitor, onGetSource: ()=>'$methodName/node.typedefKeyword');
        formatState.copyEntity(node.returnType, astVisitor, onGetSource: ()=>'$methodName/node.returnType');
        formatState.copyEntity(node.name, astVisitor, onGetSource: ()=>'$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, onGetSource: ()=>'$methodName/node.typeParameters');
        formatState.copyEntity(node.parameters, astVisitor, onGetSource: ()=>'$methodName/node.parameters');
        formatState.copySemicolon(node.semicolon, config, methodName);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
