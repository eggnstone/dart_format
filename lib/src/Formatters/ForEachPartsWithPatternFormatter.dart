import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForEachPartsWithPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForEachPartsWithPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForEachPartsWithPatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForEachPartsWithPattern)
            throw FormatException('Not a ForEachPartsWithPattern: ${node.runtimeType}');

        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.pattern, astVisitor, '$methodName/node.pattern');
        formatState.copyEntity(node.inKeyword, astVisitor, '$methodName/node.inKeyword');
        formatState.copyEntity(node.iterable, astVisitor, '$methodName/node.iterable');
    }
}
