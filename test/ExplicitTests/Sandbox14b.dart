String s = '''${true ? '''}''' : '''No default side'''}''';

String s = 'a'
    '''
    a
    b
    ${true ? '''}''' : '''No default side'''}
    ''';
