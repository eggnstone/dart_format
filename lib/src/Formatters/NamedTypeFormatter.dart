import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class NamedTypeFormatter extends TypedFormatter<NamedType>
{
    NamedTypeFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(NamedType node)
    {
        /*
        formatState.dump(node, 'node');
        formatState.dump(node.importPrefix, 'importPrefix');
        formatState.dump(node.name2, 'name2');
        formatState.dump(node.typeArguments, 'typeArguments');
        formatState.dump(node.question, 'question');
        */

        final int? spacesForName2 = config.fixSpaces ? (node.offset == node.name.offset ? null : 0) : null;

        formatState.copyEntity(node.importPrefix, astVisitor, '$methodName/node.importPrefix');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', spacesForName2);
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments', config.space0);
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space0);
    }
}
