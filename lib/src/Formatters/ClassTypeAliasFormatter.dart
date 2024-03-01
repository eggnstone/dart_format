// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ClassTypeAliasFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ClassTypeAliasFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ClassTypeAliasFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! ClassTypeAlias)
            throw FormatException('Not a ClassTypeAlias: ${node.runtimeType}');

        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.typedefKeyword, astVisitor, onGetSource: ()=>'$methodName/node.typedefKeyword');
        formatState.copyEntity(node.name, astVisitor, onGetSource: ()=>'$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, onGetSource: ()=>'$methodName/node.typeParameters');
        formatState.copyEntity(node.equals, astVisitor, onGetSource: ()=>'$methodName/node.equals');
        formatState.copyEntity(node.abstractKeyword, astVisitor, onGetSource: ()=>'$methodName/node.abstractKeyword');
        //formatState.copyEntity(node.macroKeyword, astVisitor, '$methodName/node.macroKeyword');
        formatState.copyEntity(node.sealedKeyword, astVisitor, onGetSource: ()=>'$methodName/node.sealedKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, onGetSource: ()=>'$methodName/node.baseKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, onGetSource: ()=>'$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, onGetSource: ()=>'$methodName/node.finalKeyword');
        //formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, onGetSource: ()=>'$methodName/node.mixinKeyword');
        formatState.copyEntity(node.superclass, astVisitor, onGetSource: ()=>'$methodName/node.superclass');
        formatState.copyEntity(node.withClause, astVisitor, onGetSource: ()=>'$methodName/node.withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, onGetSource: ()=>'$methodName/node.implementsClause');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
