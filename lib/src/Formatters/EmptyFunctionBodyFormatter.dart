import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class EmptyFunctionBodyFormatter extends TypedFormatter<EmptyFunctionBody>
{
    EmptyFunctionBodyFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(EmptyFunctionBody node)
    => formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
}
