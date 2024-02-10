import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExtensionDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExtensionDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExtensionDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ExtensionDeclaration)
            throw FormatException('Not an ExtensionDeclaration: ${node.runtimeType}');

        formatState.copyEntity(node.extensionKeyword, astVisitor, '$methodName/node.extensionKeyword'); // covered by tests
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name'); // covered by tests
        formatState.copyEntity(node.onKeyword, astVisitor, '$methodName/node.onKeyword'); // covered by tests
        formatState.copyEntity(node.extendedType, astVisitor, '$methodName/node.extendedType'); // covered by tests
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket'); // covered by tests
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members'); // covered by tests
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket'); // covered by tests
    }
}
