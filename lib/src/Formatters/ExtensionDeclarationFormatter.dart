// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ExtensionDeclaration)
            throw FormatException('Not an ExtensionDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.extensionKeyword, astVisitor, '$methodName/node.extensionKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');

        formatState.copyEntity(node.onClause, astVisitor, '$methodName/node.onClause');
        /*
        onClause replaces onKeyword and extendedType
        formatState.copyEntity(node.onKeyword, astVisitor, '$methodName/node.onKeyword');
        formatState.copyEntity(node.extendedType, astVisitor, '$methodName/node.extendedType');
        */

        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
