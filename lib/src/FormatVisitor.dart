import 'package:analyzer/dart/ast/ast.dart';

import 'Data/Config.dart';
import 'FormatState.dart';
import 'Formatters/ArgumentListFormatter.dart';
import 'Formatters/AssertInitializerFormatter.dart';
import 'Formatters/AssertStatementFormatter.dart';
import 'Formatters/AugmentationImportDirectiveFormatter.dart';
import 'Formatters/BinaryExpressionFormatter.dart';
import 'Formatters/BlockFormatter.dart';
import 'Formatters/BreakStatementFormatter.dart';
import 'Formatters/ClassDeclarationFormatter.dart';
import 'Formatters/ClassTypeAliasFormatter.dart';
import 'Formatters/CompilationUnitFormatter.dart';
import 'Formatters/ConditionalExpressionFormatter.dart';
import 'Formatters/ConstructorDeclarationFormatter.dart';
import 'Formatters/ContinueStatementFormatter.dart';
import 'Formatters/DefaultFormatter.dart';
import 'Formatters/DoStatementFormatter.dart';
import 'Formatters/DottedNameFormatter.dart';
import 'Formatters/EmptyFunctionBodyFormatter.dart';
import 'Formatters/EmptyStatementFormatter.dart';
import 'Formatters/EnumDeclarationFormatter.dart';
import 'Formatters/ExportDirectiveFormatter.dart';
import 'Formatters/ExpressionFunctionBodyFormatter.dart';
import 'Formatters/ExpressionStatementFormatter.dart';
import 'Formatters/ExtendsClauseFormatter.dart';
import 'Formatters/ExtensionDeclarationFormatter.dart';
import 'Formatters/FieldDeclarationFormatter.dart';
import 'Formatters/ForElementFormatter.dart';
import 'Formatters/ForPartsWithDeclarationsFormatter.dart';
import 'Formatters/ForPartsWithExpressionFormatter.dart';
import 'Formatters/ForStatementFormatter.dart';
import 'Formatters/FormalParameterListFormatter.dart';
import 'Formatters/FunctionDeclarationFormatter.dart';
import 'Formatters/FunctionTypeAliasFormatter.dart';
import 'Formatters/FunctionTypedFormalParameterFormatter.dart';
import 'Formatters/GenericTypeAliasFormatter.dart';
import 'Formatters/HideCombinatorFormatter.dart';
import 'Formatters/IfStatementFormatter.dart';
import 'Formatters/ImplementsClauseFormatter.dart';
import 'Formatters/ImportDirectiveFormatter.dart';
import 'Formatters/IndexExpressionFormatter.dart';
import 'Formatters/InstanceCreationExpressionFormatter.dart';
import 'Formatters/InterpolationExpressionFormatter.dart';
import 'Formatters/InterpolationStringFormatter.dart';
import 'Formatters/LabelFormatter.dart';
import 'Formatters/LibraryAugmentationDirectiveFormatter.dart';
import 'Formatters/LibraryDirectiveFormatter.dart';
import 'Formatters/LibraryIdentifierFormatter.dart';
import 'Formatters/ListLiteralFormatter.dart';
import 'Formatters/ListPatternFormatter.dart';
import 'Formatters/MapPatternFormatter.dart';
import 'Formatters/MethodInvocationFormatter.dart';
import 'Formatters/MixinDeclarationFormatter.dart';
import 'Formatters/MixinOnClauseFormatter.dart';
import 'Formatters/NamedExpressionFormatter.dart';
import 'Formatters/NativeFunctionBodyFormatter.dart';
import 'Formatters/ObjectPatternFormatter.dart';
import 'Formatters/PartDirectiveFormatter.dart';
import 'Formatters/PartOfDirectiveFormatter.dart';
import 'Formatters/PatternVariableDeclarationStatementFormatter.dart';
import 'Formatters/PrefixedIdentifierFormatter.dart';
import 'Formatters/PropertyAccessFormatter.dart';
import 'Formatters/RecordLiteralFormatter.dart';
import 'Formatters/RecordPatternFormatter.dart';
import 'Formatters/RecordTypeAnnotationFormatter.dart';
import 'Formatters/RecordTypeAnnotationNamedFieldsFormatter.dart';
import 'Formatters/ReturnStatementFormatter.dart';
import 'Formatters/SetOrMapLiteralFormatter.dart';
import 'Formatters/ShowCombinatorFormatter.dart';
import 'Formatters/SimpleStringLiteralFormatter.dart';
import 'Formatters/SuperFormalParameterFormatter.dart';
import 'Formatters/SwitchExpressionFormatter.dart';
import 'Formatters/SwitchPatternCaseFormatter.dart';
import 'Formatters/SwitchStatementFormatter.dart';
import 'Formatters/SymbolLiteralFormatter.dart';
import 'Formatters/TopLevelVariableDeclarationFormatter.dart';
import 'Formatters/TypeArgumentListFormatter.dart';
import 'Formatters/TypeParameterListFormatter.dart';
import 'Formatters/VariableDeclarationFormatter.dart';
import 'Formatters/VariableDeclarationListFormatter.dart';
import 'Formatters/VariableDeclarationStatementFormatter.dart';
import 'Formatters/WhileStatementFormatter.dart';
import 'Formatters/WithClauseFormatter.dart';
import 'Formatters/YieldStatementFormatter.dart';

class FormatVisitor extends AstVisitor<void>
{
    final Config config;
    final FormatState _formatState;

    //late final AdjacentStringsFormatter _adjacentStringsFormatter = AdjacentStringsFormatter(config, this, _formatState);
    late final ArgumentListFormatter _argumentListFormatter = ArgumentListFormatter(config, this, _formatState);
    late final AssertInitializerFormatter _assertInitializerFormatter = AssertInitializerFormatter(config, this, _formatState);
    late final AssertStatementFormatter _assertStatementFormatter = AssertStatementFormatter(config, this, _formatState);
    //late final AssignmentExpressionFormatter _assignmentExpressionFormatter = AssignmentExpressionFormatter(config, this, _formatState);
    late final AugmentationImportDirectiveFormatter _augmentationImportDirectiveFormatter = AugmentationImportDirectiveFormatter(config, this, _formatState);
    late final BinaryExpressionFormatter _binaryExpressionFormatter = BinaryExpressionFormatter(config, this, _formatState);
    late final BlockFormatter _blockFormatter = BlockFormatter(config, this, _formatState);
    late final BreakStatementFormatter _breakStatementFormatter = BreakStatementFormatter(config, this, _formatState);
    //late final CascadeExpressionFormatter _cascadeExpressionFormatter = CascadeExpressionFormatter(config, this, _formatState);
    late final ClassDeclarationFormatter _classDeclarationFormatter = ClassDeclarationFormatter(config, this, _formatState);
    late final ClassTypeAliasFormatter _classTypeAliasFormatter = ClassTypeAliasFormatter(config, this, _formatState);
    late final CompilationUnitFormatter _compilationUnitFormatter = CompilationUnitFormatter(config, this, _formatState);
    late final ConditionalExpressionFormatter _conditionalExpressionFormatter = ConditionalExpressionFormatter(config, this, _formatState);
    late final ConstructorDeclarationFormatter _constructorDeclarationFormatter = ConstructorDeclarationFormatter(config, this, _formatState);
    late final ContinueStatementFormatter _continueStatementFormatter = ContinueStatementFormatter(config, this, _formatState);
    late final DoStatementFormatter _doStatementFormatter = DoStatementFormatter(config, this, _formatState);
    late final DottedNameFormatter _dottedNameFormatter = DottedNameFormatter(config, this, _formatState);
    late final EmptyFunctionBodyFormatter _emptyFunctionBodyFormatter = EmptyFunctionBodyFormatter(config, this, _formatState);
    late final EmptyStatementFormatter _emptyStatementFormatter = EmptyStatementFormatter(config, this, _formatState);
    late final EnumDeclarationFormatter _enumDeclarationFormatter = EnumDeclarationFormatter(config, this, _formatState);
    late final ExtendsClauseFormatter _extendsClauseFormatter = ExtendsClauseFormatter(config, this, _formatState);
    late final ExtensionDeclarationFormatter _extensionDeclarationFormatter = ExtensionDeclarationFormatter(config, this, _formatState);
    late final ExportDirectiveFormatter _exportDirectiveFormatter = ExportDirectiveFormatter(config, this, _formatState);
    late final ExpressionFunctionBodyFormatter _expressionFunctionBodyFormatter = ExpressionFunctionBodyFormatter(config, this, _formatState);
    late final ExpressionStatementFormatter _expressionStatementFormatter = ExpressionStatementFormatter(config, this, _formatState);
    late final FieldDeclarationFormatter _fieldDeclarationFormatter = FieldDeclarationFormatter(config, this, _formatState);
    //late final ForEachPartsWithDeclarationFormatter _forEachPartsWithDeclarationFormatter = ForEachPartsWithDeclarationFormatter(config, this, _formatState);
    late final ForElementFormatter _forElementFormatter = ForElementFormatter(config, this, _formatState);
    late final FormalParameterListFormatter _formalParameterListFormatter = FormalParameterListFormatter(config, this, _formatState);
    late final ForPartsWithDeclarationsFormatter _forPartsWithDeclarationsFormatter = ForPartsWithDeclarationsFormatter(config, this, _formatState);
    late final ForPartsWithExpressionFormatter _forPartsWithExpressionFormatter = ForPartsWithExpressionFormatter(config, this, _formatState);
    late final ForStatementFormatter _forStatementFormatter = ForStatementFormatter(config, this, _formatState);
    late final FunctionDeclarationFormatter _functionDeclarationFormatter = FunctionDeclarationFormatter(config, this, _formatState);
    late final FunctionTypeAliasFormatter _functionTypeAliasFormatter = FunctionTypeAliasFormatter(config, this, _formatState);
    late final FunctionTypedFormalParameterFormatter _functionTypedFormalParameterFormatter = FunctionTypedFormalParameterFormatter(config, this, _formatState);
    late final GenericTypeAliasFormatter _genericTypeAliasFormatter = GenericTypeAliasFormatter(config, this, _formatState);
    late final HideCombinatorFormatter _hideCombinatorFormatter = HideCombinatorFormatter(config, this, _formatState);
    late final IfStatementFormatter _ifStatementFormatter = IfStatementFormatter(config, this, _formatState);
    late final ImplementsClauseFormatter _implementsClauseFormatter = ImplementsClauseFormatter(config, this, _formatState);
    late final ImportDirectiveFormatter _importDirectiveFormatter = ImportDirectiveFormatter(config, this, _formatState);
    late final IndexExpressionFormatter _indexExpressionFormatter = IndexExpressionFormatter(config, this, _formatState);
    late final InstanceCreationExpressionFormatter _instanceCreationExpressionFormatter = InstanceCreationExpressionFormatter(config, this, _formatState);
    late final InterpolationExpressionFormatter _interpolationExpressionFormatter = InterpolationExpressionFormatter(config, this, _formatState);
    late final InterpolationStringFormatter _interpolationStringFormatter = InterpolationStringFormatter(config, this, _formatState);
    late final LabelFormatter _labelFormatter = LabelFormatter(config, this, _formatState);
    late final LibraryAugmentationDirectiveFormatter _libraryAugmentationDirectiveFormatter = LibraryAugmentationDirectiveFormatter(config, this, _formatState);
    late final LibraryDirectiveFormatter _libraryDirectiveFormatter = LibraryDirectiveFormatter(config, this, _formatState);
    late final LibraryIdentifierFormatter _libraryIdentifierFormatter = LibraryIdentifierFormatter(config, this, _formatState);
    late final ListLiteralFormatter _listLiteralFormatter = ListLiteralFormatter(config, this, _formatState);
    late final ListPatternFormatter _listPatternFormatter = ListPatternFormatter(config, this, _formatState);
    late final MapPatternFormatter _mapPatternFormatter = MapPatternFormatter(config, this, _formatState);
    late final MethodInvocationFormatter _methodInvocationFormatter = MethodInvocationFormatter(config, this, _formatState);
    late final MixinDeclarationFormatter _mixinDeclarationFormatter = MixinDeclarationFormatter(config, this, _formatState);
    late final MixinOnClauseFormatter _mixinOnClauseFormatter = MixinOnClauseFormatter(config, this, _formatState);
    late final NamedExpressionFormatter _namedExpressionFormatter = NamedExpressionFormatter(config, this, _formatState);
    late final NativeFunctionBodyFormatter _nativeFunctionBodyFormatter = NativeFunctionBodyFormatter(config, this, _formatState);
    late final ObjectPatternFormatter _objectPatternFormatter = ObjectPatternFormatter(config, this, _formatState);
    late final PartDirectiveFormatter _partDirectiveFormatter = PartDirectiveFormatter(config, this, _formatState);
    late final PartOfDirectiveFormatter _partOfDirectiveFormatter = PartOfDirectiveFormatter(config, this, _formatState);
    late final PatternVariableDeclarationStatementFormatter _patternVariableDeclarationStatementFormatter = PatternVariableDeclarationStatementFormatter(config, this, _formatState);
    late final PrefixedIdentifierFormatter _prefixedIdentifierFormatter = PrefixedIdentifierFormatter(config, this, _formatState);
    late final PropertyAccessFormatter _propertyAccessFormatter = PropertyAccessFormatter(config, this, _formatState);
    late final RecordLiteralFormatter _recordLiteralFormatter = RecordLiteralFormatter(config, this, _formatState);
    late final RecordPatternFormatter _recordPatternFormatter = RecordPatternFormatter(config, this, _formatState);
    late final RecordTypeAnnotationFormatter _recordTypeAnnotationFormatter = RecordTypeAnnotationFormatter(config, this, _formatState);
    late final RecordTypeAnnotationNamedFieldsFormatter _recordTypeAnnotationNamedFieldsFormatter = RecordTypeAnnotationNamedFieldsFormatter(config, this, _formatState);
    late final ReturnStatementFormatter _returnStatementFormatter = ReturnStatementFormatter(config, this, _formatState);
    late final SetOrMapLiteralFormatter _setOrMapLiteralFormatter = SetOrMapLiteralFormatter(config, this, _formatState);
    late final ShowCombinatorFormatter _showCombinatorFormatter = ShowCombinatorFormatter(config, this, _formatState);
    late final SimpleStringLiteralFormatter _simpleStringLiteralFormatter = SimpleStringLiteralFormatter(config, this, _formatState);
    //late final StringInterpolationFormatter _stringInterpolationFormatter = StringInterpolationFormatter(config, this, _formatState);
    late final SuperFormalParameterFormatter _superFormalParameterFormatter = SuperFormalParameterFormatter(config, this, _formatState);
    late final SwitchExpressionFormatter _switchExpressionFormatter = SwitchExpressionFormatter(config, this, _formatState);
    late final SwitchStatementFormatter _switchStatementFormatter = SwitchStatementFormatter(config, this, _formatState);
    late final SwitchPatternCaseFormatter _switchPatternCaseFormatter = SwitchPatternCaseFormatter(config, this, _formatState);
    late final SymbolLiteralFormatter _symbolLiteralFormatter = SymbolLiteralFormatter(config, this, _formatState);
    late final TopLevelVariableDeclarationFormatter _topLevelVariableDeclarationFormatter = TopLevelVariableDeclarationFormatter(config, this, _formatState);
    late final TypeArgumentListFormatter _typeArgumentListFormatter = TypeArgumentListFormatter(config, this, _formatState);
    late final TypeParameterListFormatter _typeParameterListFormatter = TypeParameterListFormatter(config, this, _formatState);
    late final VariableDeclarationFormatter _variableDeclarationFormatter = VariableDeclarationFormatter(config, this, _formatState);
    late final VariableDeclarationListFormatter _variableDeclarationListFormatter = VariableDeclarationListFormatter(config, this, _formatState);
    late final VariableDeclarationStatementFormatter _variableDeclarationStatementFormatter = VariableDeclarationStatementFormatter(config, this, _formatState);
    late final WhileStatementFormatter _whileStatementFormatter = WhileStatementFormatter(config, this, _formatState);
    late final WithClauseFormatter _withClauseFormatter = WithClauseFormatter(config, this, _formatState);
    late final YieldStatementFormatter _yieldStatementFormatter = YieldStatementFormatter(config, this, _formatState);

    late final DefaultFormatter _defaultFormatter = DefaultFormatter(config, this, _formatState);

    FormatVisitor({required this.config, required FormatState formatState})
        : _formatState = formatState;

    @override
    void visitAdjacentStrings(AdjacentStrings node)
    => _defaultFormatter.format(node);
    //=> _adjacentStringsFormatter.format(node);

    @override
    void visitAnnotation(Annotation node)
    => _defaultFormatter.format(node);

    @override
    void visitArgumentList(ArgumentList node)
    => _argumentListFormatter.format(node);

    @override
    void visitAssignmentExpression(AssignmentExpression node)
    => _defaultFormatter.format(node);
    //=> _assignmentExpressionFormatter.format(node);

    @override
    void visitAsExpression(AsExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitAssertInitializer(AssertInitializer node)
    => _assertInitializerFormatter.format(node);

    @override
    void visitAssertStatement(AssertStatement assertStatement)
    => _assertStatementFormatter.format(assertStatement);

    @override
    void visitAssignedVariablePattern(AssignedVariablePattern node)
    => _defaultFormatter.format(node);

    @override
    void visitAugmentationImportDirective(AugmentationImportDirective node)
    => _augmentationImportDirectiveFormatter.format(node);

    @override
    void visitAwaitExpression(AwaitExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitBinaryExpression(BinaryExpression node)
    => _binaryExpressionFormatter.format(node);

    @override
    void visitBlock(Block node)
    => _blockFormatter.format(node);

    @override
    void visitBlockFunctionBody(BlockFunctionBody node)
    => _defaultFormatter.format(node);

    @override
    void visitBooleanLiteral(BooleanLiteral node)
    => _defaultFormatter.format(node);

    @override
    void visitBreakStatement(BreakStatement node)
    => _breakStatementFormatter.format(node);

    @override
    void visitCascadeExpression(CascadeExpression node)
    => _defaultFormatter.format(node);
    //=> _cascadeExpressionFormatter.format(node);

    @override
    void visitCaseClause(CaseClause node)
    => _defaultFormatter.format(node);

    @override
    void visitCastPattern(CastPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitCatchClause(CatchClause node)
    => _defaultFormatter.format(node);

    @override
    void visitCatchClauseParameter(CatchClauseParameter node)
    => _defaultFormatter.format(node);

    @override
    void visitClassDeclaration(ClassDeclaration node)
    => _classDeclarationFormatter.format(node);

    @override
    void visitClassTypeAlias(ClassTypeAlias node)
    => _classTypeAliasFormatter.format(node);

    @override
    void visitComment(Comment node)
    => _defaultFormatter.format(node);

    @override
    void visitCommentReference(CommentReference node)
    => _defaultFormatter.format(node);

    @override
    void visitCompilationUnit(CompilationUnit node)
    => _compilationUnitFormatter.format(node);

    @override
    void visitConditionalExpression(ConditionalExpression node)
    => _conditionalExpressionFormatter.format(node);

    @override
    void visitConfiguration(Configuration node)
    => _defaultFormatter.format(node);

    @override
    void visitConstantPattern(ConstantPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitConstructorDeclaration(ConstructorDeclaration node)
    => _constructorDeclarationFormatter.format(node);

    @override
    void visitConstructorFieldInitializer(ConstructorFieldInitializer node)
    => _defaultFormatter.format(node);

    @override
    void visitConstructorName(ConstructorName node)
    => _defaultFormatter.format(node);

    @override
    void visitConstructorReference(ConstructorReference node)
    => _defaultFormatter.format(node);

    @override
    void visitConstructorSelector(ConstructorSelector node)
    => _defaultFormatter.format(node);

    @override
    void visitContinueStatement(ContinueStatement node)
    => _continueStatementFormatter.format(node);

    @override
    void visitDeclaredIdentifier(DeclaredIdentifier node)
    => _defaultFormatter.format(node);

    @override
    void visitDeclaredVariablePattern(DeclaredVariablePattern node)
    => _defaultFormatter.format(node);

    @override
    void visitDefaultFormalParameter(DefaultFormalParameter node)
    => _defaultFormatter.format(node);

    @override
    void visitDoStatement(DoStatement node)
    => _doStatementFormatter.format(node);

    @override
    void visitDottedName(DottedName node)
    => _dottedNameFormatter.format(node);

    @override
    void visitDoubleLiteral(DoubleLiteral node)
    => _defaultFormatter.format(node);

    @override
    void visitEmptyFunctionBody(EmptyFunctionBody node)
    => _emptyFunctionBodyFormatter.format(node);

    @override
    void visitEmptyStatement(EmptyStatement node)
    => _emptyStatementFormatter.format(node);

    @override
    void visitEnumConstantArguments(EnumConstantArguments node)
    => _defaultFormatter.format(node);

    @override
    void visitEnumConstantDeclaration(EnumConstantDeclaration node)
    => _defaultFormatter.format(node);

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
    void visitExtendsClause(ExtendsClause node)
    => _extendsClauseFormatter.format(node);

    @override
    void visitExtensionDeclaration(ExtensionDeclaration node)
    => _extensionDeclarationFormatter.format(node);

    @override
    void visitExtensionOverride(ExtensionOverride node)
    => _defaultFormatter.format(node);

    @override
    void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node)
    => _defaultFormatter.format(node);

    @override
    void visitFieldDeclaration(FieldDeclaration node)
    => _fieldDeclarationFormatter.format(node);

    @override
    void visitFieldFormalParameter(FieldFormalParameter node)
    => _defaultFormatter.format(node);

    @override
    void visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node)
    => _defaultFormatter.format(node);
    //=> _forEachPartsWithDeclarationFormatter.format(node);

    @override
    void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node)
    => _defaultFormatter.format(node);

    @override
    void visitForEachPartsWithPattern(ForEachPartsWithPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitForElement(ForElement node)
    => _forElementFormatter.format(node);

    @override
    void visitFormalParameterList(FormalParameterList node)
    => _formalParameterListFormatter.format(node);

    @override
    void visitForPartsWithDeclarations(ForPartsWithDeclarations node)
    => _forPartsWithDeclarationsFormatter.format(node);

    @override
    void visitForPartsWithExpression(ForPartsWithExpression node)
    => _forPartsWithExpressionFormatter.format(node);

    @override
    void visitForPartsWithPattern(ForPartsWithPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitForStatement(ForStatement node)
    => _forStatementFormatter.format(node);

    @override
    void visitFunctionDeclaration(FunctionDeclaration node)
    => _functionDeclarationFormatter.format(node);

    @override
    void visitFunctionDeclarationStatement(FunctionDeclarationStatement node)
    => _defaultFormatter.format(node);

    @override
    void visitFunctionExpression(FunctionExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitFunctionExpressionInvocation(FunctionExpressionInvocation node)
    => _defaultFormatter.format(node);

    @override
    void visitFunctionReference(FunctionReference node)
    => _defaultFormatter.format(node);

    @override
    void visitFunctionTypeAlias(FunctionTypeAlias functionTypeAlias)
    => _functionTypeAliasFormatter.format(functionTypeAlias);

    @override
    void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node)
    => _functionTypedFormalParameterFormatter.format(node);

    @override
    void visitGenericFunctionType(GenericFunctionType node)
    => _defaultFormatter.format(node);

    @override
    void visitGenericTypeAlias(GenericTypeAlias node)
    => _genericTypeAliasFormatter.format(node);

    @override
    void visitGuardedPattern(GuardedPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitHideCombinator(HideCombinator node)
    => _hideCombinatorFormatter.format(node);

    @override
    void visitIfElement(IfElement node)
    => _defaultFormatter.format(node);

    @override
    void visitIfStatement(IfStatement node)
    => _ifStatementFormatter.format(node);

    @override
    void visitImplementsClause(ImplementsClause node)
    => _implementsClauseFormatter.format(node);

    @override
    void visitImplicitCallReference(ImplicitCallReference node)
    => _defaultFormatter.format(node);

    @override
    void visitImportDirective(ImportDirective node)
    => _importDirectiveFormatter.format(node);

    @override
    void visitImportPrefixReference(ImportPrefixReference node)
    => _defaultFormatter.format(node);

    @override
    void visitIndexExpression(IndexExpression node)
    => _indexExpressionFormatter.format(node);

    @override
    void visitInstanceCreationExpression(InstanceCreationExpression node)
    => _instanceCreationExpressionFormatter.format(node);

    @override
    void visitIntegerLiteral(IntegerLiteral node)
    => _defaultFormatter.format(node);

    @override
    void visitInterpolationExpression(InterpolationExpression node)
    => _interpolationExpressionFormatter.format(node);

    @override
    void visitInterpolationString(InterpolationString node)
    => _interpolationStringFormatter.format(node);

    @override
    void visitIsExpression(IsExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitLabel(Label node)
    => _labelFormatter.format(node);

    @override
    void visitLabeledStatement(LabeledStatement node)
    => _defaultFormatter.format(node);

    @override
    void visitLibraryAugmentationDirective(LibraryAugmentationDirective node)
    => _libraryAugmentationDirectiveFormatter.format(node);

    @override
    void visitLibraryDirective(LibraryDirective node)
    => _libraryDirectiveFormatter.format(node);

    @override
    void visitLibraryIdentifier(LibraryIdentifier node)
    => _libraryIdentifierFormatter.format(node);

    @override
    void visitListLiteral(ListLiteral node)
    => _listLiteralFormatter.format(node);

    @override
    void visitListPattern(ListPattern node)
    => _listPatternFormatter.format(node);

    @override
    void visitLogicalAndPattern(LogicalAndPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitLogicalOrPattern(LogicalOrPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitMapLiteralEntry(MapLiteralEntry node)
    => _defaultFormatter.format(node);

    @override
    void visitMapPattern(MapPattern node)
    => _mapPatternFormatter.format(node);

    @override
    void visitMapPatternEntry(MapPatternEntry node)
    => _defaultFormatter.format(node);

    @override
    void visitMethodDeclaration(MethodDeclaration node)
    => _defaultFormatter.format(node);

    @override
    void visitMethodInvocation(MethodInvocation node)
    => _methodInvocationFormatter.format(node);

    @override
    void visitMixinDeclaration(MixinDeclaration node)
    => _mixinDeclarationFormatter.format(node);

    @override
    void visitNamedExpression(NamedExpression node)
    => _namedExpressionFormatter.format(node);

    @override
    void visitNamedType(NamedType node)
    => _defaultFormatter.format(node);

    @override
    void visitNativeClause(NativeClause node)
    => _defaultFormatter.format(node);

    @override
    void visitNativeFunctionBody(NativeFunctionBody node)
    => _nativeFunctionBodyFormatter.format(node);

    @override
    void visitNullAssertPattern(NullAssertPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitNullCheckPattern(NullCheckPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitNullLiteral(NullLiteral node)
    => _defaultFormatter.format(node);

    @override
    void visitObjectPattern(ObjectPattern node)
    => _objectPatternFormatter.format(node);

    @override
    // ignore: deprecated_member_use
    void visitOnClause(OnClause node)
    => _mixinOnClauseFormatter.format(node);

    @override
    void visitParenthesizedExpression(ParenthesizedExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitParenthesizedPattern(ParenthesizedPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitPartDirective(PartDirective node)
    => _partDirectiveFormatter.format(node);

    @override
    void visitPartOfDirective(PartOfDirective node)
    => _partOfDirectiveFormatter.format(node);

    @override
    void visitPatternAssignment(PatternAssignment node)
    => _defaultFormatter.format(node);

    @override
    void visitPatternField(PatternField node)
    => _defaultFormatter.format(node);

    @override
    void visitPatternFieldName(PatternFieldName node)
    => _defaultFormatter.format(node);

    @override
    void visitPatternVariableDeclaration(PatternVariableDeclaration node)
    => _defaultFormatter.format(node);

    @override
    void visitPatternVariableDeclarationStatement(PatternVariableDeclarationStatement node)
    => _patternVariableDeclarationStatementFormatter.format(node);

    @override
    void visitPostfixExpression(PostfixExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitPrefixExpression(PrefixExpression node)
    => _defaultFormatter.format(node);

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
    => _recordPatternFormatter.format(node);

    @override
    void visitRecordTypeAnnotation(RecordTypeAnnotation node)
    => _recordTypeAnnotationFormatter.format(node);

    @override
    void visitRecordTypeAnnotationNamedField(RecordTypeAnnotationNamedField node)
    => _defaultFormatter.format(node);

    @override
    void visitRecordTypeAnnotationNamedFields(RecordTypeAnnotationNamedFields node)
    => _recordTypeAnnotationNamedFieldsFormatter.format(node);

    @override
    void visitRecordTypeAnnotationPositionalField(RecordTypeAnnotationPositionalField node)
    => _defaultFormatter.format(node);

    @override
    void visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node)
    => _defaultFormatter.format(node);

    @override
    void visitRelationalPattern(RelationalPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitRepresentationConstructorName(RepresentationConstructorName node)
    => _defaultFormatter.format(node);

    @override
    void visitRepresentationDeclaration(RepresentationDeclaration node)
    => _defaultFormatter.format(node);

    @override
    void visitRestPatternElement(RestPatternElement node)
    => _defaultFormatter.format(node);

    @override
    void visitRethrowExpression(RethrowExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitReturnStatement(ReturnStatement node)
    => _returnStatementFormatter.format(node);

    @override
    void visitScriptTag(ScriptTag node)
    => _defaultFormatter.format(node);

    @override
    void visitSetOrMapLiteral(SetOrMapLiteral node)
    => _setOrMapLiteralFormatter.format(node);

    @override
    void visitShowCombinator(ShowCombinator node)
    => _showCombinatorFormatter.format(node);

    @override
    void visitSimpleFormalParameter(SimpleFormalParameter node)
    => _defaultFormatter.format(node);

    @override
    void visitSimpleIdentifier(SimpleIdentifier node)
    => _defaultFormatter.format(node);

    @override
    void visitSimpleStringLiteral(SimpleStringLiteral node)
    => _simpleStringLiteralFormatter.format(node);
    //=> _defaultFormatter.format(node);

    @override
    void visitSpreadElement(SpreadElement node)
    => _defaultFormatter.format(node);

    @override
    void visitStringInterpolation(StringInterpolation node)
    => _defaultFormatter.format(node);
    //=> _stringInterpolationFormatter.format(node);

    @override
    void visitSuperConstructorInvocation(SuperConstructorInvocation node)
    => _defaultFormatter.format(node);

    @override
    void visitSuperExpression(SuperExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitSuperFormalParameter(SuperFormalParameter node)
    => _superFormalParameterFormatter.format(node);

    @override
    void visitSwitchCase(SwitchCase node)
    => _defaultFormatter.format(node);

    @override
    void visitSwitchDefault(SwitchDefault node)
    => _defaultFormatter.format(node);

    @override
    void visitSwitchExpression(SwitchExpression node)
    => _switchExpressionFormatter.format(node);

    @override
    void visitSwitchExpressionCase(SwitchExpressionCase node)
    => _defaultFormatter.format(node);

    @override
    void visitSwitchPatternCase(SwitchPatternCase node)
    => _switchPatternCaseFormatter.format(node);

    @override
    void visitSwitchStatement(SwitchStatement node)
    => _switchStatementFormatter.format(node);

    @override
    void visitSymbolLiteral(SymbolLiteral node)
    => _symbolLiteralFormatter.format(node);

    @override
    void visitThisExpression(ThisExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node)
    => _topLevelVariableDeclarationFormatter.format(node);

    @override
    void visitThrowExpression(ThrowExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitTryStatement(TryStatement node)
    => _defaultFormatter.format(node);

    @override
    void visitTypeArgumentList(TypeArgumentList node)
    => _typeArgumentListFormatter.format(node);

    @override
    void visitTypeLiteral(TypeLiteral node)
    => _defaultFormatter.format(node);

    @override
    void visitTypeParameter(TypeParameter node)
    => _defaultFormatter.format(node);

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
    void visitVariableDeclarationStatement(VariableDeclarationStatement node)
    => _variableDeclarationStatementFormatter.format(node);

    @override
    void visitWhenClause(WhenClause node)
    => _defaultFormatter.format(node);

    @override
    void visitWhileStatement(WhileStatement node)
    => _whileStatementFormatter.format(node);

    @override
    void visitWildcardPattern(WildcardPattern node)
    => _defaultFormatter.format(node);

    @override
    void visitWithClause(WithClause node)
    => _withClauseFormatter.format(node);

    @override
    void visitYieldStatement(YieldStatement node)
    => _yieldStatementFormatter.format(node);

    @override
    void visitAugmentedExpression(AugmentedExpression node)
    => _defaultFormatter.format(node);

    @override
    void visitAugmentedInvocation(AugmentedInvocation node)
    => _defaultFormatter.format(node);

    @override
    void visitExtensionOnClause(ExtensionOnClause node)
    => _defaultFormatter.format(node);

    @override
    void visitMixinOnClause(MixinOnClause node)
    => _mixinOnClauseFormatter.format(node);

    @override
    void visitNullAwareElement(NullAwareElement node)
    => _mixinOnClauseFormatter.format(node);
}
