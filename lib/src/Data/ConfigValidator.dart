import 'dart:convert';

import '../Exceptions/DartFormatException.dart';

/// Checks the raw JSON of a configuration before it is deserialized.
///
/// json_serializable ignores keys it does not know, so a misspelled option -
/// most commonly a camelCase name instead of the PascalCase one - used to
/// format nothing at all without a word of explanation.
class ConfigValidator
{
    static final RegExp _NON_ALPHANUMERIC_PATTERN = RegExp('[^a-z0-9]');

    /// Decodes [jsonText] as a configuration object and checks it against [defaults].
    ///
    /// [defaults] is the JSON of a fully populated configuration: its keys are
    /// the known option names, its values carry the expected type per option.
    /// Throws a [DartFormatException] listing every problem found.
    static Map<String, dynamic> parse(String jsonText, Map<String, dynamic> defaults)
    {
        final Object? decoded = _decode(jsonText);

        if (decoded is! Map<String, dynamic>)
            throw DartFormatException.error('The configuration must be a JSON object, e.g. {"IndentationSpacesPerLevel": 2}.');

        final List<String> problems = <String>[];
        bool hasUnknownOption = false;

        for (final MapEntry<String, dynamic> entry in decoded.entries)
        {
            if (!defaults.containsKey(entry.key))
            {
                hasUnknownOption = true;
                final String? suggestion = _findSuggestion(entry.key, defaults.keys);
                problems.add(suggestion == null
                        ? 'Unknown option "${entry.key}".'
                        : 'Unknown option "${entry.key}". Did you mean "$suggestion"?');
                continue;
            }

            final Object? expectedValue = defaults[entry.key];
            if (expectedValue is bool && entry.value is! bool)
                problems.add('Option "${entry.key}" expects true or false but got ${_describeValue(entry.value)}.');
            else if (expectedValue is int && entry.value is! int)
                problems.add('Option "${entry.key}" expects a whole number but got ${_describeValue(entry.value)}.');
        }

        if (problems.isEmpty)
            return decoded;

        final StringBuffer message = StringBuffer('Invalid configuration:');
        for (final String problem in problems)
            message.write('\n  - $problem');

        if (hasUnknownOption)
            message.write('\n  Option names are case-sensitive PascalCase. Valid options: ${defaults.keys.join(', ')}.');

        throw DartFormatException.error(message.toString());
    }

    static Object? _decode(String jsonText)
    {
        try
        {
            return jsonDecode(jsonText);
        }
        on FormatException catch (e)
        {
            throw DartFormatException.error('The configuration is not valid JSON: ${e.message}');
        }
    }

    static String _describeValue(Object? value)
    {
        if (value == null)
            return 'null';

        if (value is String)
            return 'the text "$value"';

        if (value is List<dynamic>)
            return 'a list';

        if (value is Map<dynamic, dynamic>)
            return 'an object';

        return '$value';
    }

    /// Returns the known option name [unknownKey] was most likely meant to be,
    /// or null when it resembles none of them. Casing and separators are
    /// ignored, so `fixSpaces`, `fixspaces` and `fix_spaces` all point at
    /// `FixSpaces`.
    static String? _findSuggestion(String unknownKey, Iterable<String> knownKeys)
    {
        final String normalizedUnknownKey = _normalize(unknownKey);

        for (final String knownKey in knownKeys)
            if (_normalize(knownKey) == normalizedUnknownKey)
                return knownKey;

        return null;
    }

    static String _normalize(String s)
    => s.toLowerCase().replaceAll(_NON_ALPHANUMERIC_PATTERN, '');
}
