import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/src/dart/ast/ast.dart';

class AstCreator
{
    static VariableDeclarationList createVariableDeclarationListInClass(String s)
    => createFieldDeclarationInClass(s).fields;

    static FieldDeclaration createFieldDeclarationInClass(String s)
    => createDeclarationInClass(s) as FieldDeclaration;

    static ClassMember createDeclarationInClass(String s)
    => createClassDeclaration(s).members[0];

    static TypeAnnotation createTypeAnnotationInFunctionParameter(String s)
    => createSimpleFormalParameterInFunction(s).type!;

    static SimpleFormalParameter createSimpleFormalParameterInFunction(String s)
    => createFormalParameterInFunction(s) as SimpleFormalParameter;

    static FormalParameter createFormalParameterInFunction(String s)
    => createFormalParameterListInFunction(s).parameters[0];

    static TopLevelVariableDeclaration createTopLevelVariableDeclaration(String s)
    => createDeclaration(s) as TopLevelVariableDeclaration;

    static VariableDeclarationList createTopLevelVariableList(String s)
    => createTopLevelVariableDeclaration(s).variables;

    static TypeAnnotation createNamedTypeOfTopLevelVariable(String s)
    => createTopLevelVariableList(s).type!;

    static Block createBlockInFunction(String s)
    => _createBlockFunctionBodyInFunction(s).block;

    static CatchClause createCatchClauseInFunction(String s)
    => _createTryStatementInFunction(s).catchClauses[0];

    static ClassDeclaration createClassDeclaration(String s)
    => createDeclaration(s) as ClassDeclaration;

    static ClassMember createClassMember(String s)
    => createClassDeclaration(s).members[0];

    /*static ConstructorDeclaration createConstructorDeclarationInClass(String s)
    => createClassMember(s) as ConstructorDeclaration;*/

    /*static FormalParameterList createFormalParameterListInConstructorInClass(String s)
    => createConstructorDeclarationInClass(s).parameters;*/

    static FormalParameterList createFormalParameterListInFunction(String s)
    => createFunctionExpression(s).parameters!;

    static CompilationUnit createCompilationUnit(String s)
    => AnalyzerUtilities.parseString(content: s).unit;

    static AstNode createCommentBeforeClassDeclaration(String s)
    => createClassDeclaration(s).sortedCommentAndAnnotations[0];

    static Declaration createDeclaration(String s)
    => createCompilationUnit(s).declarations[0];

    static Directive createDirective(String s)
    => createCompilationUnit(s).directives[0];

    static EnumConstantDeclaration createEnumConstantDeclaration(String s)
    => _createEnumDeclaration(s).constants[0];

    static Expression createExpressionInFunction(String s)
    => _createExpressionStatementInFunction(s).expression;

    static FunctionBody createFunctionBodyInFunction(String s)
    => createFunctionExpression(s).body;

    static ForLoopParts createForLoopPartsInForStatementInFunction(String s)
    => _createForStatementInFunction(s).forLoopParts;

    static FunctionExpression createFunctionExpression(String s)
    => _createFunctionDeclaration(s).functionExpression;

    static Statement createStatementInFunction(String s)
    => createBlockInFunction(s).statements[0];

    static Statement createStatementInWhileInFunction(String s)
    => _createWhileStatementInFunction(s).body;

    static SwitchMember createSwitchStatementMemberInFunction(String s)
    => (createStatementInFunction(s) as SwitchStatement).members[0];

    //

    static BlockFunctionBody _createBlockFunctionBodyInFunction(String s)
    => createFunctionExpression(s).body as BlockFunctionBody;

    static EnumDeclaration _createEnumDeclaration(String s)
    => createDeclaration(s) as EnumDeclaration;

    static ExpressionStatement _createExpressionStatementInFunction(String s)
    => createStatementInFunction(s) as ExpressionStatement;

    static ForStatement _createForStatementInFunction(String s)
    => createStatementInFunction(s) as ForStatement;

    static FunctionDeclaration _createFunctionDeclaration(String s)
    => createDeclaration(s) as FunctionDeclaration;

    static TryStatement _createTryStatementInFunction(String s)
    => createStatementInFunction(s) as TryStatement;

    static WhileStatement _createWhileStatementInFunction(String s)
    => createStatementInFunction(s) as WhileStatement;
}
