import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class CastPatternFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    CastPatternFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'CastPatternFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! CastPattern)
            throw FormatException('Not a CastPattern: ${node.runtimeType}');

        formatState.copyEntity(node.pattern, astVisitor, '$methodName/pattern');
        formatState.copyEntity(node.asToken, astVisitor, '$methodName/asToken');
        formatState.copyEntity(node.type, astVisitor, '$methodName/type');
    }
}
