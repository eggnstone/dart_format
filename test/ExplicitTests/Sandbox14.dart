String s = '''${true ? '''}''' : '''b'''}''';

String s =
    '''
    ${true ? '''
        });''' : '''
        // No default side'''}
    ''';

String s = '''${true ? '''});''' : '''// No default side'''}''';
