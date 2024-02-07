// ignore_for_file: avoid_print

import 'package:dart_format/dart_format.dart';

void main(List<String> arguments)
{
    const String unformattedText = 'class C{void m(){print("Hello world");}}';
    print('Unformatted text:\n$unformattedText\n');

    const Config config = Config.all();
    final Formatter formatter = Formatter(config);
    final String formattedText = formatter.format(unformattedText);
    print('Formatted text:\n$formattedText\n');
}
