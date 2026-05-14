import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class ExpressionFunctionBodyFormatter extends TypedFormatter<ExpressionFunctionBody>
{
    ExpressionFunctionBodyFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ExpressionFunctionBody node)
    {
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.star, astVisitor, '$methodName/node.star');

        formatState.copyEntity(node.functionDefinition, astVisitor, '$methodName/node.functionDefinition');
        //final int? spacesForFunctionDefinition = config.fixSpaces ? (node.offset == node.functionDefinition.offset ? 0 : 1) : null;
        //formatState.copyEntity(node.functionDefinition, astVisitor, '$methodName/node.functionDefinition', spacesForFunctionDefinition);

        formatState.copyEntity(node.expression, astVisitor, '$methodName/node.expression', config.space1);
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
