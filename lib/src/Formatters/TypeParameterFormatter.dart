import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class TypeParameterFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TypeParameterFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'TypeParameterFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! TypeParameter)
            throw FormatException('Not a TypeParameter: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        /*formatState.acceptListOld(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.extendsKeyword, astVisitor, '$methodName/node.extendsKeyword');
        formatState.copyEntity(node.bound, astVisitor, '$methodName/node.bound');*/
    }
}
