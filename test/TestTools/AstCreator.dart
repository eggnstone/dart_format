import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/src/dart/ast/ast.dart';

class AstCreator
{
    static ArgumentList createArgumentListInMethodInvocationInFunction(String s)
    => createMethodInvocationInFunction(s).argumentList;

    static BlockFunctionBody createBlockFunctionBody(String s)
    => createFunctionExpression(s).body as BlockFunctionBody;

    static Block createBlockInFunction(String s)
    => createBlockFunctionBody(s).block;

    static CascadeExpression createCascadeExpressionInStatementInFunction(String s)
    => createExpressionInExpressionStatementInFunction(s) as CascadeExpression;

    static CascadeExpression createCascadeExpressionInVariableDeclarationInClass(String s)
    => createInitializerInVariableDeclarationInClass(s) as CascadeExpression;

    static Expression createCascadeSectionInStatementInFunction(String s)
    => createCascadeExpressionInStatementInFunction(s).cascadeSections[0];

    static Expression createCascadeSectionInVariableDeclarationInClass(String s)
    => createCascadeExpressionInVariableDeclarationInClass(s).cascadeSections[0];

    static CatchClause createCatchClauseInFunction(String s)
    => createTryStatementInFunction(s).catchClauses[0];

    static ClassDeclaration createClassDeclaration(String s)
    => createDeclaration(s) as ClassDeclaration;

    static ClassMember createClassMember(String s)
    => createClassDeclaration(s).members[0];

    static Combinator createCombinatorInNamespaceDirective(String s)
    => createNamespaceDirective(s).combinators[0];

    static AstNode createCommentBeforeClassDeclaration(String s)
    => createClassDeclaration(s).sortedCommentAndAnnotations[0];

    static ConstructorDeclaration createConstructorDeclaration(String s)
    => createClassMember(s) as ConstructorDeclaration;

    static ConstructorInitializer createConstructorInitializer(String s)
    => createConstructorDeclaration(s).initializers[0];

    static CompilationUnit createCompilationUnit(String s)
    => AnalyzerUtilities.parseString(content: s).unit;

    static Declaration createDeclaration(String s)
    => createCompilationUnit(s).declarations[0];

    static Directive createDirective(String s)
    => createCompilationUnit(s).directives[0];

    static EnumConstantDeclaration createEnumConstantDeclaration(String s)
    => createEnumDeclaration(s).constants[0];

    static EnumDeclaration createEnumDeclaration(String s)
    => createDeclaration(s) as EnumDeclaration;

    static Expression createExpressionInExpressionStatementInFunction(String s)
    => createExpressionStatementInFunction(s).expression;

    static ExpressionStatement createExpressionStatementInFunction(String s)
    => createStatementInFunction(s) as ExpressionStatement;

    static FieldDeclaration createFieldDeclarationInClass(String s)
    => createClassMember(s) as FieldDeclaration;

    static ForLoopParts createForLoopPartsInForStatementInFunction(String s)
    => createForStatementInFunction(s).forLoopParts;

    static FormalParameter createFormalParameterInFunction(String s)
    => createFormalParameterListInFunction(s).parameters[0];

    static FormalParameterList createFormalParameterListInFunction(String s)
    => createFunctionExpression(s).parameters!;

    static ForStatement createForStatementInFunction(String s)
    => createStatementInFunction(s) as ForStatement;

    static FunctionBody createFunctionBodyInFunction(String s)
    => createFunctionExpression(s).body;

    static FunctionDeclaration createFunctionDeclaration(String s)
    => createDeclaration(s) as FunctionDeclaration;

    static FunctionExpression createFunctionExpression(String s)
    => createFunctionDeclaration(s).functionExpression;

    static Expression createInitializerInVariableDeclarationInClass(String s)
    => createVariableDeclarationInClass(s).initializer!;

    static MethodInvocation createMethodInvocationInFunction(String s)
    => createExpressionInExpressionStatementInFunction(s) as MethodInvocation;

    static MixinDeclaration createMixinDeclaration(String s)
    => createDeclaration(s) as MixinDeclaration;

    static TypeAnnotation createNamedTypeOfTopLevelVariable(String s)
    => createTopLevelVariableList(s).type!;

    static NamespaceDirective createNamespaceDirective(String s)
    => createDirective(s) as NamespaceDirective;

    static OnClause createOnClauseInMixinDeclaration(String s)
    => createMixinDeclaration(s).onClause!;

    static SimpleFormalParameter createSimpleFormalParameterInFunction(String s)
    => createFormalParameterInFunction(s) as SimpleFormalParameter;

    static Statement createStatementInFunction(String s)
    => createBlockInFunction(s).statements[0];

    static Statement createStatementInWhileInFunction(String s)
    => createWhileStatementInFunction(s).body;

    static SwitchStatement createSwitchStatementInFunction(String s)
    => createStatementInFunction(s) as SwitchStatement;

    static SwitchMember createSwitchStatementMemberInFunction(String s)
    => createSwitchStatementInFunction(s).members[0];

    static TopLevelVariableDeclaration createTopLevelVariableDeclaration(String s)
    => createDeclaration(s) as TopLevelVariableDeclaration;

    static VariableDeclarationList createTopLevelVariableList(String s)
    => createTopLevelVariableDeclaration(s).variables;

    static TryStatement createTryStatementInFunction(String s)
    => createStatementInFunction(s) as TryStatement;

    static TypeAnnotation createTypeAnnotationInFunctionParameter(String s)
    => createSimpleFormalParameterInFunction(s).type!;

    static VariableDeclaration createVariableDeclarationInClass(String s)
    => createVariableDeclarationListInClass(s).variables[0];

    static VariableDeclarationList createVariableDeclarationListInClass(String s)
    => createFieldDeclarationInClass(s).fields;

    static WhileStatement createWhileStatementInFunction(String s)
    => createStatementInFunction(s) as WhileStatement;
}
