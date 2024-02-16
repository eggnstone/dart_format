/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionReferenceFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionReferenceFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionReferenceFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! FunctionReference)
            throw FormatException('Not a FunctionReference: ${node.runtimeType}');

        formatState.copyEntity(node.function, astVisitor, '$methodName/node.function');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');

    }
}
*/
