import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class SwitchStatementFormatter extends TypedFormatter<SwitchStatement>
{
    SwitchStatementFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SwitchStatement node)
    {
        formatState.copyEntity(node.switchKeyword, astVisitor, '$methodName/node.switchKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');
    }
}
