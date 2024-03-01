// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/FormatTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AssertInitializerFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AssertInitializerFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AssertInitializerFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! AssertInitializer)
            throw FormatException('Not an AssertInitializer: ${node.runtimeType}');

        formatState.copyEntity(node.assertKeyword, astVisitor, onGetSource: ()=>'$methodName/node.assertKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.leftParenthesis');
        formatState.copyEntity(node.condition, astVisitor, onGetSource: ()=>'$methodName/node.condition');
        formatState.copyEntity(node.comma, astVisitor, onGetSource: ()=>'$methodName/node.comma');
        formatState.copyEntity(node.message, astVisitor, onGetSource: ()=>'$methodName/node.message');

        final SyntacticEntity nodeBeforeRightParenthesis = node.message ?? node.comma ?? node.condition;
        if (Constants.DEBUG_I_FORMATTER)
        {
            log('node.comma: ${node.comma}', formatState.logIndent);
            log('node.message: ${node.message}', formatState.logIndent);
            log('node.nodeBeforeRightParenthesis: $nodeBeforeRightParenthesis', formatState.logIndent);
        }
        final int start = nodeBeforeRightParenthesis.end;
        final int end = node.rightParenthesis.offset;
        String commaText = formatState.getText(start, end);
        if (Constants.DEBUG_I_FORMATTER) log('commaText: ${StringTools.toDisplayString(commaText)}', formatState.logIndent - 1);
        if (FormatTools.isCommaText(commaText))
        {
            if (config.removeTrailingCommas)
                commaText = commaText.replaceFirst(',', '${Constants.REMOVE_START},${Constants.REMOVE_END}');

            formatState.consumeText(start, end, commaText, '$methodName/TrailingComma');
        }

        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.rightParenthesis');
        //formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
