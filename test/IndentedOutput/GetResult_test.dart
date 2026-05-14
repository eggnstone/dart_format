import 'package:dart_format/src/IndentedOutput.dart';
import 'package:test/test.dart';

import '../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('IndentedOutput.getResult', ()
        {
            test('empty state returns empty string', ()
                {
                    expect(IndentedOutput(4).getResult(), equals(''));
                }
            );

            test('concatenates all pushed buffers without indenting (mid-flight, before pop)', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('A');
                    out.pushLevel('L1');
                    out.write('B');
                    out.pushLevel('L2');
                    out.write('C');
                    expect(out.getResult(), equals('ABC'));
                }
            );
        }
    );

    group('IndentedOutput.getResultAfterLast', ()
        {
            test('returns text following the last occurrence of the search string', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('A:B:C');
                    expect(out.getResultAfterLast(':'), equals('C'));
                }
            );

            test('returns empty string when search text is not found', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('ABC');
                    expect(out.getResultAfterLast('Z'), equals(''));
                }
            );

            test('search crossing buffer boundaries marks each crossing with <New-Level/>', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('A:tail');
                    out.pushLevel('L1');
                    out.write('inner');
                    expect(out.getResultAfterLast(':'), equals('tail<New-Level/>inner'));
                }
            );
        }
    );

    group('IndentedOutput.getResultAfterOptionalLastLineBreak', ()
        {
            test('returns full last buffer text when no newline present', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('ABC');
                    expect(out.getResultAfterOptionalLastLineBreak(), equals('ABC'));
                }
            );

            test('returns substring after the last newline when present', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('A\nB\nC');
                    expect(out.getResultAfterOptionalLastLineBreak(), equals('C'));
                }
            );
        }
    );

    group('IndentedOutput.getResultAfterRequiredLastLineBreak', ()
        {
            test('returns empty string when no newline present', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('ABC');
                    expect(out.getResultAfterRequiredLastLineBreak(), equals(''));
                }
            );

            test('returns substring after the last newline when present', ()
                {
                    final IndentedOutput out = IndentedOutput(4);
                    out.write('A\nB');
                    expect(out.getResultAfterRequiredLastLineBreak(), equals('B'));
                }
            );
        }
    );
}
