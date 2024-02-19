import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Tools/LogTools.dart';

abstract class IFormatter
{
    void format(AstNode node);

    void log(String s, int indent)
    {
        if (Constants.DEBUG_I_FORMATTER)
            logInternal('  ' * indent +  s);
    }

    void logInfo(String s)
    {
        if (Constants.DEBUG_I_FORMATTER)
            logInternalInfo(s);
    }
}
