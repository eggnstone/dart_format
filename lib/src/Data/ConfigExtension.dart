import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import '../../dart_format.dart';

extension ConfigExtension on Config
{
    int? get space0 => fixSpaces ? 0 : null;
    int? get space1 => fixSpaces ? 1 : null;

    /// Returns 0 if [child] is an [EmptyFunctionBody], 1 otherwise. Null when [fixSpaces] is false.
    int? getSpacesEmptyFunctionBodyZeroOne(SyntacticEntity child)
    => fixSpaces ? (child is EmptyFunctionBody ? 0 : 1) : null;

    /// Returns 0 if [child] is an [EmptyStatement], 1 otherwise. Null when [fixSpaces] is false.
    int? getSpacesEmptyStatementZeroOne(SyntacticEntity child)
    => fixSpaces ? (child is EmptyStatement ? 0 : 1) : null;

    /// Returns 0 if [child] sits at the start of its parent [node], 1 otherwise. Null when [fixSpaces] is false.
    int? getSpacesZeroOne(AstNode node, SyntacticEntity child)
    => fixSpaces ? (node.offset == child.offset ? 0 : 1) : null;
}
