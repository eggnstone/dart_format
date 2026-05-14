import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class RecordTypeAnnotationFormatter extends TypedFormatter<RecordTypeAnnotation>
{
    RecordTypeAnnotationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RecordTypeAnnotation node)
    {
        formatState.copyEntity(node.leftParenthesis, astVisitor, '$methodName/node.leftParenthesis', config.space0);

        final Token endTokenForPositionalFields = node.namedFields?.beginToken ?? node.rightParenthesis;
        formatState.acceptListWithComma(node.positionalFields, endTokenForPositionalFields, astVisitor, '$methodName/node.positionalFields');
        formatState.copyEntity(node.namedFields, astVisitor, '$methodName/node.namedFields');
        formatState.copyEntity(node.rightParenthesis, astVisitor, '$methodName/node.rightParenthesis', config.space0);

        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
    }
}
