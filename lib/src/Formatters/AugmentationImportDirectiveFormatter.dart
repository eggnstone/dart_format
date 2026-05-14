/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import 'TypedFormatter.dart';

class AugmentationImportDirectiveFormatter extends TypedFormatter<AugmentationImportDirective>
{
    AugmentationImportDirectiveFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(AugmentationImportDirective node)
    {
        formatState.acceptList(node.metadata, astVisitor, '$methodName/node.metadata');
        formatState.copyEntity(node.importKeyword, astVisitor, '$methodName/node.importKeyword');
        formatState.copyEntity(node.augmentKeyword, astVisitor, '$methodName/node.augmentKeyword');
        formatState.copyEntity(node.uri, astVisitor, '$methodName/node.uri');
        formatState.copySemicolon(node.semicolon, config, '$methodName/node.semicolon', config.space0);
    }
}
*/
