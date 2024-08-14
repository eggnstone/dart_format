String s =
    '''
    a'b
    ''';

String s =
    """
    a"b
    """;

void g()
{
    final String s = ''' ${true ? ''' ''' : ''' '''} ''';
    final String s2 =        '''        ''';
    final String s3 =        '''  //      ''';
}

void f()
{
    final String s = ''' ${true ? ''' ''' : '''
        //efault side'''
    } ''';
}
