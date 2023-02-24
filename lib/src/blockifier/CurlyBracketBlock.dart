import 'Block.dart';

class CurlyBracketBlock implements Block
{
    final String text;

    const CurlyBracketBlock(this.text);

    @override
    String toString()
    => 'CurlyBracketBlock("$text")';
}
