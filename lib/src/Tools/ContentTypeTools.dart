class ContentTypeTools
{
    static const String BOUNDARY = 'boundary';
    static const String CHARSET = 'charset';

    static String? getBoundary(String? contentType)
    => get(contentType, BOUNDARY);

    static String? getCharset(String? contentType)
    => get(contentType, CHARSET);

    /// Returns the parameter value for [key] from a HTTP header like
    /// `multipart/form-data; boundary=----X` or `form-data; name="Config"`.
    /// The key match is case-insensitive (HTTP parameter names are tokens);
    /// surrounding double-quotes are stripped from the value.
    static String? get(String? contentType, String key)
    {
        if (contentType == null || contentType.isEmpty)
            return null;

        final List<String> parts = contentType.split(';');
        if (parts.length < 2)
            return null;

        final String fullKey = '${key.toLowerCase()}=';
        for (int i = 1; i < parts.length; i++)
        {
            final String part = parts[i].trim();
            if (!part.toLowerCase().startsWith(fullKey))
                continue;

            String value = part.substring(fullKey.length).trim();
            if (value.length >= 2 && value.startsWith('"') && value.endsWith('"'))
                value = value.substring(1, value.length - 1);

            return value;
        }

        return null;
    }
}
