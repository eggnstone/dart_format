import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class NativeFunctionBodyFormatter extends TypedFormatter<NativeFunctionBody>
{
    NativeFunctionBodyFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(NativeFunctionBody node)
    {
        formatState.copyEntity(node.nativeKeyword, astVisitor, '$methodName/node.nativeKeyword', config.space1);
        formatState.copyEntity(node.stringLiteral, astVisitor, '$methodName/node.stringLiteral', config.space1);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
