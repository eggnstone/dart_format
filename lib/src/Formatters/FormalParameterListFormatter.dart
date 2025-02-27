// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../Exceptions/DartFormatException.dart';
import '../FormatState.dart';
import '../Tools/FormatTools.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FormalParameterListFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FormalParameterListFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FormalParameterListFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FormalParameterList)
            throw FormatException('Not a FormalParameterList: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dump(node.leftParenthesis, 'leftParenthesis');
        formatState.dump(node.leftDelimiter, 'leftDelimiter');
        formatState.dump(node.rightDelimiter, 'rightDelimiter');
        formatState.dump(node.rightParenthesis, 'rightParenthesis');
        */

        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space0);
        formatState.pushLevel('$methodName/node.leftParenthesis');

        if (node.parameters.isNotEmpty)
            formatState.consumeSpaces(node.parameters.first, config.space0);

        if (node.leftDelimiter != null)
            formatState.consumeSpaces(node.leftDelimiter!, config.space0);

        // TODO: move to FormatState
        AstNode? lastNode;
        bool wroteLeftDelimiter = false;
        for (final FormalParameter parameter in node.parameters)
        {
            //formatState.dump(parameter, 'parameter', '- ');

            final bool shouldWriteLeftDelimiter =
                node.leftDelimiter != null
                    && (parameter.isNamed || parameter.isOptional)
                    && !wroteLeftDelimiter;

            if (lastNode != null)
            {
                final int end = shouldWriteLeftDelimiter ? node.leftDelimiter!.offset : parameter.offset;

                String commaText = formatState.getText(lastNode.end, end);
                if (!FormatTools.isCommaText(commaText))
                    formatState.logAndThrowErrorWithOffsets('commaText is not a comma', '-', StringTools.toDisplayString(commaText), lastNode.end, end, methodName);

                if (config.fixSpaces)
                {
                    final String trimmedCommaText = '${StringTools.trimSpaces(commaText)} ';
                    if (Constants.DEBUG_I_FORMATTER) logDebug('Trimming commaText: ${StringTools.toDisplayString(commaText)} => ${StringTools.toDisplayString(trimmedCommaText)}');
                    commaText = trimmedCommaText;
                }

                formatState.consumeText(lastNode.end, end, commaText, '$methodName/commaText');
            }

            if (shouldWriteLeftDelimiter)
            {
                formatState.copyEntity(node.leftDelimiter, astVisitor, '$methodName/node.leftDelimiter');
                formatState.pushLevel('$methodName/node.leftDelimiter');
                wroteLeftDelimiter = true;
                formatState.consumeSpaces(parameter, config.space0);
            }

            parameter.accept(astVisitor);
            lastNode = parameter;
        }

        // Check for trailing comma
        final Token endToken = node.rightDelimiter ?? node.rightParenthesis;
        if (lastNode != null)
        {
            final AstNode? parentNode = lastNode.parent;
            if (parentNode == null)
                throw DartFormatException.error('parentNode is null');

            String commaText = formatState.getText(lastNode.end, endToken.offset);
            if (FormatTools.isCommaText(commaText))
            {
                if (config.removeTrailingCommas)
                    commaText = commaText.replaceFirst(',', '${Constants.REMOVE_START},${Constants.REMOVE_END}');

                formatState.consumeText(lastNode.end, endToken.offset, commaText, '$methodName/commaText');
            }
        }

        if (node.rightDelimiter != null)
        {
            formatState.popLevelAndIndent();
            formatState.copyEntity(node.rightDelimiter, astVisitor, '$methodName/node.rightDelimiter', config.space0);
        }

        formatState.popLevelAndIndent();
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
