// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class SetOrMapLiteralFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    SetOrMapLiteralFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'SetOrMapLiteralFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! SetOrMapLiteral)
            throw FormatException('Not a SetOrMapLiteral: ${node.runtimeType}');

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

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
