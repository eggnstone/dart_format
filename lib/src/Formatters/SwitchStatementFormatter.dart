import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SwitchStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SwitchStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SwitchStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! SwitchStatement)
            throw FormatException('Not a SwitchStatement: ${node.runtimeType}');

        formatState.copyEntity(node.switchKeyword, astVisitor, '$methodName/node.switchKeyword'); // covered by tests
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis'); // covered by tests
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression'); // covered by tests
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis'); // covered by tests
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket'); // covered by tests
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members'); // covered by tests
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket'); // covered by tests
    }
}
