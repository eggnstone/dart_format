/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class NamedTypeFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    NamedTypeFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'NamedTypeFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! NamedType)
            throw FormatException('Not a NamedType: ${node.runtimeType}');

        formatState.copyEntity(node.importPrefix, astVisitor, '$methodName/node.importPrefix');
        formatState.copyEntity(node.name2, astVisitor, '$methodName/node.name2');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
    }
}
*/
