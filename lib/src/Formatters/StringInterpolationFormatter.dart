/*
// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class StringInterpolationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    StringInterpolationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'StringInterpolationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! StringInterpolation)
            throw FormatException('Not a StringInterpolation: ${node.runtimeType}');

        logError('Before node.elements');
        for (final InterpolationElement element in node.elements)
        {
            logError('Before element: ${element.runtimeType} ${StringTools.toDisplayString(element, Constants.MAX_DEBUG_LENGTH)}');
            formatState.copyEntity(element, astVisitor, '$methodName/node.elements');
            logError('After  element: ${element.runtimeType} ${StringTools.toDisplayString(element, Constants.MAX_DEBUG_LENGTH)}');
        }
        logError('After  node.elements');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
*/
