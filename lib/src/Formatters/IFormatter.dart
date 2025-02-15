import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Tools/LogTools.dart';

abstract class IFormatter
{
    void format(AstNode node);

    void log(String s, int indent, {int? offset, DateTime? startDateTime})
    {
        final String indentText = '  ' * indent;
        String prefix = '';

        if (Constants.DEBUG_I_FORMATTER_OFFSETS && offset != null)
            prefix += '$offset ';

        if (Constants.DEBUG_I_FORMATTER_TIME && startDateTime != null)
            prefix += '${DateTime.now().difference(startDateTime).inMilliseconds}ms ';

        final String finalS = indentText + prefix + s;
        logInternal(finalS);
        //logInternalInfo(finalS);
    }

    void logInfo(String s)
    {
        if (Constants.DEBUG_I_FORMATTER)
            logInternalInfo(s);
    }
}
