/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForPartsWithPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForPartsWithPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithPatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForPartsWithPattern)
            throw FormatException('Not a ForPartsWithPattern: ${node.runtimeType}');

        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables'); 
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator');
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator');
        formatState.acceptList(node.updaters, astVisitor, '$methodName/node.updaters');
    }
}
*/
