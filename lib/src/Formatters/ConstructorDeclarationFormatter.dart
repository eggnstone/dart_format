import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import '../Enums/IndentationType.dart';
import 'TypedFormatter.dart';

class ConstructorDeclarationFormatter extends TypedFormatter<ConstructorDeclaration>
{
    ConstructorDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ConstructorDeclaration node)
    {
        // https://github.com/dart-lang/sdk/issues/62067
        // returnType => typeName!
        final int headOffset = node.typeName?.offset ?? node.newKeyword!.offset;
        final int? spacesBeforeHead = config.fixSpaces ? (node.offset == headOffset ? null : 1) : null;

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.factoryKeyword, astVisitor, '$methodName/node.factoryKeyword');
        formatState.copyEntity(node.newKeyword, astVisitor, '$methodName/node.newKeyword', spacesBeforeHead);
        // https://github.com/dart-lang/sdk/issues/62067
        // returnType => typeName!
        formatState.copyEntity(node.typeName, astVisitor, '$methodName/node.typeName', spacesBeforeHead);
        formatState.copyEntity(node.period, astVisitor, '$methodName/node.period');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');
        final int separatorIndentSize = config.indentationSpacesPerLevel < 2 ? 0 : config.indentationSpacesPerLevel - 2;
        formatState.pushLevel('$methodName/node.separator', IndentationType.single, separatorIndentSize);
        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator', config.space1);
        formatState.popLevelAndIndent();

        formatState.pushLevel('$methodName/node.initializers');
        formatState.copyEntity(node.redirectedConstructor, astVisitor, '$methodName/node.redirectedConstructor', config.space1);
        formatState.acceptListWithComma(node.initializers, null, astVisitor, '$methodName/node.initializers', leadingSpaces: config.space1, trimCommaText: config.fixSpaces);
        formatState.popLevelAndIndent();
        formatState.copyEntity(node.body, astVisitor, '$methodName/node.body');
    }
}
