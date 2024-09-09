// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
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

        //final String textWithPossibleLineBreak = formatState.getText(node.classKeyword.offset, node.leftBracket.offset);
        //final bool pushLevel = true;//textWithPossibleLineBreak.contains('\n');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.sealedKeyword, astVisitor, '$methodName/node.abstractKeyword');
        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/node.abstractKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/node.baseKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/node.mixinKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, '$methodName/node.finalKeyword');
        formatState.copyEntity(node.classKeyword, astVisitor, '$methodName/node.classKeyword');

        //if (pushLevel)
        formatState.pushLevel('$methodName/node.classKeyword/after');

        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space1);
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.extendsClause, astVisitor, '$methodName/node.extendsClause', config.space1);
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause', config.space1);
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause', config.space1);

        //if (pushLevel)
        formatState.popLevelAndIndent();

        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
