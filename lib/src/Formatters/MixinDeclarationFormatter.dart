import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class MixinDeclarationFormatter extends TypedFormatter<MixinDeclaration>
{
    MixinDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(MixinDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/node.baseKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/node.mixinKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.onClause, astVisitor, '$methodName/node.onClause');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');
        final ClassBody body = node.body;
        if (body is! BlockClassBody)
            throw FormatException('Unsupported ClassBody: ${body.runtimeType}');

        formatState.copyOpeningBraceAndPushLevel(body.leftBracket, config, '$methodName/node.body.leftBracket');
        formatState.acceptList(body.members, astVisitor, '$methodName/node.body.members');
        formatState.copyClosingBraceAndPopLevel(body.rightBracket, config, '$methodName/node.body.rightBracket');
    }
}
