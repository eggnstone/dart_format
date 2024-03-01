// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../SimpleStack.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class RecordTypeAnnotationNamedFieldsFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    RecordTypeAnnotationNamedFieldsFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'RecordTypeAnnotationNamedFieldsFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! RecordTypeAnnotationNamedFields)
            throw FormatException('Not a RecordTypeAnnotationNamedFields: ${node.runtimeType}');

        formatState.copyEntity(node.leftBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.leftBracket'));
        formatState.acceptListWithComma(node.fields, node.rightBracket, astVisitor, '$methodName/node.fields');
        formatState.copyEntity(node.rightBracket, astVisitor, onGetStack: () => SimpleStack('$methodName/node.rightBracket'));

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
