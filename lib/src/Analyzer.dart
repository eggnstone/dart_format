import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:eggnstone_dart/eggnstone_dart.dart';

import 'Constants/Constants.dart';
import 'Tools/StringTools.dart';

class Analyzer
{
    static void analyze(String s)
    {
        final ParseStringResult parseResult = AnalyzerUtilities.parseString(content: s, throwIfDiagnostics: false);

        _analyzeSyntacticEntities(parseResult.unit.childEntities, 0);
    }

    static void _analyzeSyntacticEntities(Iterable<SyntacticEntity> items, int logIndent)
    {
        for (final SyntacticEntity item in items)
        {
            if (item is AstNode)
            {
                _log('${_getSpacer(logIndent)}AstNode: ${item.runtimeType} ${StringTools.toDisplayString(item, Constants.MAX_DEBUG_LENGTH)}');
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
                _log('${_getSpacer(logIndent)}Token:   ${item.runtimeType} ${StringTools.toDisplayString(item, Constants.MAX_DEBUG_LENGTH)}');
                /*if (item is Comment)
                {
                _log('!!${_getSpacer(logIndent - 1)}  Ignoring Comment in favour of precedingComments');
                }
                else*/ /*if (item is CommentImpl)
                {
                _log('!!${_getSpacer(logIndent - 1)}  Ignoring CommentImpl in favour of precedingComments');
                }
                else*/ /*if (item is CommentTokenImpl)
                {
                _log('!!${_getSpacer(logIndent - 1)}  Ignoring CommentTokenImpl in favour of precedingComments');
                }
                else*/ /*if (item is DartDocToken)
                //else if (item.runtimeType.toString() == 'DartDocToken')
                {
                _log('!!${_getSpacer(logIndent - 1)}  Ignoring DartDocToken in favour of precedingComments');
                }
                else*/
                {
                    Token? ct = item.precedingComments;
                    while (ct != null)
                    {
                        _log('!!${_getSpacer(logIndent - 1)}  precedingComment: ${StringTools.toDisplayString(ct, Constants.MAX_DEBUG_LENGTH)}');
                        ct = ct.next;
                    }
                }
            }
            else
            {
                throw Exception('Unhandled type: ${item.runtimeType} ${StringTools.toDisplayString(item, Constants.MAX_DEBUG_LENGTH)}');
            }
        }
    }

    static String _getSpacer(int logIndent)
    => '  ' * logIndent;

    static void _log(String s)
    {
        logDebug(s);
    }
}
