import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

import 'Constants/Constants.dart';
import 'Exceptions/DartFormatException.dart';
import 'Tools/StringTools.dart';

class Analyzer
{
    void analyze(String s)
    {
        final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: s, throwIfDiagnostics: false);

        _analyzeSyntacticEntities(parseResult.unit.childEntities, 0);
    }

    void _analyzeSyntacticEntities(Iterable<SyntacticEntity> items, int logIndent)
    {
        for (final SyntacticEntity item in items)
        {
            if (item is AstNode)
            {
                _log('${_getSpacer(logIndent)}AstNode: ${item.runtimeType} ${StringTools.toDisplayString(item)}');
                if (item is Comment)
                {
                    _log('!!${_getSpacer(logIndent - 1)}  Ignoring "Comment" in favour of precedingComments');
                }
                else
                {
                    _analyzeSyntacticEntities(item.childEntities, logIndent + 1);
                }
            }
            else if (item is Token)
            {
                _log('${_getSpacer(logIndent)}Token:   ${item.runtimeType} ${StringTools.toDisplayString(item)}');
                Token? ct = item.precedingComments;
                while (ct != null)
                {
                    _log('!!${_getSpacer(logIndent - 1)}  precedingComment: ${StringTools.toDisplayString(ct)}');
                    ct = ct.next;
                }
            }
            else
            {
                throw DartFormatException.error('Unhandled type: ${item.runtimeType} ${StringTools.toDisplayString(item)}', null);
            }
        }
    }

    String _getSpacer(int logIndent)
    => '  ' * logIndent;

    void _log(String s)
    {
        if (Constants.DEBUG_ANALYZER)
            logDebug(s);
    }
}
