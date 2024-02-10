import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class ImportDirectiveFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    ImportDirectiveFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'ImportDirectiveFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! ImportDirective)
            throw FormatException('Not an ImportDirective: ${node.runtimeType}');

        formatState.copyEntity(node.importKeyword, astVisitor, '$methodName/node.importKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copyEntity(node.deferredKeyword, astVisitor, '$methodName/node.deferredKeyword');
        formatState.copyEntity(node.asKeyword, astVisitor, '$methodName/node.asKeyword');
        formatState.copyEntity(node.prefix, astVisitor, '$methodName/node.prefix');
        //formatState.copyEntity(node.combinators, astVisitor, '$methodName/node.combinators');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon');
    }
}
