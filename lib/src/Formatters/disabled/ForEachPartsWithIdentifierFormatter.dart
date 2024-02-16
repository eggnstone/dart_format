/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ForEachPartsWithIdentifierFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForEachPartsWithIdentifierFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForEachPartsWithIdentifierFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForEachPartsWithIdentifier)
            throw FormatException('Not a ForEachPartsWithIdentifier: ${node.runtimeType}');

        formatState.copyEntity(node.inKeyword, astVisitor, '$methodName/node.inKeyword');
        formatState.copyEntity(node.iterable, astVisitor, '$methodName/node.iterable');
        formatState.copyEntity(node.identifier, astVisitor, '$methodName/node.identifier');
    }
}
*/
