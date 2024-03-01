// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FieldDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FieldDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FieldDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! FieldDeclaration)
            throw FormatException('Not a FieldDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //log('### NOT COPYING node.sortedCommentAndAnnotations', 0);

        formatState.copyEntity(node.externalKeyword, astVisitor, onGetSource: ()=>'$methodName/node.externalKeyword');
        formatState.copyEntity(node.staticKeyword, astVisitor, onGetSource: ()=>'$methodName/node.staticKeyword');
        formatState.copyEntity(node.fields, astVisitor, onGetSource: ()=>'$methodName/node.fields');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
