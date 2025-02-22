import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../../dart_format.dart';

extension ConfigExtension on Config
{
    int? get space0 => fixSpaces ? 0 : null;
    int? get space1 => fixSpaces ? 1 : null;

    int? getSpacesEmptyStatementZeroOne(SyntacticEntity? child)
    {
        if (!fixSpaces || child == null)
            return null;

        return child is EmptyStatement ? 0 : 1;
    }

    int? getSpacesEmptyFunctionBodyZeroOne(SyntacticEntity? child)
    {
        if (!fixSpaces || child == null)
            return null;

        return child is EmptyFunctionBody ? 0 : 1;
    }

    int? getSpacesNullOne(AstNode node, SyntacticEntity? child)
    {
        if (!fixSpaces || child == null)
            return null;

        return node.offset == child.offset ? null : 1;
    }

    int? getSpacesZeroOne(AstNode node, SyntacticEntity? child)
    {
        if (!fixSpaces || child == null)
            return null;

        return node.offset == child.offset ? 0 : 1;
    }
}
