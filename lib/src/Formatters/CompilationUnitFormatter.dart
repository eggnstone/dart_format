// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Tools/StringTools.dart';
import 'TypedFormatter.dart';

class CompilationUnitFormatter extends TypedFormatter<CompilationUnit>
{
    CompilationUnitFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(CompilationUnit node)
    {
        if (Constants.DEBUG_I_FORMATTER) log('# START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent);
        formatState.logIndent += 2;

        node.visitChildren(astVisitor);

        /*// TODO: tests
        if (node.declarations.isEmpty && node.directives.isEmpty)
        formatState.copyToken(node.endToken, addNewLineBefore: false, addNewLineAfter: false, '$methodName/node.endToken');

        // TODO: do not add new line if there is already one
        if (!formatState.getLastText().endsWith('\n'))
        formatState.addNewLineAfterToken(node.endToken, methodName, add: config.addNewLineAtEndOfText);*/

        formatState.consumeTillTheEnd(methodName);

        if (!formatState.getLastText().endsWith('\n'))
            formatState.addNewLineAfterToken(node.endToken, methodName, add: config.addNewLineAtEndOfText);

        formatState.logIndent -= 2;
        if (Constants.DEBUG_I_FORMATTER) log('# END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent);
    }
}
