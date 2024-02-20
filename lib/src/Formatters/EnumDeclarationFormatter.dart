import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class EnumDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    EnumDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'EnumDeclarationFormatter.format';
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! EnumDeclaration)
            throw FormatException('Not an EnumDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.enumKeyword, astVisitor, '$methodName/node.enumKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.constants, node.rightBracket, astVisitor, '$methodName/node.constants');
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket');

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
