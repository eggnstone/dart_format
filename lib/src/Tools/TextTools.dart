import '../Data/Config.dart';

class TextTools
{
    final Config config;

    TextTools(this.config);

    String addNewLineAtEndOfText(String s)
    {
        if (!config.addNewLineAtEndOfText || s.endsWith('\n'))
            return s;

        return '$s\n';
    }

    String removeEmptyLines(String s)
    {
        if (config.maxEmptyLines < 0)
            return s;

        final List<String> lines = s.split('\n');
        final StringBuffer sb = StringBuffer();

        int emptyLines = 0;
        for (int i = 0; i < lines.length; i++)
        {
            final String line = lines[i];
            if (line.trim().isEmpty)
            {
                emptyLines++;
                if (emptyLines <= config.maxEmptyLines)
                    if (i < lines.length - 1)
                        sb.write('\n');
            }
            else
            {
                emptyLines = 0;
                sb.write(line);
                if (i < lines.length - 1)
                    sb.write('\n');
            }
        }

        return sb.toString();
    }

    static String removeTrailingSpaces(String s)
    {
        String result = s;

        while (result.endsWith(' '))
            result = result.substring(0, result.length - 1);

        return result;
    }

    /// Runs the full blank-line pipeline on [s]: collapses long runs of empty
    /// lines per [Config.maxEmptyLines], strips blank lines at the file edges and
    /// adjacent to any `{` or `}`, and ensures the file ends with a single newline
    /// (per [Config.addNewLineAtEndOfText]). The user opts out of the
    /// [Config.maxEmptyLines]-gated parts by setting `maxEmptyLines: -1`.
    String tidyBlankLines(String s)
    {
        String result = removeEmptyLines(s);

        if (config.maxEmptyLines >= 0)
        {
            result = _removeBlankLinesAtStartOfFile(result);
            result = _removeBlankLinesAdjacentToBraces(result);
            result = _removeBlankLinesAtEndOfFile(result);
        }

        return addNewLineAtEndOfText(result);
    }

    /// Drops blank lines after every `{` and before every `}`. The indentation
    /// preceding the closing `}` is preserved.
    String _removeBlankLinesAdjacentToBraces(String s)
    {
        // Remove blank lines after every `{`.
        final String result = s.replaceAll(RegExp(r'\{\n(?:[ \t]*\n)+'), '{\n');

        // Remove blank lines before every `}`.
        return result.replaceAllMapped(
            RegExp(r'\n(?:[ \t]*\n)+([ \t]*\})'),
            (Match m) => '\n${m.group(1)}'
        );
    }

    /// Drops all blank lines that sit at the end of the file, keeping just the
    /// final newline (if one is present).
    String _removeBlankLinesAtEndOfFile(String s)
    => s.replaceFirst(RegExp(r'\n(?:[ \t]*\n)+$'), '\n');

    /// Drops every blank line at the start of the file.
    String _removeBlankLinesAtStartOfFile(String s)
    => s.replaceFirst(RegExp(r'^(?:[ \t]*\n)+'), '');
}
