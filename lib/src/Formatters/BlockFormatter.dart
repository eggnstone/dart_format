// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class BlockFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    BlockFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'BlockFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! Block)
            throw FormatException('Not a Block: ${node.runtimeType}');

        if (_canKeepSingleLineClosure(node))
        {
            _formatSingleLineClosure(node);
            if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
            return;
        }

        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }

    bool _canKeepSingleLineClosure(Block node)
    {
        if (!config.fixSpaces)
            return false;

        final AstNode? parent = node.parent;
        if (parent is! BlockFunctionBody)
            return false;

        final AstNode? grandparent = parent.parent;
        if (grandparent is! FunctionExpression)
            return false;

        if (grandparent.parent is FunctionDeclaration)
            return false;

        final String textInside = formatState.getText(node.leftBracket.end, node.rightBracket.offset);
        if (textInside.contains('\n'))
            return false;

        if (textInside.contains('//') || textInside.contains('/*'))
            return false;

        return true;
    }

    void _formatSingleLineClosure(Block node)
    {
        const String methodName = 'BlockFormatter._formatSingleLineClosure';

        formatState.consumeText(formatState.lastConsumedPosition, node.leftBracket.offset, '', methodName, spaces: 1);

        final String blockText = formatState.getText(node.leftBracket.offset, node.rightBracket.end);
        final String normalized = blockText.replaceAll(RegExp(r' +'), ' ');
        formatState.consumeText(node.leftBracket.offset, node.rightBracket.end, normalized, methodName);
    }
}
