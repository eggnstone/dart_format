import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../Format/FormatState.dart';
import '../Tools/LogTools.dart';

abstract class IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    IFormatter(this.config, this.astVisitor, this.formatState);

    String get methodName => '$runtimeType.format';

    void format(AstNode node);

    /// Copies [child] under [parent], collapsing any leading filler to a single
    /// space (or zero spaces if [child] is at the start of [parent]). Skips when
    /// [child] is null. Use for modifier-keyword sequences where ad-hoc whitespace
    /// between keywords needs to be normalised.
    void copyZeroOne(AstNode parent, SyntacticEntity? child, String source)
    {
        if (child == null)
            return;

        formatState.copyEntity(child, astVisitor, source, config.getSpacesZeroOne(parent, child));
    }

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
    }

    void logInfo(String s)
    {
        if (Constants.DEBUG_I_FORMATTER)
            logInternalInfo(s);
    }
}
