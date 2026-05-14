import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class BlockFormatter extends TypedFormatter<Block>
{
    BlockFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(Block node)
    {
        if (_canKeepSingleLineClosure(node))
        {
            _formatSingleLineClosure(node);
            return;
        }

        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');
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
        formatState.consumeText(formatState.lastConsumedPosition, node.leftBracket.offset, '', methodName, spaces: 1);

        final String blockText = formatState.getText(node.leftBracket.offset, node.rightBracket.end);
        final String normalized = blockText.replaceAll(RegExp(' +'), ' ');
        formatState.consumeText(node.leftBracket.offset, node.rightBracket.end, normalized, methodName);
    }
}
