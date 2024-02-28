// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ClassDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ClassDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ClassDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ClassDeclaration)
            throw FormatException('Not a ClassDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //log('### NOT COPYING node.sortedCommentAndAnnotations', 0);

        formatState.copyEntity(node.sealedKeyword, astVisitor, onGetSource: ()=>'$methodName/node.abstractKeyword');
        formatState.copyEntity(node.abstractKeyword, astVisitor, onGetSource: ()=>'$methodName/node.abstractKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, onGetSource: ()=>'$methodName/node.mixinKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, onGetSource: ()=>'$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, onGetSource: ()=>'$methodName/node.finalKeyword');
        formatState.copyEntity(node.classKeyword, astVisitor, onGetSource: ()=>'$methodName/node.classKeyword');
        formatState.copyEntity(node.name, astVisitor, onGetSource: ()=>'$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, onGetSource: ()=>'$methodName/node.typeParameters');
        formatState.copyEntity(node.extendsClause, astVisitor, onGetSource: ()=>'$methodName/node.extendsClause');
        formatState.copyEntity(node.withClause, astVisitor, onGetSource: ()=>'$methodName/node.withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, onGetSource: ()=>'$methodName/node.implementsClause');
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
