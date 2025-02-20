// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';

import '../Constants/Constants.dart';
import '../Data/Config.dart';
import '../Data/ConfigExtension.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class FunctionDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    FunctionDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'FunctionDeclarationFormatter.format';
        if (Constants.DEBUG_I_FORMATTER) log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! FunctionDeclaration)
            throw FormatException('Not a FunctionDeclaration: ${node.runtimeType}');

        /*
        formatState.dump(node, 'node');
        formatState.dumpList(node.sortedCommentAndAnnotations, 'sortedCommentAndAnnotations');
        formatState.dump(node.augmentKeyword, 'augmentKeyword');
        formatState.dump(node.externalKeyword, 'externalKeyword');
        formatState.dump(node.returnType, 'returnType');
        formatState.dump(node.propertyKeyword, 'propertyKeyword');
        formatState.dump(node.name, 'name');
        formatState.dump(node.functionExpression, 'functionExpression');
        */

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.externalKeyword, astVisitor, '$methodName/node.externalKeyword');
        formatState.copyEntity(node.returnType, astVisitor, '$methodName/node.returnType');
        formatState.copyEntity(node.propertyKeyword, astVisitor, '$methodName/node.propertyKeyword');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name', config.space1);

        //logWarning('S functionExpression');
        formatState.copyEntity(node.functionExpression, astVisitor, '$methodName/node.functionExpression');
        //logWarning('E functionExpression');

        if (Constants.DEBUG_I_FORMATTER) log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
