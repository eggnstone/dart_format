import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FieldDeclarationFormatter extends TypedFormatter<FieldDeclaration>
{
    FieldDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FieldDeclaration node)
    {
        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/node.abstractKeyword');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.covariantKeyword, astVisitor, '$methodName/node.covariantKeyword');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.staticKeyword, astVisitor, '$methodName/node.staticKeyword');
        formatState.copyEntity(node.fields, astVisitor, '$methodName/node.fields');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
