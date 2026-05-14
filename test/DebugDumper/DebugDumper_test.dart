import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_format/src/DebugDumper.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('DebugDumper smoke tests', ()
        {
            test('dump(null, ...) does not throw', ()
                {
                    final DebugDumper dumper = DebugDumper('void f(){}');
                    expect(() => dumper.dump(null, 'N', '', 0), returnsNormally);
                }
            );

            test('dump with a valid token does not throw', ()
                {
                    final DebugDumper dumper = DebugDumper('void f(){}');
                    final Token token = Token(TokenType.OPEN_PAREN, 6);
                    expect(() => dumper.dump(token, 'N', '', 0), returnsNormally);
                }
            );

            test('dump2(null, null, ...) does not throw', ()
                {
                    final DebugDumper dumper = DebugDumper('void f(){}');
                    expect(() => dumper.dump2(null, null, 'N', '', 0), returnsNormally);
                }
            );

            test('dumpList(null, ...) does not throw', ()
                {
                    final DebugDumper dumper = DebugDumper('void f(){}');
                    expect(() => dumper.dumpList(null, 'N', ''), returnsNormally);
                }
            );

            test('dumpList with an empty list does not throw', ()
                {
                    final DebugDumper dumper = DebugDumper('void f(){}');
                    expect(() => dumper.dumpList(<Token>[], 'N', ''), returnsNormally);
                }
            );
        }
    );
}
