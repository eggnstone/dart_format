String s = '''${true ? '''}''' : '''No default side'''}''';

String s2 = 'a\n'
    '''
        b
    c
    ${true ? '''}''' : '''No default side'''}
    ''';

String s3 =
    '''a
        b    
    ''';

String s4 = ''
    '''a
        b    
    ''';

void main()
{
    print(s3);
}
