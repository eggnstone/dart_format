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
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.abstractKeyword, '$methodName/node.abstractKeyword');
        copyZeroOne(node, node.sealedKeyword, '$methodName/node.sealedKeyword');
        copyZeroOne(node, node.baseKeyword, '$methodName/node.baseKeyword');
        copyZeroOne(node, node.interfaceKeyword, '$methodName/node.interfaceKeyword');
        copyZeroOne(node, node.finalKeyword, '$methodName/node.finalKeyword');
        copyZeroOne(node, node.mixinKeyword, '$methodName/node.mixinKeyword');
        copyZeroOne(node, node.classKeyword, '$methodName/node.classKeyword');

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
