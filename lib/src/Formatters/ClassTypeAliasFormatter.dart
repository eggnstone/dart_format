import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ClassTypeAliasFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ClassTypeAliasFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ClassTypeAliasFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ClassTypeAlias)
            throw FormatException('Not a ClassTypeAlias: ${node.runtimeType}');

        formatState.copyEntity(node.typedefKeyword, astVisitor, '$methodName/typedefKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/typeParameters');
        formatState.copyEntity(node.equals, astVisitor, '$methodName/equals');
        formatState.copyEntity(node.abstractKeyword, astVisitor, '$methodName/abstractKeyword');
        //formatState.copyEntity(node.macroKeyword, astVisitor, '$methodName/macroKeyword');
        formatState.copyEntity(node.sealedKeyword, astVisitor, '$methodName/sealedKeyword');
        formatState.copyEntity(node.baseKeyword, astVisitor, '$methodName/baseKeyword');
        formatState.copyEntity(node.interfaceKeyword, astVisitor, '$methodName/interfaceKeyword');
        formatState.copyEntity(node.finalKeyword, astVisitor, '$methodName/finalKeyword');
        //formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/augmentKeyword');
        formatState.copyEntity(node.mixinKeyword, astVisitor, '$methodName/mixinKeyword');
        formatState.copyEntity(node.superclass, astVisitor, '$methodName/superclass');
        formatState.copyEntity(node.withClause, astVisitor, '$methodName/withClause');
        formatState.copyEntity(node.implementsClause, astVisitor, '$methodName/implementsClause');
        formatState.copySemicolon(node.semicolon, config, '$methodName/semicolon');
    }
}
