import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import '../FormatState.dart';
import '../Tools/FormatTools.dart';
import '../Tools/StringTools.dart';
import '../Types/IndentationType.dart';
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
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! FormalParameterList)
            throw FormatException('Not a FormalParameterList: ${node.runtimeType}');

        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis'); // covered by tests
        formatState.pushLevel('$methodName/node.leftParenthesis', IndentationType.single); // covered by tests

        // TODO: move to FormatState
        AstNode? lastNode;
        bool wroteLeftDelimiter = false;
        for (final FormalParameter parameter in node.parameters)
        {
            final bool shouldWriteLeftDelimiter =
            node.leftDelimiter != null
            && (parameter.isNamed || parameter.isOptional)
            && !wroteLeftDelimiter;

            if (lastNode != null)
            {
                final int end = shouldWriteLeftDelimiter ? node.leftDelimiter!.offset : parameter.offset;
                final String commaText = formatState.getText(lastNode.end, end);
                if (!FormatTools.isCommaText(commaText))
                    throw DartFormatException.error('commaText is not a comma: ${StringTools.toDisplayString(commaText)}');

                formatState.consumeText(lastNode.end, end, commaText, '$methodName/Comma');
            }

            if (shouldWriteLeftDelimiter)
            {
                formatState.copyEntity(node.leftDelimiter, astVisitor, '$methodName/node.leftDelimiter'); // covered by tests
                formatState.pushLevel('$methodName/node.leftDelimiter', IndentationType.single); // covered by tests
                wroteLeftDelimiter = true;
            }

            parameter.accept(astVisitor); // covered by tests
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

                formatState.consumeText(lastNode.end, endToken.offset, commaText, '$methodName/TrailingComma');
            }
        }

        if (node.rightDelimiter != null)
        {
            formatState.popLevelAndIndent(); // covered by tests
            formatState.copyEntity(node.rightDelimiter, astVisitor, '$methodName/node.rightDelimiter'); // covered by tests
        }

        formatState.popLevelAndIndent(); // covered by tests
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis'); // covered by tests
    }
}
