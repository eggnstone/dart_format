// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExtensionDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExtensionDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExtensionDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! ExtensionDeclaration)
            throw FormatException('Not an ExtensionDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.extensionKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.extensionKeyword'));
        formatState.copyEntity(node.name, astVisitor, onGetStack: () => SimpleStack('$methodName/node.name'));
        formatState.copyEntity(node.typeParameters, astVisitor, onGetStack: () => SimpleStack('$methodName/node.typeParameters'));
        formatState.copyEntity(node.onKeyword, astVisitor, onGetStack: () => SimpleStack('$methodName/node.onKeyword'));
        formatState.copyEntity(node.extendedType, astVisitor, onGetStack: () => SimpleStack('$methodName/node.extendedType'));
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
