/*
// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Exceptions/DartFormatException.dart';
import '../FormatState.dart';
import '../Tools/FormatTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ForEachPartsWithDeclaration)
            throw FormatException('Not a ForEachPartsWithDeclaration: ${node.runtimeType}');

        formatState.copyEntity(node.loopVariable, astVisitor, '$methodName/node.loopVariable');
        formatState.copyEntity(node.inKeyword, astVisitor, '$methodName/node.inKeyword');
        formatState.copyEntity(node.iterable, astVisitor, '$methodName/node.iterable');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
*/
