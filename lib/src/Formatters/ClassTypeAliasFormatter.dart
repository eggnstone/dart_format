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
        copyZeroOne(node, node.abstractKeyword, '$methodName/node.abstractKeyword');
        copyZeroOne(node, node.typedefKeyword, '$methodName/node.typedefKeyword');
        copyZeroOne(node, node.name, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        // From `equals` onward we leave spacing alone — `C=B` vs `C = B` is a
        // separate formatting decision, not a "collapse extra whitespace" one,
        // and the modifiers that may follow `=` are entangled with that choice.
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals');
        formatState.copyEntity(node.sealedKeyword, astVisitor, '$methodName/node.sealedKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/node.baseKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/node.interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, '$methodName/node.finalKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/node.mixinKeyword');
        formatState.copyEntity(node.superclass, astVisitor, '$methodName/node.superclass');
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
