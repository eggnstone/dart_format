import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import 'Config.dart';
import 'Constants/Constants.dart';
import 'Exceptions/DartFormatException.dart';
import 'FormatState.dart';
import 'Formatters/AdjacentStringsFormatter.dart';
import 'Formatters/AnnotationFormatter.dart';
import 'Formatters/ArgumentListFormatter.dart';
import 'Formatters/AsExpressionFormatter.dart';
import 'Formatters/AssertStatementFormatter.dart';
import 'Formatters/AssignmentExpressionFormatter.dart';
import 'Formatters/AwaitExpressionFormatter.dart';
import 'Formatters/BinaryExpressionFormatter.dart';
import 'Formatters/BlockFormatter.dart';
import 'Formatters/BlockFunctionBodyFormatter.dart';
import 'Formatters/BooleanLiteralFormatter.dart';
import 'Formatters/BreakStatementFormatter.dart';
import 'Formatters/CascadeExpressionFormatter.dart';
import 'Formatters/CatchClauseFormatter.dart';
import 'Formatters/CatchClauseParameterFormatter.dart';
import 'Formatters/ClassDeclarationFormatter.dart';
import 'Formatters/CommentFormatter.dart';
import 'Formatters/CompilationUnitFormatter.dart';
import 'Formatters/ConditionalExpressionFormatter.dart';
import 'Formatters/ConstantPatternFormatter.dart';
import 'Formatters/ConstructorDeclarationFormatter.dart';
import 'Formatters/ConstructorFieldInitializerFormatter.dart';
import 'Formatters/ConstructorNameFormatter.dart';
import 'Formatters/ContinueStatementFormatter.dart';
import 'Formatters/DeclaredIdentifierFormatter.dart';
import 'Formatters/DefaultFormalParameterFormatter.dart';
import 'Formatters/DoubleLiteralFormatter.dart';
import 'Formatters/EmptyFunctionBodyFormatter.dart';
import 'Formatters/EmptyStatementFormatter.dart';
import 'Formatters/EnumConstantDeclarationFormatter.dart';
import 'Formatters/EnumDeclarationFormatter.dart';
import 'Formatters/ExportDirectiveFormatter.dart';
import 'Formatters/ExpressionFunctionBodyFormatter.dart';
import 'Formatters/ExpressionStatementFormatter.dart';
import 'Formatters/ExtendsClauseFormatter.dart';
import 'Formatters/ExtensionDeclarationFormatter.dart';
import 'Formatters/FieldDeclarationFormatter.dart';
import 'Formatters/FieldFormalParameterFormatter.dart';
import 'Formatters/ForEachPartsWithDeclarationFormatter.dart';
import 'Formatters/ForPartsWithDeclarationsFormatter.dart';
import 'Formatters/ForPartsWithExpressionFormatter.dart';
import 'Formatters/ForStatementFormatter.dart';
import 'Formatters/FormalParameterListFormatter.dart';
import 'Formatters/FunctionDeclarationFormatter.dart';
import 'Formatters/FunctionExpressionFormatter.dart';
import 'Formatters/FunctionExpressionInvocationFormatter.dart';
import 'Formatters/GenericFunctionTypeFormatter.dart';
import 'Formatters/GenericTypeAliasFormatter.dart';
import 'Formatters/GuardedPatternFormatter.dart';
import 'Formatters/IfElementFormatter.dart';
import 'Formatters/IfStatementFormatter.dart';
import 'Formatters/ImplementsClauseFormatter.dart';
import 'Formatters/ImportDirectiveFormatter.dart';
import 'Formatters/ImportPrefixReferenceFormatter.dart';
import 'Formatters/IndexExpressionFormatter.dart';
import 'Formatters/InstanceCreationExpressionFormatter.dart';
import 'Formatters/IntegerLiteralFormatter.dart';
import 'Formatters/InterpolationExpressionFormatter.dart';
import 'Formatters/InterpolationStringFormatter.dart';
import 'Formatters/IsExpressionFormatter.dart';
import 'Formatters/LabelFormatter.dart';
import 'Formatters/LibraryDirectiveFormatter.dart';
import 'Formatters/LibraryIdentifierFormatter.dart';
import 'Formatters/ListLiteralFormatter.dart';
import 'Formatters/MapLiteralEntryFormatter.dart';
import 'Formatters/MethodDeclarationFormatter.dart';
import 'Formatters/MethodInvocationFormatter.dart';
import 'Formatters/NamedExpressionFormatter.dart';
import 'Formatters/NamedTypeFormatter.dart';
import 'Formatters/NullLiteralFormatter.dart';
import 'Formatters/ParenthesizedExpressionFormatter.dart';
import 'Formatters/PartDirectiveFormatter.dart';
import 'Formatters/PostfixExpressionFormatter.dart';
import 'Formatters/PrefixExpressionFormatter.dart';
import 'Formatters/PrefixedIdentifierFormatter.dart';
import 'Formatters/PropertyAccessFormatter.dart';
import 'Formatters/RecordLiteralFormatter.dart';
import 'Formatters/RethrowExpressionFormatter.dart';
import 'Formatters/ReturnStatementFormatter.dart';
import 'Formatters/SetOrMapLiteralFormatter.dart';
import 'Formatters/SimpleFormalParameterFormatter.dart';
import 'Formatters/SimpleIdentifierFormatter.dart';
import 'Formatters/SimpleStringLiteralFormatter.dart';
import 'Formatters/StringInterpolationFormatter.dart';
import 'Formatters/SuperConstructorInvocationFormatter.dart';
import 'Formatters/SuperExpressionFormatter.dart';
import 'Formatters/SuperFormalParameterFormatter.dart';
import 'Formatters/SwitchPatternCaseFormatter.dart';
import 'Formatters/SwitchStatementFormatter.dart';
import 'Formatters/ThisExpressionFormatter.dart';
import 'Formatters/ThrowExpressionFormatter.dart';
import 'Formatters/TopLevelVariableDeclarationFormatter.dart';
import 'Formatters/TryStatementFormatter.dart';
import 'Formatters/TypeArgumentListFormatter.dart';
import 'Formatters/TypeParameterFormatter.dart';
import 'Formatters/TypeParameterListFormatter.dart';
import 'Formatters/VariableDeclarationFormatter.dart';
import 'Formatters/VariableDeclarationListFormatter.dart';
import 'Formatters/VariableDeclarationStatementFormatter.dart';
import 'Formatters/WhileStatementFormatter.dart';
import 'Formatters/WithClauseFormatter.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';

class FormatVisitor extends AstVisitor<void>
{
    final Config config;

    late final FormatState _formatState;

    late final AdjacentStringsFormatter _adjacentStringsFormatter = AdjacentStringsFormatter(config, this, _formatState);
    late final AnnotationFormatter _annotationFormatter = AnnotationFormatter(config, this, _formatState);
    late final ArgumentListFormatter _argumentListFormatter = ArgumentListFormatter(config, this, _formatState);
    late final AsExpressionFormatter _asExpressionFormatter = AsExpressionFormatter(config, this, _formatState);
    late final AssertStatementFormatter _assertStatementFormatter = AssertStatementFormatter(config, this, _formatState);
    late final AssignmentExpressionFormatter _assignmentExpressionFormatter = AssignmentExpressionFormatter(config, this, _formatState);
    late final AwaitExpressionFormatter _awaitExpressionFormatter = AwaitExpressionFormatter(config, this, _formatState);
    late final BinaryExpressionFormatter _binaryExpressionFormatter = BinaryExpressionFormatter(config, this, _formatState);
    late final BlockFormatter _blockFormatter = BlockFormatter(config, this, _formatState);
    late final BlockFunctionBodyFormatter _blockFunctionBodyFormatter = BlockFunctionBodyFormatter(config, this, _formatState);
    late final BooleanLiteralFormatter _booleanLiteralFormatter = BooleanLiteralFormatter(config, this, _formatState);
    late final BreakStatementFormatter _breakStatementFormatter = BreakStatementFormatter(config, this, _formatState);
    late final CascadeExpressionFormatter _cascadeExpressionFormatter = CascadeExpressionFormatter(config, this, _formatState);
    late final CatchClauseFormatter _catchClauseFormatter = CatchClauseFormatter(config, this, _formatState);
    late final CatchClauseParameterFormatter _catchClauseParameterFormatter = CatchClauseParameterFormatter(config, this, _formatState);
    late final ClassDeclarationFormatter _classDeclarationFormatter = ClassDeclarationFormatter(config, this, _formatState);
    late final CommentFormatter _commentFormatter = CommentFormatter(config, this, _formatState);
    late final CompilationUnitFormatter _compilationUnitFormatter = CompilationUnitFormatter(config, this, _formatState);
    late final ConditionalExpressionFormatter _conditionalExpressionFormatter = ConditionalExpressionFormatter(config, this, _formatState);
    late final ConstantPatternFormatter _constantPatternFormatter = ConstantPatternFormatter(config, this, _formatState);
    late final ConstructorDeclarationFormatter _constructorDeclarationFormatter = ConstructorDeclarationFormatter(config, this, _formatState);
    late final ConstructorFieldInitializerFormatter _constructorFieldInitializerFormatter = ConstructorFieldInitializerFormatter(config, this, _formatState);
    late final ConstructorNameFormatter _constructorNameFormatter = ConstructorNameFormatter(config, this, _formatState);
    late final ContinueStatementFormatter _continueStatementFormatter = ContinueStatementFormatter(config, this, _formatState);
    late final DeclaredIdentifierFormatter _declaredIdentifierFormatter = DeclaredIdentifierFormatter(config, this, _formatState);
    late final DefaultFormalParameterFormatter _defaultFormalParameterFormatter = DefaultFormalParameterFormatter(config, this, _formatState);
    late final DoubleLiteralFormatter _doubleLiteralFormatter = DoubleLiteralFormatter(config, this, _formatState);
    late final EmptyFunctionBodyFormatter _emptyFunctionBodyFormatter = EmptyFunctionBodyFormatter(config, this, _formatState);
    late final EmptyStatementFormatter _emptyStatementFormatter = EmptyStatementFormatter(config, this, _formatState);
    late final EnumConstantDeclarationFormatter _enumConstantDeclarationFormatter = EnumConstantDeclarationFormatter(config, this, _formatState);
    late final EnumDeclarationFormatter _enumDeclarationFormatter = EnumDeclarationFormatter(config, this, _formatState);
    late final ExtendsClauseFormatter _extendsClauseFormatter = ExtendsClauseFormatter(config, this, _formatState);
    late final ExtensionDeclarationFormatter _extensionDeclarationFormatter = ExtensionDeclarationFormatter(config, this, _formatState);
    late final ExportDirectiveFormatter _exportDirectiveFormatter = ExportDirectiveFormatter(config, this, _formatState);
    late final ExpressionFunctionBodyFormatter _expressionFunctionBodyFormatter = ExpressionFunctionBodyFormatter(config, this, _formatState);
    late final ExpressionStatementFormatter _expressionStatementFormatter = ExpressionStatementFormatter(config, this, _formatState);
    late final FieldDeclarationFormatter _fieldDeclarationFormatter = FieldDeclarationFormatter(config, this, _formatState);
    late final FieldFormalParameterFormatter _fieldFormalParameterFormatter = FieldFormalParameterFormatter(config, this, _formatState);
    late final ForEachPartsWithDeclarationFormatter _forEachPartsWithDeclarationFormatter = ForEachPartsWithDeclarationFormatter(config, this, _formatState);
    late final FormalParameterListFormatter _formalParameterListFormatter = FormalParameterListFormatter(config, this, _formatState);
    late final ForPartsWithDeclarationsFormatter _forPartsWithDeclarationsFormatter = ForPartsWithDeclarationsFormatter(config, this, _formatState);
    late final ForPartsWithExpressionFormatter _forPartsWithExpressionFormatter = ForPartsWithExpressionFormatter(config, this, _formatState);
    late final ForStatementFormatter _forStatementFormatter = ForStatementFormatter(config, this, _formatState);
    late final FunctionDeclarationFormatter _functionDeclarationFormatter = FunctionDeclarationFormatter(config, this, _formatState);
    late final FunctionExpressionFormatter _functionExpressionFormatter = FunctionExpressionFormatter(config, this, _formatState);
    late final FunctionExpressionInvocationFormatter _functionExpressionInvocationFormatter = FunctionExpressionInvocationFormatter(config, this, _formatState);
    late final GenericFunctionTypeFormatter _genericFunctionTypeFormatter = GenericFunctionTypeFormatter(config, this, _formatState);
    late final GenericTypeAliasFormatter _genericTypeAliasFormatter = GenericTypeAliasFormatter(config, this, _formatState);
    late final GuardedPatternFormatter _guardedPatternFormatter = GuardedPatternFormatter(config, this, _formatState);
    late final IfElementFormatter _ifElementFormatter = IfElementFormatter(config, this, _formatState);
    late final IfStatementFormatter _ifStatementFormatter = IfStatementFormatter(config, this, _formatState);
    late final ImplementsClauseFormatter _implementsClauseFormatter = ImplementsClauseFormatter(config, this, _formatState);
    late final ImportDirectiveFormatter _importDirectiveFormatter = ImportDirectiveFormatter(config, this, _formatState);
    late final ImportPrefixReferenceFormatter _importPrefixReferenceFormatter = ImportPrefixReferenceFormatter(config, this, _formatState);
    late final IndexExpressionFormatter _indexExpressionFormatter = IndexExpressionFormatter(config, this, _formatState);
    late final InstanceCreationExpressionFormatter _instanceCreationExpressionFormatter = InstanceCreationExpressionFormatter(config, this, _formatState);
    late final IntegerLiteralFormatter _integerLiteralFormatter = IntegerLiteralFormatter(config, this, _formatState);
    late final InterpolationExpressionFormatter _interpolationExpressionFormatter = InterpolationExpressionFormatter(config, this, _formatState);
    late final InterpolationStringFormatter _interpolationStringFormatter = InterpolationStringFormatter(config, this, _formatState);
    late final IsExpressionFormatter _isExpressionFormatter = IsExpressionFormatter(config, this, _formatState);
    late final LabelFormatter _labelFormatter = LabelFormatter(config, this, _formatState);
    late final LibraryDirectiveFormatter _libraryDirectiveFormatter = LibraryDirectiveFormatter(config, this, _formatState);
    late final LibraryIdentifierFormatter _libraryIdentifierFormatter = LibraryIdentifierFormatter(config, this, _formatState);
    late final ListLiteralFormatter _listLiteralFormatter = ListLiteralFormatter(config, this, _formatState);
    late final MapLiteralEntryFormatter _mapLiteralEntryFormatter = MapLiteralEntryFormatter(config, this, _formatState);
    late final MethodDeclarationFormatter _methodDeclarationFormatter = MethodDeclarationFormatter(config, this, _formatState);
    late final MethodInvocationFormatter _methodInvocationFormatter = MethodInvocationFormatter(config, this, _formatState);
    late final NamedExpressionFormatter _namedExpressionFormatter = NamedExpressionFormatter(config, this, _formatState);
    late final NamedTypeFormatter _namedTypeFormatter = NamedTypeFormatter(config, this, _formatState);
    late final NullLiteralFormatter _nullLiteralFormatter = NullLiteralFormatter(config, this, _formatState);
    late final ParenthesizedExpressionFormatter _parenthesizedExpressionFormatter = ParenthesizedExpressionFormatter(config, this, _formatState);
    late final PartDirectiveFormatter _partDirectiveFormatter = PartDirectiveFormatter(config, this, _formatState);
    late final PostfixExpressionFormatter _postfixExpressionFormatter = PostfixExpressionFormatter(config, this, _formatState);
    late final PrefixedIdentifierFormatter _prefixedIdentifierFormatter = PrefixedIdentifierFormatter(config, this, _formatState);
    late final PrefixExpressionFormatter _prefixExpressionFormatter = PrefixExpressionFormatter(config, this, _formatState);
    late final PropertyAccessFormatter _propertyAccessFormatter = PropertyAccessFormatter(config, this, _formatState);
    late final RecordLiteralFormatter _recordLiteralFormatter = RecordLiteralFormatter(config, this, _formatState);
    late final RethrowExpressionFormatter _rethrowExpressionFormatter = RethrowExpressionFormatter(config, this, _formatState);
    late final ReturnStatementFormatter _returnStatementFormatter = ReturnStatementFormatter(config, this, _formatState);
    late final SetOrMapLiteralFormatter _setOrMapLiteralFormatter = SetOrMapLiteralFormatter(config, this, _formatState);
    late final SimpleIdentifierFormatter _simpleIdentifierFormatter = SimpleIdentifierFormatter(config, this, _formatState);
    late final SimpleFormalParameterFormatter _simpleFormalParameterFormatter = SimpleFormalParameterFormatter(config, this, _formatState);
    late final SimpleStringLiteralFormatter _simpleStringLiteralFormatter = SimpleStringLiteralFormatter(config, this, _formatState);
    late final StringInterpolationFormatter _stringInterpolationFormatter = StringInterpolationFormatter(config, this, _formatState);
    late final SuperConstructorInvocationFormatter _superConstructorInvocationFormatter = SuperConstructorInvocationFormatter(config, this, _formatState);
    late final SuperExpressionFormatter _superExpressionFormatter = SuperExpressionFormatter(config, this, _formatState);
    late final SuperFormalParameterFormatter _superFormalParameterFormatter = SuperFormalParameterFormatter(config, this, _formatState);
    late final SwitchStatementFormatter _switchStatementFormatter = SwitchStatementFormatter(config, this, _formatState);
    late final SwitchPatternCaseFormatter _switchPatternCaseFormatter = SwitchPatternCaseFormatter(config, this, _formatState);
    late final ThisExpressionFormatter _thisExpressionFormatter = ThisExpressionFormatter(config, this, _formatState);
    late final ThrowExpressionFormatter _throwExpressionFormatter = ThrowExpressionFormatter(config, this, _formatState);
    late final TopLevelVariableDeclarationFormatter _topLevelVariableDeclarationFormatter = TopLevelVariableDeclarationFormatter(config, this, _formatState);
    late final TryStatementFormatter _tryStatementFormatter = TryStatementFormatter(config, this, _formatState);
    late final TypeArgumentListFormatter _typeArgumentListFormatter = TypeArgumentListFormatter(config, this, _formatState);
    late final TypeParameterFormatter _typeParameterFormatter = TypeParameterFormatter(config, this, _formatState);
    late final TypeParameterListFormatter _typeParameterListFormatter = TypeParameterListFormatter(config, this, _formatState);
    late final VariableDeclarationFormatter _variableDeclarationFormatter = VariableDeclarationFormatter(config, this, _formatState);
    late final VariableDeclarationListFormatter _variableDeclarationListFormatter = VariableDeclarationListFormatter(config, this, _formatState);
    late final VariableDeclarationStatementFormatter _variableDeclarationStatementFormatter = VariableDeclarationStatementFormatter(config, this, _formatState);
    late final WhileStatementFormatter _whileStatementFormatter = WhileStatementFormatter(config, this, _formatState);
    late final WithClauseFormatter _withClauseFormatter = WithClauseFormatter(config, this, _formatState);

    FormatVisitor({required this.config, required FormatState formatState})
        : _formatState = formatState;

    @override
    void visitAnnotation(Annotation node)
    => _annotationFormatter.format(node);

    @override
    void visitAssignmentExpression(AssignmentExpression node)
    => _assignmentExpressionFormatter.format(node);

    @override
    void visitAwaitExpression(AwaitExpression node)
    => _awaitExpressionFormatter.format(node);

    @override
    void visitBlock(Block node)
    => _blockFormatter.format(node);

    @override
    void visitBlockFunctionBody(BlockFunctionBody node)
    => _blockFunctionBodyFormatter.format(node);

    @override
    void visitBreakStatement(BreakStatement node)
    => _breakStatementFormatter.format(node);

    @override
    void visitCatchClause(CatchClause node)
    => _catchClauseFormatter.format(node);

    @override
    void visitClassDeclaration(ClassDeclaration node)
    => _classDeclarationFormatter.format(node);

    @override
    void visitComment(Comment node)
    => _commentFormatter.format(node);

    @override
    void visitCompilationUnit(CompilationUnit node)
    => _compilationUnitFormatter.format(node);

    @override
    void visitConstructorDeclaration(ConstructorDeclaration node)
    => _constructorDeclarationFormatter.format(node);

    @override
    void visitConstructorFieldInitializer(ConstructorFieldInitializer node)
    => _constructorFieldInitializerFormatter.format(node);

    @override
    void visitEmptyFunctionBody(EmptyFunctionBody node)
    => _emptyFunctionBodyFormatter.format(node);

    @override
    void visitEmptyStatement(EmptyStatement node)
    => _emptyStatementFormatter.format(node);

    @override
    void visitEnumConstantDeclaration(EnumConstantDeclaration node)
    => _enumConstantDeclarationFormatter.format(node);

    @override
    void visitEnumDeclaration(EnumDeclaration node)
    => _enumDeclarationFormatter.format(node);

    @override
    void visitExportDirective(ExportDirective node)
    => _exportDirectiveFormatter.format(node);

    @override
    void visitExpressionFunctionBody(ExpressionFunctionBody node)
    => _expressionFunctionBodyFormatter.format(node);

    @override
    void visitExpressionStatement(ExpressionStatement node)
    => _expressionStatementFormatter.format(node);

    @override
    void visitExtensionDeclaration(ExtensionDeclaration node)
    => _extensionDeclarationFormatter.format(node);

    @override
    void visitFieldDeclaration(FieldDeclaration node)
    => _fieldDeclarationFormatter.format(node);

    @override
    void visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node)
    => _forEachPartsWithDeclarationFormatter.format(node);

    @override
    void visitForPartsWithDeclarations(ForPartsWithDeclarations node)
    => _forPartsWithDeclarationsFormatter.format(node);

    @override
    void visitForPartsWithExpression(ForPartsWithExpression node)
    => _forPartsWithExpressionFormatter.format(node);

    @override
    void visitForStatement(ForStatement node)
    => _forStatementFormatter.format(node);

    @override
    void visitFunctionDeclaration(FunctionDeclaration node)
    => _functionDeclarationFormatter.format(node);

    @override
    void visitFunctionExpression(FunctionExpression node)
    => _functionExpressionFormatter.format(node);

    @override
    void visitGenericTypeAlias(GenericTypeAlias node)
    => _genericTypeAliasFormatter.format(node);

    @override
    void visitIfStatement(IfStatement node)
    => _ifStatementFormatter.format(node);

    @override
    void visitImportDirective(ImportDirective node)
    => _importDirectiveFormatter.format(node);

    @override
    void visitLibraryDirective(LibraryDirective node)
    => _libraryDirectiveFormatter.format(node);

    @override
    void visitMethodDeclaration(MethodDeclaration node)
    => _methodDeclarationFormatter.format(node);

    @override
    void visitMethodInvocation(MethodInvocation node)
    => _methodInvocationFormatter.format(node);

    @override
    void visitRethrowExpression(RethrowExpression node)
    => _rethrowExpressionFormatter.format(node);

    @override
    void visitReturnStatement(ReturnStatement node)
    => _returnStatementFormatter.format(node);

    @override
    void visitPartDirective(PartDirective node)
    => _partDirectiveFormatter.format(node);

    @override
    void visitPostfixExpression(PostfixExpression node)
    => _postfixExpressionFormatter.format(node);

    @override
    void visitSimpleIdentifier(SimpleIdentifier node)
    => _simpleIdentifierFormatter.format(node);

    @override
    void visitSwitchCase(SwitchCase node)
    => _visitUnimplemented(node);

    @override
    void visitSwitchDefault(SwitchDefault node)
    => _visitUnimplemented(node);

    @override
    void visitSwitchExpression(SwitchExpression node)
    => _visitUnimplemented(node);

    @override
    void visitSwitchExpressionCase(SwitchExpressionCase node)
    => _visitUnimplemented(node);

    @override
    void visitSwitchPatternCase(SwitchPatternCase node)
    => _switchPatternCaseFormatter.format(node);

    @override
    void visitSwitchStatement(SwitchStatement node)
    => _switchStatementFormatter.format(node);

    @override
    void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node)
    => _topLevelVariableDeclarationFormatter.format(node);

    @override
    void visitTryStatement(TryStatement node)
    => _tryStatementFormatter.format(node);

    @override
    void visitThrowExpression(ThrowExpression node)
    => _throwExpressionFormatter.format(node);

    @override
    void visitVariableDeclarationStatement(VariableDeclarationStatement node)
    => _variableDeclarationStatementFormatter.format(node);

    @override
    void visitWhileStatement(WhileStatement node)
    => _whileStatementFormatter.format(node);

    /*TODO: sort alphabetically*/

    @override
    void visitAdjacentStrings(AdjacentStrings node)
    => _adjacentStringsFormatter.format(node);

    @override
    void visitArgumentList(ArgumentList node)
    => _argumentListFormatter.format(node);

    @override
    void visitAsExpression(AsExpression node)
    => _asExpressionFormatter.format(node);

    @override
    void visitAssertInitializer(AssertInitializer node)
    => _visitUnimplemented(node);

    @override
    void visitAssertStatement(AssertStatement assertStatement)
    => _assertStatementFormatter.format(assertStatement);

    @override
    void visitAssignedVariablePattern(AssignedVariablePattern node)
    => _visitUnimplemented(node);

    @override
    void visitAugmentationImportDirective(AugmentationImportDirective node)
    => _visitUnimplemented(node);

    @override
    void visitBinaryExpression(BinaryExpression node)
    => _binaryExpressionFormatter.format(node);

    @override
    void visitBooleanLiteral(BooleanLiteral node)
    => _booleanLiteralFormatter.format(node);

    @override
    void visitCascadeExpression(CascadeExpression node)
    => _cascadeExpressionFormatter.format(node);

    @override
    void visitCaseClause(CaseClause node)
    => _visitUnimplemented(node);

    @override
    void visitCastPattern(CastPattern node)
    => _visitUnimplemented(node);

    @override
    void visitCatchClauseParameter(CatchClauseParameter node)
    => _catchClauseParameterFormatter.format(node);

    @override
    void visitClassTypeAlias(ClassTypeAlias node)
    => _visitUnimplemented(node);

    @override
    void visitCommentReference(CommentReference node)
    => _visitUnimplemented(node);

    @override
    void visitConditionalExpression(ConditionalExpression node)
    => _conditionalExpressionFormatter.format(node);

    @override
    void visitConfiguration(Configuration node)
    => _visitUnimplemented(node);

    @override
    void visitConstantPattern(ConstantPattern node)
    => _constantPatternFormatter.format(node);

    @override
    void visitConstructorName(ConstructorName node)
    => _constructorNameFormatter.format(node);

    @override
    void visitConstructorReference(ConstructorReference node)
    => _visitUnimplemented(node);

    @override
    void visitConstructorSelector(ConstructorSelector node)
    => _visitUnimplemented(node);

    @override
    void visitContinueStatement(ContinueStatement node)
    => _continueStatementFormatter.format(node);

    @override
    void visitDeclaredIdentifier(DeclaredIdentifier node)
    => _declaredIdentifierFormatter.format(node);

    @override
    void visitDeclaredVariablePattern(DeclaredVariablePattern node)
    => _visitUnimplemented(node);

    @override
    void visitDefaultFormalParameter(DefaultFormalParameter node)
    => _defaultFormalParameterFormatter.format(node);

    @override
    void visitDoStatement(DoStatement node)
    => _visitUnimplemented(node);

    @override
    void visitDottedName(DottedName node)
    => _visitUnimplemented(node);

    @override
    void visitDoubleLiteral(DoubleLiteral node)
    => _doubleLiteralFormatter.format(node);

    @override
    void visitEnumConstantArguments(EnumConstantArguments node)
    => _visitUnimplemented(node);

    @override
    void visitExtendsClause(ExtendsClause node)
    => _extendsClauseFormatter.format(node);

    @override
    void visitExtensionOverride(ExtensionOverride node)
    => _visitUnimplemented(node);

    @override
    void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node)
    => _visitUnimplemented(node);

    @override
    void visitFieldFormalParameter(FieldFormalParameter node)
    => _fieldFormalParameterFormatter.format(node);

    @override
    void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node)
    => _visitUnimplemented(node);

    @override
    void visitForEachPartsWithPattern(ForEachPartsWithPattern node)
    => _visitUnimplemented(node);

    @override
    void visitForElement(ForElement node)
    => _visitUnimplemented(node);

    @override
    void visitForPartsWithPattern(ForPartsWithPattern node)
    => _visitUnimplemented(node);

    @override
    void visitFormalParameterList(FormalParameterList node)
    => _formalParameterListFormatter.format(node);

    @override
    void visitFunctionDeclarationStatement(FunctionDeclarationStatement node)
    => _visitUnimplemented(node);

    @override
    void visitFunctionExpressionInvocation(FunctionExpressionInvocation node)
    => _functionExpressionInvocationFormatter.format(node);

    @override
    void visitFunctionReference(FunctionReference node)
    => _visitUnimplemented(node);

    @override
    void visitFunctionTypeAlias(FunctionTypeAlias functionTypeAlias)
    => _visitUnimplemented(functionTypeAlias);

    @override
    void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node)
    => _visitUnimplemented(node);

    @override
    void visitGenericFunctionType(GenericFunctionType node)
    => _genericFunctionTypeFormatter.format(node);

    @override
    void visitGuardedPattern(GuardedPattern node)
    => _guardedPatternFormatter.format(node);

    @override
    void visitHideCombinator(HideCombinator node)
    => _visitUnimplemented(node);

    @override
    void visitIfElement(IfElement node)
    => _ifElementFormatter.format(node);

    @override
    void visitImplementsClause(ImplementsClause node)
    => _implementsClauseFormatter.format(node);

    @override
    void visitImplicitCallReference(ImplicitCallReference node)
    => _visitUnimplemented(node);

    @override
    void visitImportPrefixReference(ImportPrefixReference node)
    => _importPrefixReferenceFormatter.format(node);

    @override
    void visitIndexExpression(IndexExpression node)
    => _indexExpressionFormatter.format(node);

    @override
    void visitInstanceCreationExpression(InstanceCreationExpression node)
    => _instanceCreationExpressionFormatter.format(node);

    @override
    void visitIntegerLiteral(IntegerLiteral node)
    => _integerLiteralFormatter.format(node);

    @override
    void visitInterpolationExpression(InterpolationExpression node)
    => _interpolationExpressionFormatter.format(node);

    @override
    void visitInterpolationString(InterpolationString node)
    => _interpolationStringFormatter.format(node);

    @override
    void visitIsExpression(IsExpression node)
    => _isExpressionFormatter.format(node);

    @override
    void visitLabel(Label node)
    => _labelFormatter.format(node);

    @override
    void visitLabeledStatement(LabeledStatement node)
    => _visitUnimplemented(node);

    @override
    void visitLibraryAugmentationDirective(LibraryAugmentationDirective node)
    => _visitUnimplemented(node);

    @override
    void visitLibraryIdentifier(LibraryIdentifier node)
    => _libraryIdentifierFormatter.format(node);

    @override
    void visitListLiteral(ListLiteral node)
    => _listLiteralFormatter.format(node);

    @override
    void visitListPattern(ListPattern node)
    => _visitUnimplemented(node);

    @override
    void visitLogicalAndPattern(LogicalAndPattern node)
    => _visitUnimplemented(node);

    @override
    void visitLogicalOrPattern(LogicalOrPattern node)
    => _visitUnimplemented(node);

    @override
    void visitMapLiteralEntry(MapLiteralEntry node)
    => _mapLiteralEntryFormatter.format(node);

    @override
    void visitMapPattern(MapPattern node)
    => _visitUnimplemented(node);

    @override
    void visitMapPatternEntry(MapPatternEntry node)
    => _visitUnimplemented(node);

    @override
    void visitMixinDeclaration(MixinDeclaration node)
    => _visitUnimplemented(node);

    @override
    void visitNamedExpression(NamedExpression node)
    => _namedExpressionFormatter.format(node);

    @override
    void visitNamedType(NamedType node)
    => _namedTypeFormatter.format(node);

    @override
    void visitNativeClause(NativeClause node)
    => _visitUnimplemented(node);

    @override
    void visitNativeFunctionBody(NativeFunctionBody node)
    => _visitUnimplemented(node);

    @override
    void visitNullAssertPattern(NullAssertPattern node)
    => _visitUnimplemented(node);

    @override
    void visitNullCheckPattern(NullCheckPattern node)
    => _visitUnimplemented(node);

    @override
    void visitNullLiteral(NullLiteral node)
    => _nullLiteralFormatter.format(node);

    @override
    void visitObjectPattern(ObjectPattern node)
    => _visitUnimplemented(node);

    @override
    void visitOnClause(OnClause node)
    => _visitUnimplemented(node);

    @override
    void visitParenthesizedExpression(ParenthesizedExpression node)
    => _parenthesizedExpressionFormatter.format(node);

    @override
    void visitParenthesizedPattern(ParenthesizedPattern node)
    => _visitUnimplemented(node);

    @override
    void visitPartOfDirective(PartOfDirective node)
    => _visitUnimplemented(node);

    @override
    void visitPatternAssignment(PatternAssignment node)
    => _visitUnimplemented(node);

    @override
    void visitPatternField(PatternField node)
    => _visitUnimplemented(node);

    @override
    void visitPatternFieldName(PatternFieldName node)
    => _visitUnimplemented(node);

    @override
    void visitPatternVariableDeclaration(PatternVariableDeclaration node)
    => _visitUnimplemented(node);

    @override
    void visitPatternVariableDeclarationStatement(PatternVariableDeclarationStatement node)
    => _visitUnimplemented(node);

    @override
    void visitPrefixExpression(PrefixExpression node)
    => _prefixExpressionFormatter.format(node);

    @override
    void visitPrefixedIdentifier(PrefixedIdentifier node)
    => _prefixedIdentifierFormatter.format(node);

    @override
    void visitPropertyAccess(PropertyAccess node)
    => _propertyAccessFormatter.format(node);

    @override
    void visitRecordLiteral(RecordLiteral node)
    => _recordLiteralFormatter.format(node);

    @override
    void visitRecordPattern(RecordPattern node)
    => _visitUnimplemented(node);

    @override
    void visitRecordTypeAnnotation(RecordTypeAnnotation node)
    => _visitUnimplemented(node);

    @override
    void visitRecordTypeAnnotationNamedField(RecordTypeAnnotationNamedField node)
    => _visitUnimplemented(node);

    @override
    void visitRecordTypeAnnotationNamedFields(RecordTypeAnnotationNamedFields node)
    => _visitUnimplemented(node);

    @override
    void visitRecordTypeAnnotationPositionalField(RecordTypeAnnotationPositionalField node)
    => _visitUnimplemented(node);

    @override
    void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node)
    => _visitUnimplemented(node);

    @override
    void visitRelationalPattern(RelationalPattern node)
    => _visitUnimplemented(node);

    @override
    void visitRepresentationConstructorName(RepresentationConstructorName node)
    => _visitUnimplemented(node);

    @override
    void visitRepresentationDeclaration(RepresentationDeclaration node)
    => _visitUnimplemented(node);

    @override
    void visitRestPatternElement(RestPatternElement node)
    => _visitUnimplemented(node);

    @override
    void visitScriptTag(ScriptTag node)
    => _visitUnimplemented(node);

    @override
    void visitSetOrMapLiteral(SetOrMapLiteral node)
    => _setOrMapLiteralFormatter.format(node);

    @override
    void visitShowCombinator(ShowCombinator node)
    => _visitUnimplemented(node);

    @override
    void visitSimpleFormalParameter(SimpleFormalParameter node)
    => _simpleFormalParameterFormatter.format(node);

    @override
    void visitSimpleStringLiteral(SimpleStringLiteral node)
    => _simpleStringLiteralFormatter.format(node);

    @override
    void visitSpreadElement(SpreadElement node)
    => _visitUnimplemented(node);

    @override
    void visitStringInterpolation(StringInterpolation node)
    => _stringInterpolationFormatter.format(node);

    @override
    void visitSuperConstructorInvocation(SuperConstructorInvocation node)
    => _superConstructorInvocationFormatter.format(node);

    @override
    void visitSuperExpression(SuperExpression node)
    => _superExpressionFormatter.format(node);

    @override
    void visitSuperFormalParameter(SuperFormalParameter node)
    => _superFormalParameterFormatter.format(node);

    @override
    void visitSymbolLiteral(SymbolLiteral node)
    => _visitUnimplemented(node);

    @override
    void visitThisExpression(ThisExpression node)
    => _thisExpressionFormatter.format(node);

    @override
    void visitTypeArgumentList(TypeArgumentList node)
    => _typeArgumentListFormatter.format(node);

    @override
    void visitTypeLiteral(TypeLiteral node)
    => _visitUnimplemented(node);

    @override
    void visitTypeParameter(TypeParameter node)
    => _typeParameterFormatter.format(node);

    @override
    void visitTypeParameterList(TypeParameterList node)
    => _typeParameterListFormatter.format(node);

    @override
    void visitVariableDeclaration(VariableDeclaration node)
    => _variableDeclarationFormatter.format(node);

    @override
    void visitVariableDeclarationList(VariableDeclarationList node)
    => _variableDeclarationListFormatter.format(node);

    @override
    void visitWhenClause(WhenClause node)
    => _visitUnimplemented(node);

    @override
    void visitWildcardPattern(WildcardPattern node)
    => _visitUnimplemented(node);

    @override
    void visitWithClause(WithClause node)
    => _withClauseFormatter.format(node);

    @override
    void visitYieldStatement(YieldStatement node)
    => _visitUnimplemented(node);

    void _visitUnimplemented(AstNode node)
    {
        final String methodName = 'visitUnimplemented/${node.runtimeType}';
        if (Constants.DEBUG_FORMAT_VISITOR_UNIMPLEMENTED)
            logInternal('# $methodName(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');

        throw DartFormatException.warning('Unimplemented: $methodName', CharacterLocation(node.offset, node.length));

        /*_formatState.copyEntityOld(node, methodName);*/
    }
}
