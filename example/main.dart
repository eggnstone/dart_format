// ignore_for_file: avoid_print

import 'package:dart_format/dart_format.dart';

void main(List<String> arguments)
{
    const String unformattedText = 'class C{void m(){print("Hello world");}}';
    print('Unformatted text:');
    print('$unformattedText\n');

    const Config config = Config.all();
    final Formatter formatter = Formatter(config);
    final String formattedText = formatter.format(unformattedText);
    print('Formatted text:');
    print(formattedText);
}

/*
Output:

Unformatted text:
class C{void m(){print("Hello world");}}

Formatted text:
class C
{
    void m()
    {
        print("Hello world");
    }
}
*/
