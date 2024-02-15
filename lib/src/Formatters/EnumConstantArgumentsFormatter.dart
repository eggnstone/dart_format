import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class EnumConstantArgumentsFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    EnumConstantArgumentsFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'EnumConstantArgumentsFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! EnumConstantArguments)
            throw FormatException('Not an EnumConstantArguments: ${node.runtimeType}');

        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyEntity(node.constructorSelector, astVisitor, '$methodName/node.constructorSelector');
        formatState.copyEntity(node.argumentList, astVisitor, '$methodName/node.argumentList');
    }
}
