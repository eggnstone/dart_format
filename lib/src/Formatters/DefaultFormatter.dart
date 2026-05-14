// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Constants/Constants.dart';
import '../Tools/LogTools.dart';
import '../Tools/StringTools.dart';
import 'TypedFormatter.dart';

class DefaultFormatter extends TypedFormatter<AstNode>
{
    DefaultFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(AstNode node)
    {
        for (final SyntacticEntity child in node.childEntities)
        {
            if (child is AstNode)
            {
                if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('! AstNode-Child: ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
                if (child is CommentReference)
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('    Ignoring "CommentReference"');
                }
                else
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('    Accepting');
                    child.accept(astVisitor);
                }
            }
            else if (child is Token)
            {
                if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('! Token-Child:   ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
                if (child.runtimeType.toString() == 'DartDocToken')
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('    Ignoring "DartDocToken"');
                }
                else
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('    Copying');
                    formatState.copyEntity(child, astVisitor, '$methodName/child=${child.runtimeType}');
                }
            }
            else
                throw Exception('Unhandled type: ${child.runtimeType} ${StringTools.toDisplayString(child, 50)}');
        }
    }
}
