/*
import 'package:analyzer/dart/ast/ast.dart';

import '../Data/Config.dart';
import '../FormatState.dart';
import '../Tools/StringTools.dart';
import 'TypedFormatter.dart';

class AdjacentStringsFormatter extends TypedFormatter<AdjacentStrings>
{
    AdjacentStringsFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(AdjacentStrings node)
    {
        final String textWithPossibleLineBreak = formatState.getText(node.offset, node.end);
        //final bool pushLevel2 = textWithPossibleLineBreak.contains('\n');
        log('textWithPossibleLineBreak: ${StringTools.toDisplayString(textWithPossibleLineBreak)}', 0);
        //final bool pushLevel = false;
        //log('pushLevel: $pushLevel', 0);

        *//*if (pushLevel)
            formatState.pushLevel('$methodName/node.target/after');*//*

        formatState.acceptList(node.strings, astVisitor, '$methodName/node.strings');
        //formatState.acceptListWithComma(node.strings, null, astVisitor, '$methodName/node.strings');

        *//*if (pushLevel)
            formatState.popLevelAndIndent();*//*
    }
}
*/
