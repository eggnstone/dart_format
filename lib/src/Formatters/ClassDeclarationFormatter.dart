import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ClassDeclarationFormatter extends TypedFormatter<ClassDeclaration>
{
    ClassDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ClassDeclaration node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/node.abstractKeyword');
        formatState.copyEntity(node.sealedKeyword, astVisitor, '$methodName/node.sealedKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/node.baseKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, '$methodName/node.finalKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/node.mixinKeyword');
        formatState.copyEntity(node.classKeyword, astVisitor, '$methodName/node.classKeyword');

        formatState.pushLevel('$methodName/node.classKeyword/after');

        formatState.copyEntity(node.namePart.typeName, astVisitor, '$methodName/node.namePart.typeName', config.space1);
        formatState.copyEntity(node.namePart.typeParameters, astVisitor, '$methodName/node.namePart.typeParameters');
        formatState.copyEntity(node.extendsClause, astVisitor, '$methodName/node.extendsClause', config.space1);
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause', config.space1);
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause', config.space1);
        formatState.copyEntity(node.nativeClause, astVisitor, '$methodName/node.nativeClause', config.space1);

        formatState.popLevelAndIndent();

        final ClassBody body = node.body;
        if (body is! BlockClassBody)
            throw FormatException('Unsupported ClassBody: ${body.runtimeType}');

        formatState.copyOpeningBraceAndPushLevel(body.leftBracket, config, '$methodName/node.body.leftBracket');
        formatState.acceptList(body.members, astVisitor, '$methodName/node.body.members');
        formatState.copyClosingBraceAndPopLevel(body.rightBracket, config, '$methodName/node.body.rightBracket');
    }
}
