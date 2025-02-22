// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';

import 'Data/Config.dart';
import 'Data/ConfigExtension.dart';
import 'FormatState.dart';
import 'Types/Spacing.dart';

class Copier
{
    final AstVisitor<void> astVisitor;
    final Config config;
    final FormatState formatState;
    final AstNode node;

    Copier(this.astVisitor, this.config, this.formatState, this.node);

    void copyEntity(SyntacticEntity? child, String source, Spacing spacing)
    {
        if (child == null)
            return;

        final int? spaces = switch (spacing)
        {
            Spacing.emptyFunctionBodyZeroOne => config.getSpacesEmptyFunctionBodyZeroOne(child),
            Spacing.emptyStatementZeroOne => config.getSpacesEmptyStatementZeroOne(child),
            //Spacing.nullOne => config.getSpacesNullOne(node, child),
            Spacing.one => config.space1,
            Spacing.zero => config.space0,
            Spacing.zeroOne => config.getSpacesZeroOne(node, child)
        };

        formatState.copyEntity(child, astVisitor, source, spaces);
    }

    void acceptList(List<AstNode> nodes, String source) 
    => formatState.acceptList(nodes, astVisitor, source);
}
