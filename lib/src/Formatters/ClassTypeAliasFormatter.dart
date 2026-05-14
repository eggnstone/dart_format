import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ClassTypeAliasFormatter extends TypedFormatter<ClassTypeAlias>
{
    ClassTypeAliasFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ClassTypeAlias node)
    {
        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/node.abstractKeyword');
        formatState.copyEntity(node.typedefKeyword, astVisitor, '$methodName/node.typedefKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals');
        //formatState.copyEntity(node.macroKeyword, astVisitor, '$methodName/node.macroKeyword');
        formatState.copyEntity(node.sealedKeyword, astVisitor, '$methodName/node.sealedKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/node.baseKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, '$methodName/node.finalKeyword');
        //formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/node.mixinKeyword');
        formatState.copyEntity(node.superclass, astVisitor, '$methodName/node.superclass');
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
