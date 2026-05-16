import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class EnumDeclarationFormatter extends TypedFormatter<EnumDeclaration>
{
    EnumDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(EnumDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.enumKeyword, '$methodName/node.enumKeyword');
        copyZeroOne(node, node.namePart.typeName, '$methodName/node.namePart.typeName');
        formatState.copyEntity(node.namePart.typeParameters, astVisitor, '$methodName/node.namePart.typeParameters');
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');

        final EnumBody body = node.body;
        if (body is! BlockEnumBody)
            throw FormatException('Unsupported EnumBody: ${body.runtimeType}');

        formatState.copyOpeningBraceAndPushLevel(body.leftBracket, config, '$methodName/node.body.leftBracket');
        // TODO: precedingComments: on semicolon, too. Check other formatters, too.
        final Token endTokenForConstants = body.semicolon ?? body.rightBracket.precedingComments ?? body.rightBracket;
        formatState.acceptListWithComma(body.constants, endTokenForConstants, astVisitor, '$methodName/node.body.constants');
        formatState.copySemicolon(body.semicolon, config, '$methodName/node.body.semicolon', config.space0);
        formatState.acceptList(body.members, astVisitor, '$methodName/node.body.members');
        formatState.copyClosingBraceAndPopLevel(body.rightBracket, config, '$methodName/node.body.rightBracket');
    }
}
