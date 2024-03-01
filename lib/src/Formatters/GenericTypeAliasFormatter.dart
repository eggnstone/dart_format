// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class GenericTypeAliasFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    GenericTypeAliasFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'GenericTypeAliasFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! GenericTypeAlias)
            throw FormatException('Not a GenericTypeAlias: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.typedefKeyword, astVisitor, onGetSource: ()=>'$methodName/node.typedefKeyword');
        formatState.copyEntity(node.name, astVisitor, onGetSource: ()=>'$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, onGetSource: ()=>'$methodName/node.typeParameters');
        formatState.copyEntity(node.equals, astVisitor, onGetSource: ()=>'$methodName/node.equals');
        formatState.copyEntity(node.type, astVisitor, onGetSource: ()=>'$methodName/node.type');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
