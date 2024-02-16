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
        if (Constants.DEBUG_I_FORMATTER)
            logInternal('# $methodName(${node.runtimeType}: ${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (Constants.DEBUG_FORMATTER_DEFAULT)
            node.childEntities.forEach((SyntacticEntity child)
                {
                    if (child is Token)
                        logInternal('  Will copy child: ${child.runtimeType} $child');
                    else if (child is AstNode)
                        logInternal('  Will accept child: ${child.runtimeType} $child');
                    else
                        logInternalError('  Will ignore child: ${child.runtimeType} $child');
                }
            );

        node.childEntities.forEach((SyntacticEntity child)
            {
                if (child is Token)
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT)
                        logInternal('  Copying child: ${child.runtimeType} $child');
                    formatState.copyEntity(child, astVisitor, '$methodName/child');
                    if (Constants.DEBUG_FORMATTER_DEFAULT)
                        logInternal('    ${StringTools.toDisplayString(formatState.getResult(), 50)}');
                }
                else if (child is AstNode)
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT)
                        logInternal('  Accepting child: ${child.runtimeType} $child');
                    child.accept(astVisitor);
                }
                else
                {
                    if (Constants.DEBUG_FORMATTER_DEFAULT)
                        logInternalError('  Ignoring child: ${child.runtimeType} $child');
                }
            }
        );
    }
}
