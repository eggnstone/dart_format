import 'package:analyzer/dart/ast/ast.dart';

import '../../Config.dart';
import '../../Constants/Constants.dart';
import '../../FormatState.dart';
import '../../Tools/StringTools.dart';
import '../IFormatter.dart';

class EmptyStatementFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    EmptyStatementFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'EmptyStatementFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! EmptyStatement)
            throw FormatException('Not an EmptyStatement: ${node.runtimeType}');

        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
