/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SwitchCaseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SwitchCaseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SwitchCaseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! SwitchMember)
            throw FormatException('Not a SwitchCase: ${node.runtimeType}');

        formatState.copyEntity(node.keyword, '$methodName/node.keyword'); // covered by tests
        //formatState.acceptNodeList(node.labels, astVisitor, '$methodName/node.labels');
        formatState.copyEntity(node.colon, '$methodName/node.colon'); // covered by tests
        formatState.acceptNodeList(node.statements, astVisitor, '$methodName/node.statements'); // covered by tests
    }
}
*/
