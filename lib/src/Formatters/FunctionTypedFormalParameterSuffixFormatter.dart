import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class FunctionTypedFormalParameterSuffixFormatter extends TypedFormatter<FunctionTypedFormalParameterSuffix>
{
    FunctionTypedFormalParameterSuffixFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(FunctionTypedFormalParameterSuffix node)
    {
        formatState.copyEntity(node.typeParameters, astVisitor, '$methodName/node.typeParameters', config.space0);
        formatState.copyEntity(node.formalParameters, astVisitor, '$methodName/node.formalParameters', config.space0);
        formatState.copyEntity(node.question, astVisitor, '$methodName/node.question', config.space0);
    }
}
