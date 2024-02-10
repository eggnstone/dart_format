import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ShowCombinatorFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ShowCombinatorFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ShowCombinatorFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ShowCombinator)
            throw FormatException('Not a ShowCombinator: ${node.runtimeType}');

        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.acceptListWithComma(node.shownNames, null/*node.endToken*/, astVisitor, '$methodName/node.shownNames');
    }
}
