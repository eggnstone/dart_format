import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class DefaultFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    DefaultFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'DefaultFormatter.format';
        log('START $methodName(${node.runtimeType}: ${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        /*
        if (node is AnnotatedNode)
        {
        _log2('  AnnotatedNode: sortedCommentAndAnnotations');
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        }
        else if (node is NormalFormalParameter)
        {
        _log2('  NormalFormalParameter: sortedCommentAndAnnotations');
        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        }
        else
        _log2('  No sortedCommentAndAnnotations');
        */

        node.childEntities.forEach((SyntacticEntity child)
            {
                if (child is AstNode)
                {
                    _log2('! AstNode-Child: ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
                    /*if (child is Comment)
                    {
                    _log2('    Ignoring "Comment"');
                    }
                    else */
                    if (child is CommentReference)
                    {
                        _log2('    Ignoring "CommentReference"');
                    }
                    /*else if (child.runtimeType.toString() == 'CommentReferenceImpl')
                    {
                    _log2('    Ignoring "CommentReferenceImpl"');
                    }*/
                    else
                    {
                        _log2('    Accepting');
                        child.accept(astVisitor);
                    }
                }
                else if (child is Token)
                {
                    _log2('! Token-Child:   ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
                    if (child.runtimeType.toString() == 'DartDocToken')
                    {
                        _log2('    Ignoring "DartDocToken"');
                    }
                    else
                    {
                        _log2('    Copying');
                        formatState.copyEntity(child, astVisitor, '$methodName/child=${child.runtimeType}');
                    }
                }
                else
                    throw Exception('Unhandled type: ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
            }
        );

        log('END   $methodName(${node.runtimeType}: ${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }

    void _log2(String s)
    {
        if (Constants.DEBUG_FORMATTER_DEFAULT)
            logInternal(s);
    }
}
