import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class EmptyStatementFormatter extends TypedFormatter<EmptyStatement>
{
    EmptyStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(EmptyStatement node)
    => formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
}
