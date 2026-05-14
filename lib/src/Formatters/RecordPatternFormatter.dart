import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class RecordPatternFormatter extends TypedFormatter<RecordPattern>
{
    RecordPatternFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RecordPattern node)
    {
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis');
        formatState.acceptListWithComma(node.fields, node.rightParenthesis, astVisitor, '$methodName/node.fields', trimCommaText: config.fixSpaces);
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
    }
}
