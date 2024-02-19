import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/source/line_info.dart';

import 'Config.dart';
import 'Constants/Constants.dart';
import 'Data/Indentation.dart';
import 'Exceptions/DartFormatException.dart';
import 'StringBufferEx.dart';
import 'Tools/FormatTools.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/IndentationType.dart';

class FormatState
{
    final int _indentationSpacesPerLevel;
    final ParseStringResult _parseResult;
    final bool _removeTrailingCommas;

    final List<StringBufferEx> _textBuffers = <StringBufferEx>[StringBufferEx()];
    final List<Indentation> _indentations = <Indentation>[];

    int _lastConsumedPosition = 0;
    String? _trailingForTests;

    int logIndent = 0;

    CompilationUnit get compilationUnit
    => _parseResult.unit;

    int get lastConsumedPosition
    => _lastConsumedPosition;

    FormatState(
        ParseStringResult parseResult,         {
            required int indentationSpacesPerLevel,
            required bool removeTrailingCommas}
    )
        : _indentationSpacesPerLevel = indentationSpacesPerLevel,
        _removeTrailingCommas = removeTrailingCommas,
        _parseResult = parseResult;

    factory FormatState.test(ParseStringResult parseResult, {
            required int indentationSpacesPerLevel, String? leading,
            String? trailing})
    => FormatState(parseResult, indentationSpacesPerLevel: indentationSpacesPerLevel, removeTrailingCommas : true)
    .._lastConsumedPosition = leading?.length ?? 0
    .._trailingForTests = trailing;

    void acceptListWithPeriod(List<AstNode> nodes, AstVisitor<void> astVisitor, String source)
    {
        AstNode? lastNode;
        for (final AstNode node in nodes)
        {
            if (lastNode != null)
            {
                final String periodText = getText(lastNode.end, node.offset);
                if (!FormatTools.isPeriodText(periodText))
                    throw DartFormatException.error('periodText is not a period: ${StringTools.toDisplayString(periodText)}');

                consumeText(lastNode.end, node.offset, periodText, '$source/Period');
            }

            node.accept(astVisitor);
            lastNode = node;
        }
    }

    void acceptList(List<AstNode> nodes, AstVisitor<void> astVisitor, String source)
    {
        _log('# FormatState.acceptList($source)');
        // ignore: avoid_function_literals_in_foreach_calls
        nodes.forEach((AstNode node) => node.accept(astVisitor));
    }

    void acceptListWithComma(NodeList<AstNode> nodes, Token? endToken, AstVisitor<void> astVisitor, String source)
    {
        AstNode? lastNode;
        for (final AstNode node in nodes)
        {
            if (lastNode != null)
            {
                // This part is necessary for situations like "} ,\nXYZ"
                int end = lastNode.end;
                if (_lastConsumedPosition > end)
                {
                    final String filler = getText(lastNode.end, _lastConsumedPosition);
                    //logInternal('filler/1: ${StringTools.toDisplayString(filler)}');
                    if (filler.trim().isNotEmpty)
                        throw DartFormatException.error('filler is not empty: ${StringTools.toDisplayString(filler)}');
                    end = _lastConsumedPosition;
                }

                final String commaText = getText(end, node.offset);
                if (!FormatTools.isCommaText(commaText))
                    throw DartFormatException.error('commaText is not a comma: ${StringTools.toDisplayString(commaText)}');

                consumeText(end, node.offset, commaText, '$source/Comma');
            }

            node.accept(astVisitor);
            lastNode = node;
        }

        // Check for trailing comma
        if (lastNode != null)
        {
            final AstNode? parentNode = lastNode.parent;
            if (parentNode == null)
                throw DartFormatException.error('parentNode is null');

            if (endToken != null)
            {
                String commaText = getText(lastNode.end, endToken.offset);
                //logInternal('commaText/2 ${StringTools.toDisplayString(commaText)}');
                if (FormatTools.isCommaText(commaText))
                {
                    if (_removeTrailingCommas)
                        commaText = commaText.replaceFirst(',', '${Constants.REMOVE_START},${Constants.REMOVE_END}');

                    consumeText(lastNode.end, endToken.offset, commaText, '$source/TrailingComma');
                }
            }
        }
    }

    void addNewLineAfterToken(Token? token, String source, {required bool add})
    {
        const String methodName = 'addNewLineAfterToken';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(add=$add, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');
        //_log('  sb: ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');

        if (token == null || !add)
            return;

        final Token? nextToken = token.next;
        if (nextToken == null)
        {
            //addText('\n', fullSource);
            return;
        }

        final int end = nextToken.offset;
        /*if (nextToken.precedingComments != null)
        end = nextToken.precedingComments!.offset;*/

        final String filler = getText(token.end, end);
        _log('  token:                              ${StringTools.toDisplayString(token)}');
        _log('  nextToken:                          ${StringTools.toDisplayString(nextToken)}');
        _log('  nextToken.offset:                   ${nextToken.offset}');
        _log('  nextToken.precedingComments:        ${nextToken.precedingComments}');
        _log('  nextToken.precedingComments.offset: ${nextToken.precedingComments?.offset}');
        _log('  filler/2:                           ${StringTools.toDisplayString(filler)}');

        final int pos = filler.indexOf('\n');
        _log('  pos:       $pos');
        if (pos >= 0)
            return;

        if (nextToken.offset == _parseResult.content.length)
        {
            // EOF
            consumeText(token.end, nextToken.offset, filler, fullSource);
            _addNewLineBeforeToken(nextToken, add: add, beforeComments: false, fullSource);
            return;
        }

        _addNewLineBeforeToken(nextToken, add: add, beforeComments: true, fullSource);
    }

    void _addNewLineBeforeToken(Token? token, String source, {required bool add, required bool beforeComments})
    {
        const String methodName = 'addNewLineBeforeToken';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(add=$add, beforeComments=$beforeComments, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');
        //_log('  sb: ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');
        //_log('  sb.lastText: ${StringTools.toDisplayString(getLastText())}');

        if (token == null || !add)
            return;

        /*int end = token.offset;
        if (token.precedingComments != null)
        end = token.precedingComments!.offset;*/

        if (lastConsumedPosition > token.offset)
            _logAndThrowError('lastConsumedPosition > token.offset');

        if (getLastText().endsWith('\n'))
        {
            _log('  Skipping line break because already in SB.');
            return;
        }

        if (lastConsumedPosition == token.offset)
        {
            _log('  Adding line break because no upcoming filler / not already in SB.');
            addText('\n', fullSource);
            return;
        }

        final int end = beforeComments ? token.precedingComments?.offset ?? token.offset : token.offset;
        _log('  lastConsumedPosition:            $lastConsumedPosition');
        _log('  token.precedingComments:         ${token.precedingComments}');
        _log('  token.precedingComments?.offset: ${token.precedingComments?.offset}');
        _log('  token.offset:                    ${token.offset}');
        _log('  end:                             $end');

        final String filler = lastConsumedPosition >= end ? '' : getText(lastConsumedPosition, end);
        _log('  filler/3:                        ${StringTools.toDisplayString(filler)}');

        if (filler.startsWith('\n'))
        {
            _log('  Skipping line break because already in upcoming combined filler.');
            return;
        }

        if (filler.trim().isNotEmpty)
            _logAndThrowError('Internal error: Upcoming trimmed filler is not empty/whitespace-only: ${StringTools.toDisplayString(filler)}');

        _log('  Replacing empty or whitespace-only filler with line break because upcoming filler does not contain line break.');
        consumeText(lastConsumedPosition, end, '', fullSource);
        addText('\n', fullSource);
    }

    void addText(String s, String source)
    {
        const String methodName = 'addText';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        consumeText(lastConsumedPosition, lastConsumedPosition, s, fullSource);
    }

    void consumeText(int offset, int end, String s, String source)
    {
        const String methodName = 'consumeText';
        final String fullSource = '$source/$methodName';
        _log('# $methodName($offset, $end, ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (offset < lastConsumedPosition)
            _logAndThrowError('offset < lastConsumedPosition:'
                ' $offset (${getPositionInfo(offset)}) < $lastConsumedPosition (${getPositionInfo(lastConsumedPosition)})'
                ' ($source)');

        if (lastConsumedPosition < offset)
        {
            final String filler = getText(lastConsumedPosition, offset);

            _log('  filler/4:             ${StringTools.toDisplayString(filler)}');
            _log('  lastConsumedPosition: $lastConsumedPosition');
            _log('  offset:               $offset');
            _log('  Current:              ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');

            if (!FormatTools.isEmptyOrComments(filler))
                _logAndThrowError('Missed some text: (${getPositionInfo(lastConsumedPosition)}) - (${getPositionInfo(offset)}): ${StringTools.toDisplayString(filler, 100)} Source: $source');

            final String fixedFiller = _removeLeadingWhitespace(filler);
            _log('  Filler w/o leadingWS: ${StringTools.toDisplayString(fixedFiller)}');
            _log('+ ${StringTools.toDisplayString(fixedFiller, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
            write(fixedFiller);
        }
        else
            _log('  No filler');

        _log('+ ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
        final String fixedS = _removeLeadingWhitespace(s);
        _log('  S w/o leading ws:     ${StringTools.toDisplayString(fixedS)}');
        write(fixedS);

        _setLastConsumedPosition(end, fullSource);
    }

    void consumeTill(int end, String source)
    {
        const String methodName = 'consumeTill';
        final String fullSource = '$source/$methodName';
        _log('# $methodName($end, $source)');

        if (lastConsumedPosition >= end)
            return;

        String filler = getText(lastConsumedPosition, end);
        _log('  filler/5:                  ${StringTools.toDisplayString(filler)}');

        if (_trailingForTests != null && filler.endsWith(_trailingForTests!))
        {
            filler = filler.substring(0, filler.length - _trailingForTests!.length);
            _log('  Filler (without trailing): ${StringTools.toDisplayString(filler)}');
        }

        if (!FormatTools.isEmptyOrComments(filler))
        {
            _log('  Current:                   ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');
            _logAndThrowError('Missed some text: (${getPositionInfo(lastConsumedPosition)}) - (${getPositionInfo(end)}): ${StringTools.toDisplayString(filler, 100)} Source: $source');
        }

        _log('+ ${StringTools.toDisplayString(filler, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
        write(filler);

        _setLastConsumedPosition(end, fullSource);
    }

    void consumeTillTheEnd(String source)
    => consumeTill(_parseResult.unit.end, source);

    void copyClosingBraceAndPopLevel(Token token, Config config, String source)
    => copyToken(token, source,
        addNewLineBefore: config.addNewLineBeforeClosingBrace,
        addNewLineAfter: config.addNewLineAfterClosingBrace,
        popLevel: true
    );

    void copySemicolon(Token? token, Config config, String source)
    {
        if (token == null)
            return;

        copyToken(token, source,
            addNewLineBefore: false,
            addNewLineAfter: config.addNewLineAfterSemicolon
        );
    }

    void copyEntity(SyntacticEntity? entity, AstVisitor<void> astVisitor, String source)
    {
        const String methodName = 'copyEntity';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(${StringTools.toDisplayString(entity, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (entity == null)
            _log('+ <null> ($fullSource)');
        else if (entity is AstNode)
            entity.accept(astVisitor);
        else
            copyText(entity.offset, entity.end, fullSource);
    }

    void copyOpeningBraceAndPushLevel(Token token, Config config, String source)
    => copyToken(token, source,
        addNewLineBefore: config.addNewLineBeforeOpeningBrace,
        addNewLineAfter: config.addNewLineAfterOpeningBrace,
        pushLevel: true
    );

    void copyText(int offset, int end, String source)
    {
        const String methodName = 'copyText';
        final String fullSource = '$source/$methodName';
        _log('# $methodName($offset, $end, $source)');

        final String s = getText(offset, end);
        consumeText(offset, end, s, fullSource);
    }

    void copyToken(Token token, String source, {
            required bool addNewLineBefore,
            required bool addNewLineAfter,
            bool pushLevel = false,
            bool popLevel = false
        })
    {
        const String methodName = 'copyToken';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, addNewLineBefore=$addNewLineBefore, addNewLineAfter=$addNewLineAfter, pushLevel: $pushLevel, popLevel: $popLevel, $source)');

        _copyTokenCommentsOnly(token, fullSource);
        _addNewLineBeforeToken(token, add: addNewLineBefore, beforeComments: false, fullSource);

        if (popLevel)
            popLevelAndIndent();

        _copyTokenWithoutComments(token, fullSource);
        addNewLineAfterToken(token, add: addNewLineAfter, fullSource);

        if (pushLevel)
            this.pushLevel(fullSource, IndentationType.multiple);
    }

    void _copyTokenCommentsOnly(Token? token, String source)
    {
        const String methodName = 'copyTokenCommentsOnly';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            _log('+ <null> ($fullSource)');
            return;
        }

        Token? commentToken = token.precedingComments;
        final int? commentsOffset = commentToken?.offset;
        int? commentsEnd = commentToken?.end;
        while (commentToken != null)
        {
            commentsEnd = commentToken.end;
            commentToken = commentToken.next;
        }

        if (commentsOffset == null || commentsEnd == null)
        {
            _log('+ <no comments> ($fullSource)');
            return;
        }

        copyText(commentsOffset, commentsEnd, fullSource);
    }

    void _copyTokenWithoutComments(Token? token, String source)
    {
        const String methodName = 'copyTokenWithoutComments';
        final String fullSource = '$source/$methodName';
        _log('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            _log('+ <null> ($fullSource)');
            return;
        }

        Token? commentToken = token.precedingComments;
        int? end = commentToken?.end;
        while (commentToken != null)
        {
            end = commentToken.end;
            commentToken = commentToken.next;
        }

        if (end == null)
        {
            copyText(token.offset, token.end, fullSource);
            return;
        }

        copyText(end, token.end, fullSource);
    }

    String getLastText()
    => _textBuffers.last.lastText;

    String getPositionInfo(int offset)
    {
        try
        {
            final CharacterLocation location = _parseResult.lineInfo.getLocation(offset);
            final int line = location.lineNumber;
            final int column = location.columnNumber;
            return 'Line $line, column $column';
        }
        // ignore: avoid_catching_errors
        on UnimplementedError catch (_)
        {
            // TestParseStringResult will throw an UnimplementedError.
            return 'Offset $offset';
        }
    }

    String getResult()
    {
        if (_textBuffers.length == 1)
            return _textBuffers.last.toString();

        final StringBuffer sb = StringBuffer();
        for (final StringBufferEx textBuffer in _textBuffers)
            sb.write(textBuffer.toString());

        return sb.toString();
    }

    String getText(int offset, int end)
    {
        try
        {
            return _parseResult.content.substring(offset, end);
        }
        catch(e)
        {
            logInternal('FormatState.getText($offset, $end) $e');
            logInternal('  ${StringTools.toDisplayString(_parseResult.content)}');
            rethrow;
        }
    }

    void popLevelAndIndent()
    {
        _log('# FormatState.popLevelAndIndent()');

        final Indentation lastLevel = _indentations.removeLast();
        _log('  Popped Level: name: "${lastLevel.name}" type: "${lastLevel.type}"');

        final StringBufferEx poppedStringBuffer = _textBuffers.removeLast();
        _log('  Popped StringBuffer: lastText: ${StringTools.toDisplayString(poppedStringBuffer.lastText)}');
        _log('  Popped StringBuffer: allText:  ${StringTools.toDisplayString(poppedStringBuffer.toString())}');

        if (_indentationSpacesPerLevel < 0)
        {
            _textBuffers.last.write(poppedStringBuffer);
            return;
        }

        final bool previousTextEndsWithNewLine = _textBuffers.last.lastText.endsWith('\n');
        _log('  previousTextEndsWithNewLine: $previousTextEndsWithNewLine');
        String s = (previousTextEndsWithNewLine ? '\n' : '') + poppedStringBuffer.toString();
        _log('  s: ${StringTools.toDisplayString(s)}');

        String indentation = '';
        if (lastLevel.type == IndentationType.single)
        {
            if (!s.trim().startsWith('{'))
                indentation = ' ' * _indentationSpacesPerLevel;
        }
        else if (lastLevel.type == IndentationType.multiple)
        {
            indentation = ' ' * _indentationSpacesPerLevel;
        }

        _log('  indentation: ${StringTools.toDisplayString(indentation)}');
        final bool endsWithNewLine = s.endsWith('\n');
        if (endsWithNewLine)
            s = s.substring(0, s.length - 1);

        s = s.replaceAll('\n', '\n$indentation');
        s = s.replaceAll(RegExp('\n\\s+\n'), '\n\n');

        if (endsWithNewLine)
            s += '\n';

        if (previousTextEndsWithNewLine)
            s = s.substring(1);

        _log('  indentedText: ${StringTools.toDisplayString(s)}');
        _textBuffers.last.write(s);
    }

    void pushLevel(String name, IndentationType type)
    {
        _log('# FormatState.pushLevel(name: "$name", type: "$type")');
        //_log('  lastText: ${StringTools.toDisplayString(_textBuffers.last.lastText)}');
        //_log('  allText:  ${StringTools.toDisplayString(_textBuffers.last)}');
        _indentations.add(Indentation(name: name, type: type));
        _textBuffers.add(StringBufferEx(lastText: _textBuffers.last.lastText));
    }

    void write(String s)
    {
        _textBuffers.last.write(s);
        _log('= ${StringTools.toDisplayString(getResult())}');
    }

    void _log(String s)
    {
        if (Constants.DEBUG_FORMAT_STATE)
            logInternal(s);
    }

    void _logError(String s)
    {
        logInternalError(s);
    }

    void _setLastConsumedPosition(int value, String source)
    {
        if (value < _lastConsumedPosition)
            _logAndThrowError('FormatState:_setLastConsumedPosition: value < _lastConsumedPosition: $value < $_lastConsumedPosition ($source)');

        _lastConsumedPosition = value;
    }

    void _logAndThrowError(String message)
    {
        _logError(message);
        throw DartFormatException.error(message);
    }

    String _removeLeadingWhitespace(String s)
    {
        if (_indentationSpacesPerLevel< 0)
            return s;

        return StringTools.removeLeadingWhitespace(s);
    }
}
