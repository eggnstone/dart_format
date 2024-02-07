import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class TopLevelVariableDeclarationFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    TopLevelVariableDeclarationFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'TopLevelVariableDeclarationFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! TopLevelVariableDeclaration)
            throw FormatException('Not a TopLevelVariableDeclaration: ${node.runtimeType}');

        formatState.copyEntity(node.variables, astVisitor, '$methodName/node.variables');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
