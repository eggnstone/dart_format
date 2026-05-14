import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

abstract class TypedFormatter<T extends AstNode> extends IFormatter
{
    TypedFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void format(AstNode node)
    {
        if (DateTime.now().isAfter(formatState.maxDateTime))
            throw DartFormatException.warning('Maximum time for formatting reached.');

        if (Constants.DEBUG_I_FORMATTER)
            log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++, offset: node.offset, startDateTime: formatState.startDateTime);

        formatNode(node as T);

        if (Constants.DEBUG_I_FORMATTER)
            log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent, offset: node.end);
    }

    void formatNode(T node);
}
