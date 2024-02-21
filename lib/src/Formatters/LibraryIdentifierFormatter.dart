import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class LibraryIdentifierFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    LibraryIdentifierFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'LibraryIdentifierFormatter.format';
        log('START $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', formatState.logIndent++);

        if (node is! LibraryIdentifier)
            throw FormatException('Not a LibraryIdentifier: ${node.runtimeType}');

        // Why does this not work with the default formatter?
        // The dots were missing then!
        formatState.acceptListWithPeriod(node.components, astVisitor, '$methodName/node.components');

        log('END   $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})', --formatState.logIndent);
    }
}
