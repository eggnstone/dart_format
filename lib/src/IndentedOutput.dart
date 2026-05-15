// ignore_for_file: always_put_control_body_on_new_line

import 'Constants/Constants.dart';
import 'Data/Indentation.dart';
import 'Enums/IndentationType.dart';
import 'StringBufferEx.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';

class IndentedOutput
{
    // ignore: non_constant_identifier_names
    static final RegExp BLANK_LINE_REG_EXP = RegExp(r'\n\s+\n');

    final int _indentationSpacesPerLevel;

    final List<StringBufferEx> _textBuffers = <StringBufferEx>[StringBufferEx()];
    final List<Indentation> _indentations = <Indentation>[];
    final List<int?> _customIndentSizes = <int?>[];

    IndentedOutput(this._indentationSpacesPerLevel);

    StringBufferEx get lastStringBuffer => _textBuffers.last;

    String get lastText => _textBuffers.last.lastText;

    int get levelCount => _indentations.length;

    String getResult()
    {
        if (_textBuffers.length == 1)
            return _textBuffers.last.toString();

        final StringBuffer sb = StringBuffer();
        for (final StringBufferEx textBuffer in _textBuffers)
            sb.write(textBuffer.toString());

        return sb.toString();
    }

    String getResultAfterLast(String searchText)
    {
        for (int i = _textBuffers.length - 1; i >= 0; i--)
        {
            final String text = _textBuffers[i].toString();
            final int lastPos = text.lastIndexOf(searchText);
            if (lastPos == -1)
                continue;

            final StringBuffer sb = StringBuffer();
            sb.write(text.substring(lastPos + searchText.length));
            for (int j = i + 1; j < _textBuffers.length; j++)
            {
                sb.write('<New-Level/>');
                sb.write(_textBuffers[j].toString());
            }

            return sb.toString();
        }

        return '';
    }

    /// Returns complete string if no line break found
    String getResultAfterOptionalLastLineBreak()
    {
        const String METHOD_NAME = 'getResultAfterOptionalLastLineBreak';
        final String lastText = _textBuffers.last.toString();
        final int lastPos = lastText.lastIndexOf('\n');
        final String r = lastPos == -1 ? lastText : lastText.substring(lastPos + 1);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: ${StringTools.toDisplayString(r)}');
        return r;
    }

    /// Returns empty string if no line break found
    String getResultAfterRequiredLastLineBreak()
    {
        const String METHOD_NAME = 'getResultAfterRequiredLastLineBreak';
        final String lastText = _textBuffers.last.toString();
        final int lastPos = lastText.lastIndexOf('\n');
        final String r = lastPos == -1 ? '' : lastText.substring(lastPos + 1);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: ${StringTools.toDisplayString(r)}');
        return r;
    }

    void popLevelAndIndent()
    {
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# IndentedOutput.popLevelAndIndent()');

        final Indentation lastLevel = _indentations.removeLast();
        final int? customIndentSize = _customIndentSizes.removeLast();
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  Popped level: name: "${lastLevel.name}" type: "${lastLevel.type}" customIndentSize: $customIndentSize');

        final StringBufferEx poppedStringBuffer = _textBuffers.removeLast();
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  Popped StringBuffer: lastText: ${StringTools.toDisplayString(poppedStringBuffer.lastText)}');
            logInternal('  Popped StringBuffer: allText:  ${StringTools.toDisplayString(poppedStringBuffer.toString())}');
        }

        if (_indentationSpacesPerLevel < 0)
        {
            _textBuffers.last.write(poppedStringBuffer);
            return;
        }

        final bool previousTextEndsWithNewLine = _textBuffers.last.lastText.endsWith('\n');
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  previousTextEndsWithNewLine: $previousTextEndsWithNewLine');
        String s = (previousTextEndsWithNewLine ? '\n' : '') + poppedStringBuffer.toString();
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  s: ${StringTools.toDisplayString(s)}');

        final int effectiveIndentSize = customIndentSize ?? _indentationSpacesPerLevel;
        String indent = '';
        if (lastLevel.type == IndentationType.single)
        {
            if (!s.trim().startsWith('{'))
                indent = StringTools.spaces(effectiveIndentSize);
        }
        else if (lastLevel.type == IndentationType.multiple)
        {
            indent = StringTools.spaces(effectiveIndentSize);
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  indent:      ${StringTools.toDisplayString(indent)}');
        final bool endsWithNewLine = s.endsWith('\n');
        if (endsWithNewLine)
            s = s.substring(0, s.length - 1);

        s = s.replaceAll('\n', '\n$indent');
        s = s.replaceAll(BLANK_LINE_REG_EXP, '\n\n');

        if (endsWithNewLine)
            s += '\n';

        if (previousTextEndsWithNewLine)
            s = s.substring(1);

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  indentedText: ${StringTools.toDisplayString(s)}');
        _textBuffers.last.write(s);
    }

    void pushLevel(String name, [IndentationType type = IndentationType.single, int? customIndentSize])
    {
        if (Constants.DEBUG_FORMAT_STATE)
            logInternal('# IndentedOutput.pushLevel(name: "$name", type: "$type", customIndentSize: $customIndentSize)');

        _indentations.add(Indentation(name: name, type: type));
        _customIndentSizes.add(customIndentSize);
        _textBuffers.add(StringBufferEx(lastText: _textBuffers.last.lastText));
    }

    void write(String s)
    {
        _textBuffers.last.write(s);
    }
}
