// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class EnumDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    EnumDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'EnumDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! EnumDeclaration)
            throw FormatException('Not an EnumDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.enumKeyword, astVisitor, '$methodName/node.enumKeyword');
        formatState.copyEntity(node.namePart.typeName, astVisitor, '$methodName/node.namePart.typeName');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');
        formatState.copyOpeningBraceAndPushLevel(node.body.leftBracket, config, '$methodName/node.body.leftBracket');
        // TODO: precedingComments: on semicolon, too. Check other formatters, too.
        final Token endTokenForConstants = node.body.semicolon ?? node.body.rightBracket.precedingComments ?? node.body.rightBracket;
        formatState.acceptListWithComma(node.body.constants, endTokenForConstants, astVisitor, '$methodName/node.body.constants');
        formatState.copySemicolon(node.body.semicolon, config, '$methodName/node.body.semicolon', config.space0);
        formatState.acceptList(node.body.members, astVisitor, '$methodName/node.body.members');
        formatState.copyClosingBraceAndPopLevel(node.body.rightBracket, config, '$methodName/node.body.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
