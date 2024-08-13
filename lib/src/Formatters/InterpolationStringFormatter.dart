// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class InterpolationStringFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    InterpolationStringFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'InterpolationStringFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! InterpolationString)
            throw FormatException('Not an InterpolationString: ${node.runtimeType}');

        logError('Before node.contents: ${node.contents.runtimeType} ${StringTools.toDisplayString(node.contents, Constants.MAX_DEBUG_LENGTH)}');
        formatState.copyEntity(node.contents, astVisitor, '$methodName/node.contents');
        logError('After  node.contents: ${node.contents.runtimeType} ${StringTools.toDisplayString(node.contents, Constants.MAX_DEBUG_LENGTH)}');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
