import 'package:analyzer/dart/analysis/utilities.dart' as AnalyzerUtilities; // ignore: library_prefixes
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Data/ConfigExtension.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('ConfigExtension.space0 / space1', ()
        {
            test('return 0/1 when fixSpaces is true', ()
                {
                    final Config c = Config.all(fixSpaces: true);
                    expect(c.space0, equals(0));
                    expect(c.space1, equals(1));
                }
            );

            test('return null when fixSpaces is false', ()
                {
                    final Config c = Config.all(fixSpaces: false);
                    expect(c.space0, isNull);
                    expect(c.space1, isNull);
                }
            );
        }
    );

    group('ConfigExtension.getSpacesZeroOne', ()
        {
            test('returns 0 when child sits at the parent node start', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'class C {}', throwIfDiagnostics: false).unit;
                    final ClassDeclaration cls = unit.declarations.first as ClassDeclaration;
                    expect(Config.all(fixSpaces: true).getSpacesZeroOne(cls, cls.classKeyword), equals(0));
                }
            );

            test('returns 1 when child is not at the parent node start', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'class C {}', throwIfDiagnostics: false).unit;
                    final ClassDeclaration cls = unit.declarations.first as ClassDeclaration;
                    expect(Config.all(fixSpaces: true).getSpacesZeroOne(cls, cls.namePart.typeName), equals(1));
                }
            );

            test('returns null when fixSpaces is false', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'class C {}', throwIfDiagnostics: false).unit;
                    final ClassDeclaration cls = unit.declarations.first as ClassDeclaration;
                    expect(Config.all(fixSpaces: false).getSpacesZeroOne(cls, cls.classKeyword), isNull);
                    expect(Config.all(fixSpaces: false).getSpacesZeroOne(cls, cls.namePart.typeName), isNull);
                }
            );
        }
    );

    group('ConfigExtension.getSpacesEmptyStatementZeroOne', ()
        {
            test('returns 0 for an EmptyStatement, 1 for any other entity', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'void f() { ; var x = 1; }', throwIfDiagnostics: false).unit;
                    final FunctionDeclaration fn = unit.declarations.first as FunctionDeclaration;
                    final Block body = (fn.functionExpression.body as BlockFunctionBody).block;
                    final Statement emptyStmt = body.statements.first;
                    final Statement otherStmt = body.statements.last;
                    expect(emptyStmt, isA<EmptyStatement>());

                    final Config c = Config.all(fixSpaces: true);
                    expect(c.getSpacesEmptyStatementZeroOne(emptyStmt), equals(0));
                    expect(c.getSpacesEmptyStatementZeroOne(otherStmt), equals(1));
                }
            );

            test('returns null when fixSpaces is false', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'void f() { ; }', throwIfDiagnostics: false).unit;
                    final FunctionDeclaration fn = unit.declarations.first as FunctionDeclaration;
                    final Statement emptyStmt = ((fn.functionExpression.body as BlockFunctionBody).block).statements.first;
                    expect(Config.all(fixSpaces: false).getSpacesEmptyStatementZeroOne(emptyStmt), isNull);
                }
            );
        }
    );

    group('ConfigExtension.getSpacesEmptyFunctionBodyZeroOne', ()
        {
            test('returns 0 for an EmptyFunctionBody, 1 for any other entity', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'abstract class C { void abstractM(); void concreteM() {} }', throwIfDiagnostics: false).unit;
                    final ClassDeclaration cls = unit.declarations.first as ClassDeclaration;
                    final MethodDeclaration abstractM = (cls.body as BlockClassBody).members.first as MethodDeclaration;
                    final MethodDeclaration concreteM = (cls.body as BlockClassBody).members.last as MethodDeclaration;
                    expect(abstractM.body, isA<EmptyFunctionBody>());

                    final Config c = Config.all(fixSpaces: true);
                    expect(c.getSpacesEmptyFunctionBodyZeroOne(abstractM.body), equals(0));
                    expect(c.getSpacesEmptyFunctionBodyZeroOne(concreteM.body), equals(1));
                }
            );

            test('returns null when fixSpaces is false', ()
                {
                    final CompilationUnit unit = AnalyzerUtilities.parseString(content: 'abstract class C { void f(); }', throwIfDiagnostics: false).unit;
                    final ClassDeclaration cls = unit.declarations.first as ClassDeclaration;
                    final MethodDeclaration m = (cls.body as BlockClassBody).members.first as MethodDeclaration;
                    expect(Config.all(fixSpaces: false).getSpacesEmptyFunctionBodyZeroOne(m.body), isNull);
                }
            );
        }
    );
}
