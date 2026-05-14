import 'package:analyzer/dart/ast/ast.dart';

import 'TypedFormatter.dart';

class InterpolationStringFormatter extends TypedFormatter<InterpolationString>
{
    InterpolationStringFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(InterpolationString node)
    {
        //if (Constants.DEBUG_I_FORMATTER) log('Before node.contents: ${node.contents.runtimeType} ${StringTools.toDisplayString(node.contents, Constants.MAX_DEBUG_LENGTH)}');
        //formatState.copyEntity(node.contents, astVisitor, '$methodName/node.contents');
        formatState.copyString(node.contents.offset, node.contents.end, '$methodName/node.contents');
        //if (Constants.DEBUG_I_FORMATTER) log('After  node.contents: ${node.contents.runtimeType} ${StringTools.toDisplayString(node.contents, Constants.MAX_DEBUG_LENGTH)}');
    }
}
