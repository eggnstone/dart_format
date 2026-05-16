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
        copyZeroOne(node, node.abstractKeyword, '$methodName/node.abstractKeyword');
        copyZeroOne(node, node.augmentKeyword, '$methodName/node.augmentKeyword');
        copyZeroOne(node, node.covariantKeyword, '$methodName/node.covariantKeyword');
        copyZeroOne(node, node.externalKeyword, '$methodName/node.externalKeyword');
        copyZeroOne(node, node.staticKeyword, '$methodName/node.staticKeyword');
        copyZeroOne(node, node.fields, '$methodName/node.fields');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
