import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class DefaultFormalParameterFormatter extends TypedFormatter<DefaultFormalParameter>
{
    DefaultFormalParameterFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(DefaultFormalParameter node)
    {
        /*
        formatState.dump(node, 'node');
        formatState.dump(node.parameter, 'parameter');
        formatState.dump(node.separator, 'separator');
        formatState.dump(node.defaultValue, 'defaultValue');
        */

        formatState.copyEntity(node.parameter, astVisitor, '$methodName/node.parameter');

        int? spacesForSeparator;
        if (config.fixSpaces)
            spacesForSeparator = node.separator?.lexeme == '=' ? 1 : node.separator?.lexeme == ':' ? 0 : null;

        formatState.copyEntity(node.separator, astVisitor, '$methodName/node.separator', spacesForSeparator);
        formatState.copyEntity(node.defaultValue, astVisitor, '$methodName/node.defaultValue', config.space1);
    }
}
