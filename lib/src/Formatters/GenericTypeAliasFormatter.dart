import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class GenericTypeAliasFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    GenericTypeAliasFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'GenericTypeAliasFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! GenericTypeAlias)
            throw FormatException('Not a GenericTypeAlias: ${node.runtimeType}');

        formatState.copyEntity(node.typedefKeyword, astVisitor, '$methodName/node.typedefKeyword'); // covered by tests
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name'); // covered by tests
        formatState.copyEntity(node.equals, astVisitor, '$methodName/node.equals'); // covered by tests
        formatState.copyEntity(node.type, astVisitor, '$methodName/node.type'); // covered by tests
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
