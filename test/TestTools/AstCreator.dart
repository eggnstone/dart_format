import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/src/dart/ast/ast.dart';

class AstCreator
{
    static ArgumentList createArgumentListInFunction(String s)
    => createMethodInvocationInExpressionStatementInFunction(s).argumentList;

    static AssignmentExpression createAssignmentExpressionInFunction(String s)
    => createExpressionInFunction(s) as AssignmentExpression;

    static BinaryExpression createBinaryExpressionInTopLevelVariable(String s)
    => createInitializerInTopLevelVariable(s) as BinaryExpression;

    static BlockFunctionBody createBlockFunctionBody(String s)
    => createFunctionBody(s) as BlockFunctionBody;

    static Block createBlockInFunction(String s)
    => createBlockFunctionBody(s).block;

    static CascadeExpression createCascadeExpressionInFunction(String s)
    => createExpressionInFunction(s) as CascadeExpression;

    static CascadeExpression createCascadeExpressionInVariableDeclarationInClass(String s)
    => createInitializerInVariableDeclarationInClass(s) as CascadeExpression;

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

    static ConditionalExpression createConditionalExpression(String s)
    => createInitializerInVariableDeclarationInFunction(s) as ConditionalExpression;

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

    static Expression createExpressionInFunction(String s)
    => createExpressionStatementInFunction(s).expression;

    static ExpressionStatement createExpressionStatementInFunction(String s)
    => createStatementInFunction(s) as ExpressionStatement;

    static FieldDeclaration createFieldDeclarationInClass(String s)
    => createClassMember(s) as FieldDeclaration;

    static ForElement createForElement(String s)
    => createSetOrMapLiteral(s).elements.first as ForElement;

    static FunctionBody createFunctionBody(String s)
    => createFunctionExpression(s).body;

    static FunctionTypeAlias createFunctionTypeAlias(String s)
    => createDeclaration(s) as FunctionTypeAlias;

    static Expression createInitializerInVariableDeclarationInClass(String s)
    => createVariableDeclarationInClass(s).initializer!;

    static Expression createInitializerInVariableDeclarationInFunction(String s)
    => createVariableDeclarationInFunction(s).initializer!;

    static Expression createInitializerInTopLevelVariable(String s)
    => createVariableDeclarationInTopLevelVariableDeclaration(s).initializer!;

    static ForLoopParts createForLoopPartsInFunction(String s)
    => createForStatementInFunction(s).forLoopParts;

    static FormalParameter createFormalParameterInFunction(String s)
    => createFormalParameterListInFunction(s).parameters[0];

    static DefaultFormalParameter createDefaultFormalParameterInFunction(String s)
    => createFormalParameterInFunction(s) as DefaultFormalParameter;

    static FormalParameter createFormalParameterInDefaultFormalParameterInFunction(String s)
    => createDefaultFormalParameterInFunction(s).parameter;

    static FormalParameterList createFormalParameterListInFunction(String s)
    => createFunctionExpression(s).parameters!;

    static ForStatement createForStatementInFunction(String s)
    => createStatementInFunction(s) as ForStatement;

    static FunctionBody createFunctionBodyInFunction(String s)
    => createFunctionExpression(s).body;

    static FunctionDeclaration createFunctionDeclaration(String s)
    => createDeclaration(s) as FunctionDeclaration;

    static DefaultFormalParameter createFunctionDefaultFormalParameter(String s)
    => createFunctionParameter(s) as DefaultFormalParameter;

    static NormalFormalParameter createFunctionDefaultFormalParameterParameter(String s)
    => createFunctionDefaultFormalParameter(s).parameter;

    static FunctionExpression createFunctionExpression(String s)
    => createFunctionDeclaration(s).functionExpression;

    static FormalParameter createFunctionParameter(String s)
    => createFunctionParameters(s).parameters[0];

    static FormalParameterList createFunctionParameters(String s)
    => createFunctionExpression(s).parameters!;

    static IfStatement createIfStatementInFunction(String s)
    => createStatementInFunction(s) as IfStatement;

    static MethodDeclaration createMethodDeclaration(String s)
    => createClassMember(s) as MethodDeclaration;

    static FormalParameterList createMethodDeclarationParameters(String s)
    => createMethodDeclaration(s).parameters!;

    static FormalParameter createMethodDeclarationParametersParameter(String s)
    => createMethodDeclarationParametersParameters(s)[0];

    static NodeList<FormalParameter> createMethodDeclarationParametersParameters(String s)
    => createMethodDeclarationParameters(s).parameters;

    static MethodInvocation createMethodInvocationInExpressionStatementInFunction(String s)
    => createExpressionStatementInFunction(s).childEntities.first as MethodInvocation;

    static TypeAnnotation createMethodReturnType(String s)
    => createMethodDeclaration(s).returnType!;

    static MixinDeclaration createMixinDeclaration(String s)
    => createDeclaration(s) as MixinDeclaration;

    static NamedType createNamedTypeInMethodReturnType(String s)
    => createMethodReturnType(s) as NamedType;

    static TypeAnnotation createNamedTypeOfTopLevelVariable(String s)
    => createTopLevelVariableList(s).type!;

    static NamespaceDirective createNamespaceDirective(String s)
    => createDirective(s) as NamespaceDirective;

    /*// ignore: deprecated_member_use
    static OnClause createOnClauseInMixinDeclaration(String s)
    => createMixinDeclaration(s).onClause!;*/

    static ReturnStatement createReturnStatementInFunction(String s)
    => createStatementInFunction(s) as ReturnStatement;

    static Expression createRightHandSideInAssignmentExpressionInFunction(String s)
    => createAssignmentExpressionInFunction(s).rightHandSide;

    static SetOrMapLiteral createSetOrMapLiteral(String s)
    => createRightHandSideInAssignmentExpressionInFunction(s) as SetOrMapLiteral;

    static SimpleFormalParameter createSimpleFormalParameterInFunction(String s)
    => createFormalParameterInFunction(s) as SimpleFormalParameter;

    static Statement createStatementInFunction(String s)
    => createBlockInFunction(s).statements[0];

    static Statement createStatementInWhileInFunction(String s)
    => createWhileStatementInFunction(s).body;

    static Expression createReturnStatementExpressionInFunction(String s)
    => createReturnStatementInFunction(s).expression!;

    static SwitchExpression createSwitchExpressionInReturnStatementExpressionInFunction(String s)
    => createReturnStatementExpressionInFunction(s) as SwitchExpression;

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

    static TypeArgumentList createTypeArgumentListInMethodReturnType(String s)
    => createNamedTypeInMethodReturnType(s).typeArguments!;

    static TypeParameterList createTypeParameterListInFunction(String s)
    => createFunctionExpression(s).typeParameters!;

    static VariableDeclaration createVariableDeclarationInFunction(String s)
    => createVariableDeclarationListInFunction(s).variables[0];

    static VariableDeclaration createVariableDeclarationInTopLevelVariableDeclaration(String s)
    => createVariableDeclarationsInTopLevelVariableDeclaration(s)[0];

    static VariableDeclarationList createVariableDeclarationListInFunction(String s)
    => createVariableDeclarationStatementInFunction(s).variables;

    static NodeList<VariableDeclaration> createVariableDeclarationsInTopLevelVariableDeclaration(String s)
    => createTopLevelVariableList(s).variables;

    static VariableDeclarationStatement createVariableDeclarationStatementInFunction(String s)
    => createStatementInFunction(s) as VariableDeclarationStatement;

    static VariableDeclaration createVariableDeclarationInClass(String s)
    => createVariableDeclarationListInClass(s).variables[0];

    static VariableDeclarationList createVariableDeclarationListInClass(String s)
    => createFieldDeclarationInClass(s).fields;

    static WhileStatement createWhileStatementInFunction(String s)
    => createStatementInFunction(s) as WhileStatement;
}
