class TestParameters
{
    static final Set<bool> bools = <bool>{false, true};

    static final Set<String> comments = <String>
    {
    '/**/',
    '/**//**/',
    '/*Comment*/',
    '/*Comment1*//*Comment2*/',
    '//\n',
    '//Comment\n',
    '//Comment1\n//Comment2\n'
    };
}
