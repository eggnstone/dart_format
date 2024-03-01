// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../Exceptions/DartFormatException.dart';
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
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${node.runtimeType}: ${StringTools.toDisplayString(node)})', formatState.logIndent++, node.offset);

        node.childEntities.forEach((SyntacticEntity child)
            {
                if (child is AstNode)
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('! AstNode-Child: ${child.runtimeType} ${StringTools.toDisplayString(child)}');
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
                    if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('! Token-Child:   ${child.runtimeType} ${StringTools.toDisplayString(child)}');
                    if (child.runtimeType.toString() == 'DartDocToken')
                    {
                        if (Constants.DEBUG_FORMATTER_DEFAULT) logInternal('    Ignoring "DartDocToken"');
                    }
                    else
                    {
                        if (Constants.DEBUG_FORMATTER_DEFAULT)
                            logInternal('    Copying');

                        String getSource()
                        => '$methodName/child=${child.runtimeType}=${StringTools.toDisplayStringCutStart(child, 10)}';

                        formatState.copyEntity(child, astVisitor, onGetSource: getSource);
                    }
                }
                else
                    throw DartFormatException.error('Unhandled type: ${child.runtimeType} ${StringTools.toDisplayString(child)}');
            }
        );

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${node.runtimeType}: ${StringTools.toDisplayString(node)})', --formatState.logIndent, node.end);
    }
}
