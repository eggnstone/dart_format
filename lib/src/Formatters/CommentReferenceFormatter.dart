import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CommentReferenceFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CommentReferenceFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CommentReferenceFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CommentReference)
            throw FormatException('Not a CommentReference: ${node.runtimeType}');

        formatState.copyEntity(node.newKeyword, astVisitor, '$methodName/node.newKeyword');
        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression');
    }
}
