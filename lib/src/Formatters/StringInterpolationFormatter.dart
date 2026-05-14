/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'TypedFormatter.dart';

class StringInterpolationFormatter extends TypedFormatter<StringInterpolation>
{
    StringInterpolationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(StringInterpolation node)
    {
        logError('Before node.elements');
        for (final InterpolationElement element in node.elements)
        {
            logError('Before element: ${element.runtimeType} ${StringTools.toDisplayString(element, Constants.MAX_DEBUG_LENGTH)}');
            formatState.copyEntity(element, astVisitor, '$methodName/node.elements');
            logError('After  element: ${element.runtimeType} ${StringTools.toDisplayString(element, Constants.MAX_DEBUG_LENGTH)}');
        }
        logError('After  node.elements');
    }
}
*/
