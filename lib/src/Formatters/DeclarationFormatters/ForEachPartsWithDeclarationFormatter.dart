import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class ForEachPartsWithDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ForEachPartsWithDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ForEachPartsWithDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ForEachPartsWithDeclaration)
            throw FormatException('Not a ForEachPartsWithDeclaration: ${node.runtimeType}');

        formatState.copyEntity(node.loopVariable, astVisitor, '$methodName/node.loopVariable'); // covered by tests
        formatState.copyEntity(node.inKeyword, astVisitor, '$methodName/node.inKeyword'); // covered by tests
        formatState.copyEntity(node.iterable, astVisitor, '$methodName/node.iterable'); // covered by tests
    }
}
