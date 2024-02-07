import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ForPartsWithDeclarationsFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForPartsWithDeclarationsFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForPartsWithDeclarationsFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForPartsWithDeclarations)
            throw FormatException('Not a ForPartsWithDeclarations: ${node.runtimeType}');

        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables'); // covered by tests
        formatState.copyEntity(node.leftSeparator, astVisitor, '$methodName/node.leftSeparator'); // covered by tests
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition'); // covered by tests
        formatState.copyEntity(node.rightSeparator, astVisitor, '$methodName/node.rightSeparator'); // covered by tests
        formatState.acceptList(node.updaters, astVisitor, '$methodName/node.updaters'); // covered by tests
    }
}
