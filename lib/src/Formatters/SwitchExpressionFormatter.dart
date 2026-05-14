import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class SwitchExpressionFormatter extends TypedFormatter<SwitchExpression>
{
    SwitchExpressionFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SwitchExpression node)
    {
        // Why does this not work with the default formatter?
        // The commas were missing then!
        formatState.copyEntity(node.switchKeyword, astVisitor, '$methodName/node.switchKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space1);
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.cases, node.rightBracket, astVisitor, '$methodName/node.cases');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');
    }
}
