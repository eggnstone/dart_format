import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CompilationUnitFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CompilationUnitFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CompilationUnitFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CompilationUnit)
            throw FormatException('Not a CompilationUnit: ${node.runtimeType}');

        node.visitChildren(astVisitor); // covered by tests

        /*// TODO: tests
        if (node.declarations.isEmpty && node.directives.isEmpty)
        formatState.copyToken(node.endToken, addNewLineBefore: false, addNewLineAfter: false, '$methodName/node.endToken');

        // TODO: do not add new line if there is already one
        if (!formatState.getLastText().endsWith('\n'))
        formatState.addNewLineAfterToken(node.endToken, methodName, add: config.addNewLineAtEndOfText);*/

        formatState.consumeTillTheEnd(methodName);

        if (!formatState.getLastText().endsWith('\n'))
            formatState.addNewLineAfterToken(node.endToken, methodName, add: config.addNewLineAtEndOfText);
    }
}
