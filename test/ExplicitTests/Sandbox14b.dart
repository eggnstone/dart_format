String s = '''${true ? '''}''' : '''No default side'''}''';

String s2 = 'a\n'
    '''
        b
    c
    ${true ? '''}''' : '''No default side'''}
    ''';

String s3 = '''a
        b    
''';

String s4 = ''
    '''a
        b    
''';

String s5 = ''
    r'''a
        b    
''';

String s5 = 'a$b$c';
String s5 = 'a $b $c';

void f()
{
    String s = ''
        r'''a
            b    
''';
}

void main()
{
    print(s3);
}

void _fallbackToManual(String error)
{
    web.document.body!.appendHtml('''
a
$b

<p>Choose one of the following benchmarks:</p>

<!-- Absolutely position it so it receives the clicks and not the glasspane -->
<ul style="position: absolute">
${
        benchmarks.keys
            .map((String name) => '<li><button id="$name">$name</button></li>')
            .join('\n')
        }
</ul>
</div>
''');
}

String s10 = '''
<div id="manual-panel">
<h3>$error</h3>

<p>Choose one of the following benchmarks:</p>

<!-- Absolutely position it so it receives the clicks and not the glasspane -->
<ul style="position: absolute">
${
benchmarks.keys
    .map((String name) => '<li><button id="$name">$name</button></li>')
    .join('\n')
}
</ul>
</div>
''';
