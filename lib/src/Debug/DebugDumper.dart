import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../Constants/Constants.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';

class DebugDumper
{
    final String _content;

    DebugDumper(this._content);

    void dump(SyntacticEntity? entity, String name, String indent, int lastConsumedPosition)
    {
        final String paddedName = '$name:'.padRight(10);
        if (entity == null)
        {
            logDebug('### $indent$paddedName <null>');
            return;
        }

        logError('### $indent$paddedName ${StringTools.toDisplayString(entity)} ${entity.runtimeType}');
        logWarning('### $indent  text:    ${StringTools.toDisplayString(_getText(entity.offset, entity.end))}');
        logWarning('### $indent  offset:  ${entity.offset}');
        logWarning('### $indent  end:     ${entity.end}');

        logWarning('### last => start: ${StringTools.toDisplayString(_getText(lastConsumedPosition, entity.offset))}');
        logWarning('### entity text:   ${StringTools.toDisplayString(_getText(entity.offset, entity.end))}');
    }

    void dump2(SyntacticEntity? entity, SyntacticEntity? previousEntity, String name, String indent, int lastConsumedPosition)
    {
        dump(entity, name, indent, lastConsumedPosition);

        if (entity == null || previousEntity == null)
            return;

        logWarning('### dump2:         ${StringTools.toDisplayString(_getText(previousEntity.end, entity.offset))}');
    }

    void dumpList(List<SyntacticEntity>? list, String name, String indent)
    {
        final String paddedName = '$name:'.padRight(10);
        if (list == null)
        {
            logDebug('### $indent$paddedName <null>');
            return;
        }

        logError('### $indent$paddedName ${StringTools.toDisplayString(list)} ${list.runtimeType}');
    }

    String _getText(int offset, int end)
    {
        try
        {
            return _content.substring(offset, end);
        }
        catch (e)
        {
            if (Constants.DEBUG_FORMAT_STATE)
            {
                logInternal('DebugDumper._getText($offset, $end) $e');
                logInternal('  ${StringTools.toDisplayString(_content)}');
            }

            rethrow;
        }
    }
}
