import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class RecordTypeAnnotationNamedFieldsFormatter extends TypedFormatter<RecordTypeAnnotationNamedFields>
{
    RecordTypeAnnotationNamedFieldsFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(RecordTypeAnnotationNamedFields node)
    {
        formatState.copyEntity(node.leftBracket, astVisitor, '$methodName/node.leftBracket');
        formatState.acceptListWithComma(node.fields, node.rightBracket, astVisitor, '$methodName/node.fields');
        formatState.copyEntity(node.rightBracket, astVisitor, '$methodName/node.rightBracket');
    }
}
