
import 'package:analyzer/dart/ast/ast.dart';

abstract class SimpleVisitor extends AstVisitor<void>
{
    void visit(AstNode node);

    @override
    void visitAdjacentStrings(AdjacentStrings node)
    => visit(node);

    @override
    void visitAnnotation(Annotation node)
    => visit(node);

    @override
    void visitArgumentList(ArgumentList node)
    => visit(node);

    @override
    void visitAsExpression(AsExpression node)
    => visit(node);

    @override
    void visitAssertInitializer(AssertInitializer node)
    => visit(node);

    @override
    void visitAssertStatement(AssertStatement node)
    => visit(node);

    @override
    void visitAssignedVariablePattern(AssignedVariablePattern node)
    => visit(node);

    @override
    void visitAssignmentExpression(AssignmentExpression node)
    => visit(node);

    @override
    void visitAwaitExpression(AwaitExpression node)
    => visit(node);

    @override
    void visitBinaryExpression(BinaryExpression node)
    => visit(node);

    @override
    void visitBlock(Block node)
    => visit(node);

    @override
    void visitBlockFunctionBody(BlockFunctionBody node)
    => visit(node);

    @override
    void visitBooleanLiteral(BooleanLiteral node)
    => visit(node);

    @override
    void visitBreakStatement(BreakStatement node)
    => visit(node);

    @override
    void visitCascadeExpression(CascadeExpression node)
    => visit(node);

    @override
    void visitCaseClause(CaseClause node)
    => visit(node);

    @override
    void visitCastPattern(CastPattern node)
    => visit(node);

    @override
    void visitCatchClause(CatchClause node)
    => visit(node);

    @override
    void visitCatchClauseParameter(CatchClauseParameter node)
    => visit(node);

    @override
    void visitClassDeclaration(ClassDeclaration node)
    => visit(node);

    @override
    void visitClassTypeAlias(ClassTypeAlias node)
    => visit(node);

    @override
    void visitComment(Comment node)
    => visit(node);

    @override
    void visitCommentReference(CommentReference node)
    => visit(node);

    @override
    void visitCompilationUnit(CompilationUnit node)
    => visit(node);

    @override
    void visitConditionalExpression(ConditionalExpression node)
    => visit(node);

    @override
    void visitConfiguration(Configuration node)
    => visit(node);

    @override
    void visitConstantPattern(ConstantPattern node)
    => visit(node);

    @override
    void visitConstructorDeclaration(ConstructorDeclaration node)
    => visit(node);

    @override
    void visitConstructorFieldInitializer(ConstructorFieldInitializer node)
    => visit(node);

    @override
    void visitConstructorName(ConstructorName node)
    => visit(node);

    @override
    void visitConstructorReference(ConstructorReference node)
    => visit(node);

    @override
    void visitConstructorSelector(ConstructorSelector node)
    => visit(node);

    @override
    void visitContinueStatement(ContinueStatement node)
    => visit(node);

    @override
    void visitDeclaredIdentifier(DeclaredIdentifier node)
    => visit(node);

    @override
    void visitDeclaredVariablePattern(DeclaredVariablePattern node)
    => visit(node);

    @override
    void visitDefaultFormalParameter(DefaultFormalParameter node)
    => visit(node);

    @override
    void visitDoStatement(DoStatement node)
    => visit(node);

    @override
    void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node)
    => visit(node);

    @override
    void visitDotShorthandInvocation(DotShorthandInvocation node)
    => visit(node);

    @override
    void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node)
    => visit(node); 

    @override
    void visitDottedName(DottedName node)
    => visit(node);

    @override
    void visitDoubleLiteral(DoubleLiteral node)
    => visit(node);

    @override
    void visitEmptyFunctionBody(EmptyFunctionBody node)
    => visit(node);

    @override
    void visitEmptyStatement(EmptyStatement node)
    => visit(node);

    @override
    void visitEnumConstantArguments(EnumConstantArguments node)
    => visit(node);

    @override
    void visitEnumConstantDeclaration(EnumConstantDeclaration node)
    => visit(node);

    @override
    void visitEnumDeclaration(EnumDeclaration node)
    => visit(node);

    @override
    void visitExportDirective(ExportDirective node)
    => visit(node);

    @override
    void visitExpressionFunctionBody(ExpressionFunctionBody node)
    => visit(node);

    @override
    void visitExpressionStatement(ExpressionStatement node)
    => visit(node);

    @override
    void visitExtendsClause(ExtendsClause node)
    => visit(node);

    @override
    void visitExtensionDeclaration(ExtensionDeclaration node)
    => visit(node);

    @override
    void visitExtensionOverride(ExtensionOverride node)
    => visit(node);

    @override
    void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node)
    => visit(node);

    @override
    void visitFieldDeclaration(FieldDeclaration node)
    => visit(node);

    @override
    void visitFieldFormalParameter(FieldFormalParameter node)
    => visit(node);

    @override
    void visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node)
    => visit(node);

    @override
    void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node)
    => visit(node);

    @override
    void visitForEachPartsWithPattern(ForEachPartsWithPattern node)
    => visit(node);

    @override
    void visitForElement(ForElement node)
    => visit(node);

    @override
    void visitForPartsWithDeclarations(ForPartsWithDeclarations node)
    => visit(node);

    @override
    void visitForPartsWithExpression(ForPartsWithExpression node)
    => visit(node);

    @override
    void visitForPartsWithPattern(ForPartsWithPattern node)
    => visit(node);

    @override
    void visitForStatement(ForStatement node)
    => visit(node);

    @override
    void visitFormalParameterList(FormalParameterList node)
    => visit(node);

    @override
    void visitFunctionDeclaration(FunctionDeclaration node)
    => visit(node);

    @override
    void visitFunctionDeclarationStatement(FunctionDeclarationStatement node)
    => visit(node);

    @override
    void visitFunctionExpression(FunctionExpression node)
    => visit(node);

    @override
    void visitFunctionExpressionInvocation(FunctionExpressionInvocation node)
    => visit(node);

    @override
    void visitFunctionReference(FunctionReference node)
    => visit(node);

    @override
    void visitFunctionTypeAlias(FunctionTypeAlias node)
    => visit(node);

    @override
    void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node)
    => visit(node);

    @override
    void visitGenericFunctionType(GenericFunctionType node)
    => visit(node);

    @override
    void visitGenericTypeAlias(GenericTypeAlias node)
    => visit(node);

    @override
    void visitGuardedPattern(GuardedPattern node)
    => visit(node);

    @override
    void visitHideCombinator(HideCombinator node)
    => visit(node);

    @override
    void visitIfElement(IfElement node)
    => visit(node);

    @override
    void visitIfStatement(IfStatement node)
    => visit(node);

    @override
    void visitImplementsClause(ImplementsClause node)
    => visit(node);

    @override
    void visitImplicitCallReference(ImplicitCallReference node)
    => visit(node);

    @override
    void visitImportDirective(ImportDirective node)
    => visit(node);

    @override
    void visitImportPrefixReference(ImportPrefixReference node)
    => visit(node);

    @override
    void visitIndexExpression(IndexExpression node)
    => visit(node);

    @override
    void visitInstanceCreationExpression(InstanceCreationExpression node)
    => visit(node);

    @override
    void visitIntegerLiteral(IntegerLiteral node)
    => visit(node);

    @override
    void visitInterpolationExpression(InterpolationExpression node)
    => visit(node);

    @override
    void visitInterpolationString(InterpolationString node)
    => visit(node);

    @override
    void visitIsExpression(IsExpression node)
    => visit(node);

    @override
    void visitLabel(Label node)
    => visit(node);

    @override
    void visitLabeledStatement(LabeledStatement node)
    => visit(node);

    @override
    void visitLibraryDirective(LibraryDirective node)
    => visit(node);

    @override
    void visitLibraryIdentifier(LibraryIdentifier node)
    => visit(node);

    @override
    void visitListLiteral(ListLiteral node)
    => visit(node);

    @override
    void visitListPattern(ListPattern node)
    => visit(node);

    @override
    void visitLogicalAndPattern(LogicalAndPattern node)
    => visit(node);

    @override
    void visitLogicalOrPattern(LogicalOrPattern node)
    => visit(node);

    @override
    void visitMapLiteralEntry(MapLiteralEntry node)
    => visit(node);

    @override
    void visitMapPattern(MapPattern node)
    => visit(node);

    @override
    void visitMapPatternEntry(MapPatternEntry node)
    => visit(node);

    @override
    void visitMethodDeclaration(MethodDeclaration node)
    => visit(node);

    @override
    void visitMethodInvocation(MethodInvocation node)
    => visit(node);

    @override
    void visitMixinDeclaration(MixinDeclaration node)
    => visit(node);

    @override
    void visitNamedExpression(NamedExpression node)
    => visit(node);

    @override
    void visitNamedType(NamedType node)
    => visit(node);

    @override
    void visitNativeClause(NativeClause node)
    => visit(node);

    @override
    void visitNativeFunctionBody(NativeFunctionBody node)
    => visit(node);

    @override
    void visitNullAssertPattern(NullAssertPattern node)
    => visit(node);

    @override
    void visitNullCheckPattern(NullCheckPattern node)
    => visit(node);

    @override
    void visitNullLiteral(NullLiteral node)
    => visit(node);

    @override
    void visitObjectPattern(ObjectPattern node)
    => visit(node);

    @override
    void visitParenthesizedExpression(ParenthesizedExpression node)
    => visit(node);

    @override
    void visitParenthesizedPattern(ParenthesizedPattern node)
    => visit(node);

    @override
    void visitPartDirective(PartDirective node)
    => visit(node);

    @override
    void visitPartOfDirective(PartOfDirective node)
    => visit(node);

    @override
    void visitPatternAssignment(PatternAssignment node)
    => visit(node);

    @override
    void visitPatternField(PatternField node)
    => visit(node);

    @override
    void visitPatternFieldName(PatternFieldName node)
    => visit(node);

    @override
    void visitPatternVariableDeclaration(PatternVariableDeclaration node)
    => visit(node);

    @override
    void visitPatternVariableDeclarationStatement(PatternVariableDeclarationStatement node)
    => visit(node);

    @override
    void visitPostfixExpression(PostfixExpression node)
    => visit(node);

    @override
    void visitPrefixExpression(PrefixExpression node)
    => visit(node);

    @override
    void visitPrefixedIdentifier(PrefixedIdentifier node)
    => visit(node);

    @override
    void visitPropertyAccess(PropertyAccess node)
    => visit(node);

    @override
    void visitRecordLiteral(RecordLiteral node)
    => visit(node);

    @override
    void visitRecordPattern(RecordPattern node)
    => visit(node);

    @override
    void visitRecordTypeAnnotation(RecordTypeAnnotation node)
    => visit(node);

    @override
    void visitRecordTypeAnnotationNamedField(RecordTypeAnnotationNamedField node)
    => visit(node);

    @override
    void visitRecordTypeAnnotationNamedFields(RecordTypeAnnotationNamedFields node)
    => visit(node);

    @override
    void visitRecordTypeAnnotationPositionalField(RecordTypeAnnotationPositionalField node)
    => visit(node);

    @override
    void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node)
    => visit(node);

    @override
    void visitRelationalPattern(RelationalPattern node)
    => visit(node);

    @override
    void visitRepresentationConstructorName(RepresentationConstructorName node)
    => visit(node);

    @override
    void visitRepresentationDeclaration(RepresentationDeclaration node)
    => visit(node);

    @override
    void visitRestPatternElement(RestPatternElement node)
    => visit(node);

    @override
    void visitRethrowExpression(RethrowExpression node)
    => visit(node);

    @override
    void visitReturnStatement(ReturnStatement node)
    => visit(node);

    @override
    void visitScriptTag(ScriptTag node)
    => visit(node);

    @override
    void visitSetOrMapLiteral(SetOrMapLiteral node)
    => visit(node);

    @override
    void visitShowCombinator(ShowCombinator node)
    => visit(node);

    @override
    void visitSimpleFormalParameter(SimpleFormalParameter node)
    => visit(node);

    @override
    void visitSimpleIdentifier(SimpleIdentifier node)
    => visit(node);

    @override
    void visitSimpleStringLiteral(SimpleStringLiteral node)
    => visit(node);

    @override
    void visitSpreadElement(SpreadElement node)
    => visit(node);

    @override
    void visitStringInterpolation(StringInterpolation node)
    => visit(node);

    @override
    void visitSuperConstructorInvocation(SuperConstructorInvocation node)
    => visit(node);

    @override
    void visitSuperExpression(SuperExpression node)
    => visit(node);

    @override
    void visitSuperFormalParameter(SuperFormalParameter node)
    => visit(node);

    @override
    void visitSwitchCase(SwitchCase node)
    => visit(node);

    @override
    void visitSwitchDefault(SwitchDefault node)
    => visit(node);

    @override
    void visitSwitchExpression(SwitchExpression node)
    => visit(node);

    @override
    void visitSwitchExpressionCase(SwitchExpressionCase node)
    => visit(node);

    @override
    void visitSwitchPatternCase(SwitchPatternCase node)
    => visit(node);

    @override
    void visitSwitchStatement(SwitchStatement node)
    => visit(node);

    @override
    void visitSymbolLiteral(SymbolLiteral node)
    => visit(node);

    @override
    void visitThisExpression(ThisExpression node)
    => visit(node);

    @override
    void visitThrowExpression(ThrowExpression node)
    => visit(node);

    @override
    void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node)
    => visit(node);

    @override
    void visitTryStatement(TryStatement node)
    => visit(node);

    @override
    void visitTypeArgumentList(TypeArgumentList node)
    => visit(node);

    @override
    void visitTypeLiteral(TypeLiteral node)
    => visit(node);

    @override
    void visitTypeParameter(TypeParameter node)
    => visit(node);

    @override
    void visitTypeParameterList(TypeParameterList node)
    => visit(node);

    @override
    void visitVariableDeclaration(VariableDeclaration node)
    => visit(node);

    @override
    void visitVariableDeclarationList(VariableDeclarationList node)
    => visit(node);

    @override
    void visitVariableDeclarationStatement(VariableDeclarationStatement node)
    => visit(node);

    @override
    void visitWhenClause(WhenClause node)
    => visit(node);

    @override
    void visitWhileStatement(WhileStatement node)
    => visit(node);

    @override
    void visitWildcardPattern(WildcardPattern node)
    => visit(node);

    @override
    void visitWithClause(WithClause node)
    => visit(node);

    @override
    void visitYieldStatement(YieldStatement node)
    => visit(node);

    @override
    void visitExtensionOnClause(ExtensionOnClause node)
    => visit(node);

    @override
    void visitMixinOnClause(MixinOnClause node)
    => visit(node);

    @override
    void visitNullAwareElement(NullAwareElement node)
    => visit(node);

    @override
    void visitBlockClassBody(BlockClassBody node)
    => visit(node);

    @override
    void visitEmptyClassBody(EmptyClassBody node)
    => visit(node);

    @override
    void visitEnumBody(EnumBody node)
    => visit(node);

    @override
    void visitNameWithTypeParameters(NameWithTypeParameters node)
    => visit(node);

    @override
    void visitPrimaryConstructorDeclaration(PrimaryConstructorDeclaration node)
    => visit(node);

    @override
    void visitPrimaryConstructorName(PrimaryConstructorName node)
    => visit(node);
}
