import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_format/src/Constants/Constants.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:dart_format/src/Tools/LogTools.dart';
import 'package:dart_format/src/Tools/StringTools.dart';

import 'TestAnnotationVisitor.dart';
import 'TestArgumentListVisitor.dart';
import 'TestAssignmentExpressionVisitor.dart';
import 'TestAstVisitor.dart';
import 'TestBinaryExpressionVisitor.dart';
import 'TestBlockFunctionBodyVisitor.dart';
import 'TestBlockVisitor.dart';
import 'TestBooleanLiteralVisitor.dart';
import 'TestCatchClauseParameterVisitor.dart';
import 'TestCatchClauseVisitor.dart';
import 'TestClassDeclarationVisitor.dart';
import 'TestConstructorDeclarationVisitor.dart';
import 'TestConstructorFieldInitializerVisitor.dart';
import 'TestConstructorNameVisitor.dart';
import 'TestDeclaredIdentifierVisitor.dart';
import 'TestDefaultFormalParameterVisitor.dart';
import 'TestEmptyFunctionBodyVisitor.dart';
import 'TestEmptyStatementVisitor.dart';
import 'TestEnumConstantDeclarationVisitor.dart';
import 'TestExpressionFunctionBodyVisitor.dart';
import 'TestExpressionStatementVisitor.dart';
import 'TestExtendsClauseVisitor.dart';
import 'TestForPartsWithExpressionVisitor.dart';
import 'TestFormalParameterListVisitor.dart';
import 'TestFunctionExpressionVisitor.dart';
import 'TestGenericFunctionTypeVisitor.dart';
import 'TestGuardedPatternVisitor.dart';
import 'TestIfStatementVisitor.dart';
import 'TestImplementsClauseVisitor.dart';
import 'TestImportDirectiveVisitor.dart';
import 'TestLibraryIdentifierVisitor.dart';
import 'TestMethodDeclarationVisitor.dart';
import 'TestNamedTypeVisitor.dart';
import 'TestPostfixVisitor.dart';
import 'TestSimpleFormalParameterVisitor.dart';
import 'TestSimpleIdentifierVisitor.dart';
import 'TestSimpleStringLiteralVisitor.dart';
import 'TestSuperConstructorInvocationVisitor.dart';
import 'TestSwitchPatternCaseVisitor.dart';
import 'TestTypeArgumentListVisitor.dart';
import 'TestTypeParameterListVisitor.dart';
import 'TestVariableDeclarationListVisitor.dart';
import 'TestWithClauseVisitor.dart';

class MetaAstVisitor extends ThrowingAstVisitor<void>
{
    final List<TestAstVisitor>? astVisitors;
    final FormatState formatState;

    int _currentVisitorIndex = 0;

    MetaAstVisitor(this.astVisitors, this.formatState);

    int get currentVisitorIndex => _currentVisitorIndex;

    @override
    void visitAnnotation(Annotation node)
    => _visit<TestAnnotationVisitor>(node);

    @override
    void visitArgumentList(ArgumentList node)
    => _visit<TestArgumentListVisitor>(node);

    @override
    void visitAssignmentExpression(AssignmentExpression node)
    => _visit<TestAssignmentExpressionVisitor>(node);

    @override
    void visitBinaryExpression(BinaryExpression node)
    => _visit<TestBinaryExpressionVisitor>(node);

    @override
    void visitBlock(Block node)
    => _visit<TestBlockVisitor>(node);

    @override
    void visitBlockFunctionBody(BlockFunctionBody node)
    => _visit<TestBlockFunctionBodyVisitor>(node);

    @override
    void visitBooleanLiteral(BooleanLiteral node)
    => _visit<TestBooleanLiteralVisitor>(node);

    @override
    void visitCatchClause(CatchClause node)
    => _visit<TestCatchClauseVisitor>(node);

    @override
    void visitCatchClauseParameter(CatchClauseParameter node)
    => _visit<TestCatchClauseParameterVisitor>(node);

    @override
    void visitClassDeclaration(ClassDeclaration node)
    => _visit<TestClassDeclarationVisitor>(node);

    @override
    void visitConstructorDeclaration(ConstructorDeclaration node)
    => _visit<TestConstructorDeclarationVisitor>(node);

    @override
    void visitConstructorFieldInitializer(ConstructorFieldInitializer node)
    => _visit<TestConstructorFieldInitializerVisitor>(node);

    @override
    void visitConstructorName(ConstructorName node)
    => _visit<TestConstructorNameVisitor>(node);

    @override
    void visitDeclaredIdentifier(DeclaredIdentifier node)
    => _visit<TestDeclaredIdentifierVisitor>(node);

    @override
    void visitDefaultFormalParameter(DefaultFormalParameter node)
    => _visit<TestDefaultFormalParameterVisitor>(node);

    @override
    void visitEmptyFunctionBody(EmptyFunctionBody node)
    => _visit<TestEmptyFunctionBodyVisitor>(node);

    @override
    void visitEmptyStatement(EmptyStatement node)
    => _visit<TestEmptyStatementVisitor>(node);

    @override
    void visitEnumConstantDeclaration(EnumConstantDeclaration node)
    => _visit<TestEnumConstantDeclarationVisitor>(node);

    @override
    void visitExpressionStatement(ExpressionStatement node)
    => _visit<TestExpressionStatementVisitor>(node);

    @override
    void visitExpressionFunctionBody(ExpressionFunctionBody node)
    => _visit<TestExpressionFunctionBodyVisitor>(node);

    @override
    void visitExtendsClause(ExtendsClause node)
    => _visit<TestExtendsClauseVisitor>(node);

    @override
    void visitFormalParameterList(FormalParameterList node)
    => _visit<TestFormalParameterListVisitor>(node);

    @override
    void visitFunctionExpression(FunctionExpression node)
    => _visit<TestFunctionExpressionVisitor>(node);

    @override
    void visitForPartsWithExpression(ForPartsWithExpression node)
    => _visit<TestForPartsWithExpressionVisitor>(node);

    @override
    void visitGuardedPattern(GuardedPattern node)
    => _visit<TestGuardedPatternVisitor>(node);

    @override
    void visitGenericFunctionType(GenericFunctionType node)
    => _visit<TestGenericFunctionTypeVisitor>(node);

    @override
    void visitIfStatement(IfStatement node)
    => _visit<TestIfStatementVisitor>(node);

    @override
    void visitImplementsClause(ImplementsClause node)
    => _visit<TestImplementsClauseVisitor>(node);

    @override
    void visitImportDirective(ImportDirective node)
    => _visit<TestImportDirectiveVisitor>(node);

    @override
    void visitNamedType(NamedType node)
    => _visit<TestNamedTypeVisitor>(node);

    @override
    void visitLibraryIdentifier(LibraryIdentifier node)
    => _visit<TestLibraryIdentifierVisitor>(node);

    @override
    void visitMethodDeclaration(MethodDeclaration node)
    => _visit<TestMethodDeclarationVisitor>(node);

    @override
    void visitPostfixExpression(PostfixExpression node)
    => _visit<TestPostfixExpressionVisitor>(node);

    @override
    void visitSimpleFormalParameter(SimpleFormalParameter node)
    => _visit<TestSimpleFormalParameterVisitor>(node);

    @override
    void visitSimpleIdentifier(SimpleIdentifier node)
    => _visit<TestSimpleIdentifierVisitor>(node);

    @override
    void visitSimpleStringLiteral(SimpleStringLiteral node)
    => _visit<TestSimpleStringLiteralVisitor>(node);

    @override
    void visitSuperConstructorInvocation(SuperConstructorInvocation node)
    => _visit<TestSuperConstructorInvocationVisitor>(node);

    @override
    void visitSwitchPatternCase(SwitchPatternCase node)
    => _visit<TestSwitchPatternCaseVisitor>(node);

    @override
    void visitTypeArgumentList(TypeArgumentList node)
    => _visit<TestTypeArgumentListVisitor>(node);

    @override
    void visitTypeParameterList(TypeParameterList node)
    => _visit<TestTypeParameterListVisitor>(node);

    @override
    void visitVariableDeclarationList(VariableDeclarationList node)
    => _visit<TestVariableDeclarationListVisitor>(node);

    @override
    void visitWithClause(WithClause node)
    => _visit<TestWithClauseVisitor>(node);

    void _visit<T>(AstNode node)
    {
        try
        {
            if (astVisitors == null)
                throw Exception('Visitor #${_currentVisitorIndex + 1} expected for ${node.runtimeType} but none given at all.');

            if (_currentVisitorIndex >= astVisitors!.length)
                throw Exception('Visitor #${_currentVisitorIndex + 1} expected for ${node.runtimeType} but none left.');

            final TestAstVisitor visitor = astVisitors![_currentVisitorIndex];
            if (visitor is! T)
                throw Exception('Visitor #${_currentVisitorIndex + 1} expected to be of type $T expected but is ${visitor.runtimeType}.');

            logInfo('# ${visitor.runtimeType}(${StringTools.toDisplayString(node, Constants.MAX_DEBUG_LENGTH)})');
            visitor.formatState = formatState;
            node.accept(visitor);
        }
        finally
        {
            _currentVisitorIndex++;
        }
    }
}
