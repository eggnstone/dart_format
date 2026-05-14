import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class FunctionTypedFormalParameterFormatter extends TypedFormatter<FunctionTypedFormalParameter>
{
    FunctionTypedFormalParameterFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionTypedFormalParameter node)
    {
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.covariantKeyword, astVisitor, '$methodName/node.covariantKeyword');
        formatState.copyEntity(node.requiredKeyword, astVisitor, '$methodName/node.requiredKeyword');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name');
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters');
        formatState.copyEntity(node.parameters, astVisitor, '$methodName/node.parameters');
        // This whole formatter should not be necessary, because it doesn't do anything special.
        // But when FormalParameterListFormatter calls parameter.accept(astVisitor); the question is omitted.
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question');
    }
}
