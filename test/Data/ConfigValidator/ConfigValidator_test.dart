import 'package:dart_format/src/Data/Config.dart';
import 'package:dart_format/src/Data/ConfigValidator.dart';
import 'package:dart_format/src/Exceptions/DartFormatException.dart';
import 'package:test/test.dart';

import '../../TestTools/TestTools.dart';

void main()
{
    TestTools.init();

    final Map<String, dynamic> defaults = Config.all().toJson();

    group('ConfigValidator.parse', ()
        {
            test('Returns the decoded object when every option is known', ()
                {
                    final Map<String, dynamic> result = ConfigValidator.parse('{"FixSpaces": false, "MaxEmptyLines": 2}', defaults);

                    expect(result, equals(<String, dynamic>{'FixSpaces': false, 'MaxEmptyLines': 2}));
                }
            );

            test('Accepts an empty object', ()
                {
                    expect(ConfigValidator.parse('{}', defaults), isEmpty);
                }
            );

            test('Rejects invalid JSON', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"FixSpaces": ', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', contains('not valid JSON')))
                    );
                }
            );

            test('Rejects JSON that is not an object', ()
                {
                    expect(
                        () => ConfigValidator.parse('[1, 2]', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', contains('must be a JSON object')))
                    );
                }
            );

            test('Rejects a camelCase option name and suggests the PascalCase one', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"indentationSpacesPerLevel": 2}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', allOf(
                            contains('Unknown option "indentationSpacesPerLevel"'),
                            contains('Did you mean "IndentationSpacesPerLevel"?'),
                            contains('case-sensitive PascalCase')
                        )))
                    );
                }
            );

            test('Suggests the PascalCase name for a snake_case option name', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"fix_spaces": true}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', contains('Did you mean "FixSpaces"?')))
                    );
                }
            );

            test('Lists the valid options for an option name that resembles none of them', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"tabWidth": 2}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', allOf(
                            contains('Unknown option "tabWidth".'),
                            contains('Valid options: AddNewLineAfterClosingBrace'),
                            contains('RemoveTrailingCommas.')
                        )))
                    );
                }
            );

            test('Reports every problem at once', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"fixSpaces": true, "tabWidth": 2}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', allOf(
                            contains('Unknown option "fixSpaces"'),
                            contains('Unknown option "tabWidth"')
                        )))
                    );
                }
            );

            test('Rejects a non-boolean value for a boolean option', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"FixSpaces": "true"}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message',
                            contains('Option "FixSpaces" expects true or false but got the text "true".')))
                    );
                }
            );

            test('Rejects a non-integer value for an integer option', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"MaxEmptyLines": 1.5}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message',
                            contains('Option "MaxEmptyLines" expects a whole number but got 1.5.')))
                    );
                }
            );

            test('Rejects a null value', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"FixSpaces": null}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message',
                            contains('Option "FixSpaces" expects true or false but got null.')))
                    );
                }
            );

            test('Does not list the valid options when only a value type is wrong', ()
                {
                    expect(
                        () => ConfigValidator.parse('{"FixSpaces": 1}', defaults),
                        throwsA(isA<DartFormatException>().having((DartFormatException e) => e.message, 'message', isNot(contains('Valid options:'))))
                    );
                }
            );
        }
    );
}
