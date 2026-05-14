/*
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';

import '../Exceptions/DartFormatException.dart';
import '../Tools/FormatTools.dart';
import '../Data/Config.dart';
import '../FormatState.dart';
import 'TypedFormatter.dart';

class ForEachPartsWithDeclarationFormatter extends TypedFormatter<ForEachPartsWithDeclaration>
{
    ForEachPartsWithDeclarationFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(ForEachPartsWithDeclaration node)
    {
        formatState.copyEntity(node.loopVariable, astVisitor, '$methodName/node.loopVariable');
        formatState.copyEntity(node.inKeyword, astVisitor, '$methodName/node.inKeyword');
        formatState.copyEntity(node.iterable, astVisitor, '$methodName/node.iterable');
    }
}
*/
