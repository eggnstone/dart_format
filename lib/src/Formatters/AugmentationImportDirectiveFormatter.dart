import 'package:analyzer/dart/ast/ast.dart';

import '../Config.dart';
import '../Constants/Constants.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'IFormatter.dart';

class AugmentationImportDirectiveFormatter extends IFormatter
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;

    AugmentationImportDirectiveFormatter(this.config, this.astVisitor, this.formatState);

    @override
    void format(AstNode node)
    {
        const String methodName = 'AugmentationImportDirectiveFormatter.format';
        log('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        if (node is! AugmentationImportDirective)
            throw FormatException('Not an AugmentationImportDirective: ${node.runtimeType}');

        formatState.copyEntity(node.importKeyword, astVisitor, '$methodName/importKeyword');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/augmentKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/uri');
        formatState.copySemicolon(node.semicolon, config, '$methodName/semicolon');
    }
}
