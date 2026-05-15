import 'package:dart_format/src/Data/Config.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    group('Config.fromJsonText', ()
        {
            test('null returns Config.all() (all defaults)', ()
                {
                    final Config c = Config.fromJsonText(null);

                    expect(c, equals(Config.all()));
                }
            );

            test('Empty object returns Config.all() (all defaults)', ()
                {
                    final Config c = Config.fromJsonText('{}');

                    expect(c, equals(Config.all()));
                }
            );

            test('Partial JSON overrides only the listed fields; rest are defaults', ()
                {
                    final Config c = Config.fromJsonText('{"IndentationSpacesPerLevel": 2}');

                    expect(c.indentationSpacesPerLevel, equals(2));
                    expect(c.fixSpaces, equals(Config.FIX_SPACES_DEFAULT));
                    expect(c.removeTrailingCommas, equals(Config.REMOVE_TRAILING_COMMAS_DEFAULT));
                    expect(c.maxEmptyLines, equals(Config.MAX_EMPTY_LINES_DEFAULT));
                }
            );

            test('Disabling a single bool field leaves others at default', ()
                {
                    final Config c = Config.fromJsonText('{"FixSpaces": false}');

                    expect(c.fixSpaces, isFalse);
                    expect(c.removeTrailingCommas, equals(Config.REMOVE_TRAILING_COMMAS_DEFAULT));
                    expect(c.indentationSpacesPerLevel, equals(Config.INDENTATION_SPACES_PER_LEVEL_DEFAULT));
                }
            );
        }
    );
}
