/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class HideCombinatorFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    HideCombinatorFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'HideCombinatorFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! HideCombinator)
            throw FormatException('Not a HideCombinator: ${node.runtimeType}');

        formatState.acceptListWithComma(node.hiddenNames, null, astVisitor, '$methodName/node.hiddenNames');
    }
}
*/
