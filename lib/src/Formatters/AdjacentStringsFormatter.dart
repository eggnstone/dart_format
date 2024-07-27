/*
// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AdjacentStringsFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AdjacentStringsFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AdjacentStringsFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! AdjacentStrings)
            throw FormatException('Not an AdjacentStrings: ${node.runtimeType}');

        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.end);
        //final bool pushLevel2 = textWithPossibleLineBreak.contains('\n');
        log('textWithPossibleLineBreak: ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
        //final bool pushLevel = false;
        //log('pushLevel: $pushLevel', 0);

        */
/*if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');*//*

        formatState.acceptList(node.strings, astVisitor, '$methodName/node.strings');
        //formatState.acceptListWithComma(node.strings, null, astVisitor, '$methodName/node.strings');

        */
/*if (pushLevel)
            formatState.popLevelAndIndent();*//*

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
*/
