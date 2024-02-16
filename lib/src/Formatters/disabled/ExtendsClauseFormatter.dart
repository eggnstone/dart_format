/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ExtendsClauseFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ExtendsClauseFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ExtendsClauseFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ExtendsClause)
            throw FormatException('Not an ExtendsClause: ${node.runtimeType}');

        formatState.copyEntity(node.extendsKeyword, astVisitor, '$methodName/node.semicolon');
        formatState.copyEntity(node.superclass, astVisitor, '$methodName/node.superclass');
    }
}
*/
