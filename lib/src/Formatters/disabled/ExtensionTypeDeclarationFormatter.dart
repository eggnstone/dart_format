/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExtensionTypeDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExtensionTypeDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExtensionTypeDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ExtensionTypeDeclaration)
            throw FormatException('Not an ExtensionTypeDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.extensionKeyword, astVisitor, '$methodName/node.extensionKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.constKeyword, astVisitor, '$methodName/node.constKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.representation, astVisitor, '$methodName/node.representation');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause');
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members');
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');
    }
}
*/
