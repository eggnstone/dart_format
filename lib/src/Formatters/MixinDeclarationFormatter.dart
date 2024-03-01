// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class MixinDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    MixinDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'MixinDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! MixinDeclaration)
            throw FormatException('Not a MixinDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //log('### NOT COPYING node.sortedCommentAndAnnotations', 0);

        formatState.copyEntity(node.mixinKeyword, astVisitor, onGetSource: ()=>'$methodName/node.mixinKeyword');
        formatState.copyEntity(node.name, astVisitor, onGetSource: ()=>'$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, onGetSource: ()=>'$methodName/node.typeParameters');
        formatState.copyEntity(node.onClause, astVisitor, onGetSource: ()=>'$methodName/node.onClause');
        formatState.copyEntity(node.implementsClause, astVisitor, onGetSource: ()=>'$methodName/node.implementsClause');
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
