import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class EnumConstantDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    EnumConstantDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'EnumConstantDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! EnumConstantDeclaration)
            throw FormatException('Not an EnumConstantDeclaration: ${node.runtimeType}');

        formatState.acceptList(node.sortedCommentAndAnnotations, astVisitor, '$methodName/node.sortedCommentAndAnnotations');
        formatState.copyEntity(node.name, astVisitor, '$methodName/node.name'); // covered by tests
    }
}
