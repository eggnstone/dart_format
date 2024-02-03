import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_format/src/FormatState.dart';
import 'package:meta/meta.dart';

class TestAstVisitor extends ThrowingAstVisitor<void>
{
    late FormatState _formatState;

    @protected
    FormatState get formatState
    => _formatState;

    set formatState(FormatState formatState)
    => _formatState = formatState;
}
