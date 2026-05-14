import 'package:analyzer/dart/ast/ast.dart';

import '../Data/ConfigExtension.dart';
import 'TypedFormatter.dart';

class SwitchPatternCaseFormatter extends TypedFormatter<SwitchPatternCase>
{
    SwitchPatternCaseFormatter(super.config, super.astVisitor, super.formatState);

    @override
    void formatNode(SwitchPatternCase node)
    {
        formatState.acceptList(node.labels, astVisitor, '$methodName/node.labels');
        formatState.copyEntity(node.keyword, astVisitor, '$methodName/node.keyword');
        formatState.copyEntity(node.guardedPattern, astVisitor, '$methodName/node.guardedPattern', config.space1);
        formatState.copyEntity(node.colon, astVisitor, '$methodName/node.colon', config.space0);
        formatState.pushLevel('$methodName/node.statements');
        formatState.acceptList(node.statements, astVisitor, '$methodName/node.statements');
        formatState.popLevelAndIndent();
    }
}
