import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Tools/LogTools.dart';

abstract class IFormatter
{
    void format(AstNode node);

    void log(String s, int indent, [int? offset])
    {
        if (Constants.DEBUG_I_FORMATTER_OFFSETS && offset == null)
            logInternal('${offset} ${'  ' * indent}$s');
        else
            logInternal('  ' * indent + s);
    }

    void logInfo(String s)
    {
        if (Constants.DEBUG_I_FORMATTER)
            logInternalInfo(s);
    }
}
