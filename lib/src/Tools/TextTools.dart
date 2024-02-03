import '../Config.dart';

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
        //logDebug('removeEmptyLines: config.maxEmptyLines: ${config.maxEmptyLines}');

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
}
