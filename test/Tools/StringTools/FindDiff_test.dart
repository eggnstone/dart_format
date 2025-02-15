import 'package:dart_format/src/Data/IntTuple.dart';
import 'package:dart_format/src/Tools/StringTools.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('StringTools.findDiff', ()
        {
            test('Find space', ()
                {
                    const String inputText1 = 'A B';
                    const String inputText2 = 'AB';
                    const IntTuple expectedResult = IntTuple(1, 1);

                    final IntTuple actualResult = StringTools.findDiff(inputText1, inputText2);

                    expect(actualResult.item1, equals(expectedResult.item1));
                    expect(actualResult.item2, equals(expectedResult.item2));
                }
            );
        }
    );
}
