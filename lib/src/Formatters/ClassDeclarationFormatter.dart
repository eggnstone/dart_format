import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ClassDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ClassDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ClassDeclarationFormatter.format';
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! ClassDeclaration)
            throw FormatException('Not a ClassDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        //log('### NOT COPYING node.sortedCommentAndAnnotations', 0);

        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/node.abstractKeyword'); // covered by tests
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/node.interfaceKeyword'); // covered by tests
        formatState.copyEntity(node.classKeyword, astVisitor, '$methodName/node.classKeyword'); // covered by tests
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name'); // covered by tests
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters'); // covered by tests
        formatState.copyEntity(node.extendsClause, astVisitor, '$methodName/node.extendsClause'); // covered by tests
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/node.withClause'); // covered by tests
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/node.implementsClause'); // covered by tests
        formatState.copyOpeningBraceAndPushLevel(node.leftBracket, config, '$methodName/node.leftBracket'); // covered by tests
        formatState.acceptList(node.members, astVisitor, '$methodName/node.members'); // covered by tests
        formatState.copyClosingBraceAndPopLevel(node.rightBracket, config, '$methodName/node.rightBracket'); // covered by tests

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
