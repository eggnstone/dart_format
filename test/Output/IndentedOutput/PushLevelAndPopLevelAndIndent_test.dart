import 'package:dart_format/src/Enums/IndentationType.dart';
import 'package:dart_format/src/Output/IndentedOutput.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('IndentedOutput.pushLevel / popLevelAndIndent', ()
        {
            test('no push: write goes to root buffer', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('hello');
                    expect(out.getResult(), equals('hello'));
                }
            );

            test('push + write + pop: single-line content is not indented (no leading newline)', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer ');
                    out.pushLevel('L1');
                    out.write('inner');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer inner'));
                }
            );

            test('push + write multiline + pop: subsequent lines get indented by the configured size', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('A\nB\nC');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n    A\n    B\n    C'));
                }
            );

            test('push + write multiline ending with newline + pop: trailing newline preserved', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('A\nB\n');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n    A\n    B\n'));
                }
            );

            test('nested push: indentation accumulates across two levels', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('A\n');
                    out.pushLevel('L2');
                    out.write('B\nC');
                    out.popLevelAndIndent();
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n    A\n        B\n        C'));
                }
            );

            test('custom indent size overrides the default for that level', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1', IndentationType.single, 2);
                    out.write('A\nB');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n  A\n  B'));
                }
            );

            test('single-line content starting with "{" is not indented even on a fresh line', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('{not indented}');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n{not indented}'));
                }
            );

            test('IndentationType.multiple indents the first line too', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1', IndentationType.multiple);
                    out.write('A\nB');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n    A\n    B'));
                }
            );

            test('indentationSpacesPerLevel < 0: pop concatenates without re-indenting', ()
                {
                    final IndentedOutput out = IndentedOutput(-1);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('A\nB');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\nA\nB'));
                }
            );

            test('runs of whitespace-only lines between content collapse to a single blank line', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('outer\n');
                    out.pushLevel('L1');
                    out.write('A\n   \n\nB');
                    out.popLevelAndIndent();
                    expect(out.getResult(), equals('outer\n    A\n\n    B'));
                }
            );
        }
    );
}
