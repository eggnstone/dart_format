class ContentTypeTools
{
    static const String BOUNDARY = 'boundary';
    static const String CHARSET = 'charset';

    static String? getBoundary(String? contentType)
    => get(contentType, BOUNDARY);

    static String? getCharset(String? contentType)
    => get(contentType, CHARSET);

    static String? get(String? contentType, String key)
    {
        final String fullKey = '$key=';

        if (contentType == null || contentType.isEmpty)
            return null;

        final List<String> parts = contentType.split(';');
        if (parts.length < 2)
            return null;

        for (int i = 1; i < parts.length; i++)
        {
            final String part = parts[i].trim();
            if (part.startsWith(fullKey))
                return part.substring(fullKey.length).trim();
        }

        return null;
    }
}
