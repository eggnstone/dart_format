import 'package:analyzer/dart/ast/ast.dart';

import '../Data/Config.dart';
import 'TypedFormatter.dart';

class SetOrMapLiteralFormatter extends TypedFormatter<SetOrMapLiteral>
{
    SetOrMapLiteralFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SetOrMapLiteral node)
    {
        final String textInside = formatState.getText(node.leftBracket.end, node.rightBracket.offset);

        // If the block does not contain any line breaks, then leave it as is.
        final Config adjustedConfig = textInside.contains('\n')
            ? config
            : config.copyWith(addNewLineBeforeOpeningBrace: false, addNewLineAfterOpeningBrace: false, addNewLineBeforeClosingBrace: false, addNewLineAfterClosingBrace: false);

        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.typeArguments, astVisitor, '$methodName/node.typeArguments');
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, adjustedConfig, '$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.elements, node.rightBracket, astVisitor, '$methodName/node.elements');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, adjustedConfig, '$methodName/node.rightBracket');
    }
}
