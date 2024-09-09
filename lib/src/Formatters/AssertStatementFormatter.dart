// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/FormatTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AssertStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AssertStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AssertStatementFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! AssertStatement)
            throw FormatException('Not an AssertStatement: ${node.runtimeType}');

        formatState.copyEntity(node.assertKeyword, astVisitor, '$methodName/node.assertKeyword');
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space0);
        formatState.copyEntity(node.condition, astVisitor, '$methodName/node.condition');
        formatState.copyEntity(node.comma, astVisitor, '$methodName/node.comma', config.space0);
        formatState.copyEntity(node.message, astVisitor, '$methodName/node.message');

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

            if (config.fixSpaces)
            {
                commaText = StringTools.trimSpaces(commaText);
                if (Constants.DEBUG_I_FORMATTER) log('commaText: ${StringTools.toDisplayString(commaText)}', formatState.logIndent - 1);
            }

            formatState.consumeText(start, end, commaText, '$methodName/TrailingComma', spaces: config.space0);
        }

        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
