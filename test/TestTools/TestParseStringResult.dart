import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/source/line_info.dart';

class TestParseStringResult implements ParseStringResult
{
    final String _content;
    final CompilationUnit _unit;

    TestParseStringResult({required String content, required CompilationUnit unit})
        : _content = content, _unit = unit;

    @override
    String get content
    => _content;

    @override
    List<Diagnostic> get errors
    => throw UnimplementedError();

    @override
    LineInfo get lineInfo
    => throw UnimplementedError();

    @override
    CompilationUnit get unit
    => _unit;
}
