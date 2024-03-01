// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class RecordTypeAnnotationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    RecordTypeAnnotationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'RecordTypeAnnotationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node)})', formatState.logIndent++);

        if (node is! RecordTypeAnnotation)
            throw FormatException('Not a RecordTypeAnnotation: ${node.runtimeType}');

        formatState.copyEntity(node.leftParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.leftParenthesis');

        final Token endTokenForPositionalFields = node.namedFields?.beginToken  ?? node.rightParenthesis;
        formatState.acceptListWithComma(node.positionalFields, endTokenForPositionalFields, astVisitor, '$methodName/node.positionalFields');
        formatState.copyEntity(node.namedFields, astVisitor, onGetSource: ()=>'$methodName/node.namedFields');
        formatState.copyEntity(node.rightParenthesis, astVisitor, onGetSource: ()=>'$methodName/node.rightParenthesis');

        formatState.copyEntity(node.question, astVisitor, onGetSource: ()=>'$methodName/node.question');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node)})', --formatState.logIndent);
    }
}
