// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/source/line_info.dart';

import 'Constants/Constants.dart';
import 'Data/Config.dart';
import 'Data/Indentation.dart';
import 'Exceptions/DartFormatException.dart';
import 'LeadingWhitespaceRemover.dart';
import 'StringBufferEx.dart';
import 'Tools/CommentTools.dart';
import 'Tools/FormatTools.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';
import 'Types/IndentationType.dart';

class FormatState
{
    final int _indentationSpacesPerLevel;
    final DateTime _maxDateTime;
    final ParseStringResult _parseResult;
    final bool _removeTrailingCommas;
    final DateTime _startDateTime;

    final List<StringBufferEx> _textBuffers = <StringBufferEx>[StringBufferEx()];
    final List<Indentation> _indentations = <Indentation>[];

    int _lastConsumedPosition = 0;
    String? _trailingForTests;

    int logIndent = 0;

    CompilationUnit get compilationUnit => _parseResult.unit;

    int get lastConsumedPosition => _lastConsumedPosition;

    DateTime get maxDateTime => _maxDateTime;

    DateTime get startDateTime => _startDateTime;

    FormatState(
        ParseStringResult parseResult, {
            required int indentationSpacesPerLevel,
            required DateTime maxDateTime,
            required bool removeTrailingCommas,
            required DateTime startDateTime
        }
    )
        : _indentationSpacesPerLevel = indentationSpacesPerLevel,
        _maxDateTime = maxDateTime,
        _removeTrailingCommas = removeTrailingCommas,
        _parseResult = parseResult,
        _startDateTime = startDateTime;

    factory FormatState.test(ParseStringResult parseResult, {
            required int indentationSpacesPerLevel, 
            required bool removeTrailingCommas,
            String? leading,
            String? trailing
        }
    )
    {
        final DateTime startDateTime = DateTime.now();
        final DateTime maxDateTime = startDateTime.add(const Duration(seconds: Constants.MAX_FORMAT_TIME_IN_SECONDS_FOR_TESTS));
        return FormatState(
            parseResult,
            indentationSpacesPerLevel: indentationSpacesPerLevel,
            maxDateTime: maxDateTime,
            removeTrailingCommas : removeTrailingCommas,
            startDateTime: startDateTime
        )
            .._lastConsumedPosition = leading?.length ?? 0
            .._trailingForTests = trailing;
    }

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

    void acceptTokenListWithPeriod(List<Token> tokens, AstVisitor<void> astVisitor, String source)
    {
        Token? lastToken;
        for (final Token token in tokens)
        {
            if (lastToken != null)
            {
                final String periodText = getText(lastToken.end, token.offset);
                if (!FormatTools.isPeriodText(periodText))
                    throw DartFormatException.error('periodText is not a period: ${StringTools.toDisplayString(periodText)}');

                consumeText(lastToken.end, token.offset, periodText, '$source/Period');
            }

            copyToken(token, source, addNewLineBefore: false, addNewLineAfter: false);
            lastToken = token;
        }
    }

    void acceptList(List<AstNode> nodes, AstVisitor<void> astVisitor, String source)
    {
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# FormatState.acceptList($source)');
        // ignore: avoid_function_literals_in_foreach_calls
        nodes.forEach((AstNode node) => node.accept(astVisitor));
    }

    void acceptListWithComma(NodeList<AstNode> nodes, Token? endToken, AstVisitor<void> astVisitor, String source)
    {
        const String methodName = 'acceptListWithComma';

        AstNode? lastNode;
        for (final AstNode node in nodes)
        {
            if (lastNode != null)
            {
                // This part is necessary for situations like "} ,\nXYZ"
                int end = lastNode.end;
                if (lastConsumedPosition > end)
                {
                    final String filler = getText(lastNode.end, lastConsumedPosition);
                    //logInternal('filler/1: ${StringTools.toDisplayString(filler)}');
                    if (filler.trim().isNotEmpty)
                        throw DartFormatException.error('filler is not empty: ${StringTools.toDisplayString(filler)}');
                    end = lastConsumedPosition;
                }

                final String commaText = getText(end, node.offset);
                if (!FormatTools.isCommaText(commaText))
                    logAndThrowErrorWithOffsets('commaText is not a comma', '-', StringTools.toDisplayString(commaText), end, node.offset, source);

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

                    int adjustedLastNodeEnd = lastNode.end;
                    if (lastNode.end < lastConsumedPosition)
                    {
                        final String alreadyConsumedText = getText(lastNode.end, lastConsumedPosition);
                        if (Constants.DEBUG_TODOS) logDebug('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
                        if (CommentTools.isEmptyOrComments(alreadyConsumedText))
                        {
                            // TODO: test
                            // TODO: Find a better way!
                            adjustedLastNodeEnd = lastConsumedPosition;
                        }
                    }

                    // TODO: test
                    if (adjustedLastNodeEnd < endToken.offset)
                        consumeText(adjustedLastNodeEnd, endToken.offset, commaText, '$source/TrailingComma');
                    else
                        logWarning('Trailing comma text not consumed: adjustedLastNodeEnd < endToken.offset');
                }
            }
        }
    }

    void addNewLineAfterToken(Token? token, String source, {required bool add})
    {
        const String methodName = 'addNewLineAfterToken';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(add=$add, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('  sb: ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');

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
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  token:                              ${StringTools.toDisplayString(token)}');
            logInternal('  nextToken:                          ${StringTools.toDisplayString(nextToken)}');
            logInternal('  nextToken.offset:                   ${nextToken.offset}');
            logInternal('  nextToken.precedingComments:        ${StringTools.toDisplayString(nextToken.precedingComments)}');
            logInternal('  nextToken.precedingComments.offset: ${nextToken.precedingComments?.offset}');
            logInternal('  filler/2:                           ${StringTools.toDisplayString(filler)}');
        }

        final int lineBreakPos = filler.indexOf('\n');
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  lineBreakPos:                       $lineBreakPos');
        if (lineBreakPos >= 0)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  Line break already in filler => not adding line break');
            return;
        }

        // TODO: test
        if (nextToken.toString() == ';')
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  nextToken is ";" => not adding line break');
            return;
        }

        // TODO: test
        if (nextToken.toString() == ',')
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  nextToken is "," => not adding line break');
            return;
        }

        if (nextToken.offset == _parseResult.content.length)
        {
            // EOF
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  EOF');
            consumeText(token.end, nextToken.offset, filler, fullSource);
            _addNewLineBeforeToken(nextToken, add: add, beforeComments: false, fullSource);
            return;
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  Not EOF');
        _addNewLineBeforeToken(nextToken, add: add, beforeComments: true, fullSource);
    }

    void _addNewLineBeforeToken(Token? token, String source, {required bool add, required bool beforeComments})
    {
        const String methodName = 'addNewLineBeforeToken';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(add=$add, beforeComments=$beforeComments, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('  sb: ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('  sb.lastText: ${StringTools.toDisplayString(getLastText())}');

        if (token == null || !add)
            return;

        /*int end = token.offset;
        if (token.precedingComments != null)
        end = token.precedingComments!.offset;*/

        if (lastConsumedPosition > token.offset)
            logAndThrowErrorWithOffsets('Internal error: lastConsumedPosition > token.offset', '>', null, lastConsumedPosition, token.offset, source);

        if (getLastText().endsWith('\n'))
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  Skipping line break because already in SB.');
            return;
        }

        if (lastConsumedPosition == token.offset)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  Adding line break because no upcoming filler / not already in SB.');
            addText('\n', fullSource);
            return;
        }

        final int end = beforeComments ? token.precedingComments?.offset ?? token.offset : token.offset;
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  lastConsumedPosition:            $lastConsumedPosition');
            logInternal('  token.precedingComments:         ${token.precedingComments}');
            logInternal('  token.precedingComments?.offset: ${token.precedingComments?.offset}');
            logInternal('  token.offset:                    ${token.offset}');
            logInternal('  end:                             $end');
        }

        final String filler = lastConsumedPosition >= end ? '' : getText(lastConsumedPosition, end);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  filler/3:                        ${StringTools.toDisplayString(filler)}');

        if (filler.startsWith('\n'))
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  Skipping line break because already in upcoming combined filler.');
            return;
        }

        if (filler.trim().isNotEmpty)
            logAndThrowErrorWithOffset('Internal error: Upcoming trimmed filler is not empty/whitespace-only:', StringTools.toDisplayString(filler), lastConsumedPosition);

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  Replacing empty or whitespace-only filler with line break because upcoming filler does not contain line break.');
        consumeText(lastConsumedPosition, end, '', fullSource);
        addText('\n', fullSource);
    }

    void addText(String s, String source)
    {
        const String methodName = 'addText';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        consumeText(lastConsumedPosition, lastConsumedPosition, s, fullSource);
    }

    void consumeText(int offset, int end, String s, String source)
    {
        const String methodName = 'consumeText';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName($offset, $end, ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (lastConsumedPosition > offset)
            logAndThrowErrorWithOffsets('Internal error: offset < lastConsumedPosition:', '<', null, offset, lastConsumedPosition, source);

        if (lastConsumedPosition == offset)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  No filler');
        }
        else
        {
            final String filler = getText(lastConsumedPosition, offset);

            if (Constants.DEBUG_FORMAT_STATE)
            {
                logInternal('  filler/4a:            ${StringTools.toDisplayString(filler)}');
                logInternal('  lastConsumedPosition: $lastConsumedPosition');
                logInternal('  offset:               $offset');
                logInternal('  Result so far:        ${StringTools.toDisplayStringCutAtFront(getResult(), Constants.MAX_DEBUG_LENGTH)}');
            }

            if (!CommentTools.isEmptyOrComments(filler))
                logAndThrowErrorWithOffsets('Internal error: Missed some text:', '-', StringTools.toDisplayString(filler, 100), lastConsumedPosition, offset, source);

            if (Constants.DEBUG_FORMAT_STATE)
            {
                logInternal('  filler/4b:            ${StringTools.toDisplayString(filler)}');
                logInternal('  _textBuffers.last:    ${StringTools.toDisplayString(_textBuffers.last)}');
            }

            if (filler.replaceAll(' ', '').isEmpty && _textBuffers.length == 1 && _textBuffers.last.toString().isEmpty)
            {
                if (Constants.DEBUG_FORMAT_STATE) logInternal('  Skipping space-only filler');
            }
            else
            {
                final String fixedFiller = _removeLeadingWhitespace(filler, lastConsumedPosition);
                if (Constants.DEBUG_FORMAT_STATE)
                {
                    logInternal('  fixedFiller/4:    ${StringTools.toDisplayString(fixedFiller)}');
                    logInternal('+ ${StringTools.toDisplayString(fixedFiller, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
                }

                write(fixedFiller);
            }
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('+ ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
        final String fixedS = _removeLeadingWhitespace(s, offset);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  S w/o leading ws:          ${StringTools.toDisplayString(fixedS)}');
        write(fixedS);

        _setLastConsumedPosition(end, fullSource);
    }

    void consumeTill(int end, String source)
    {
        const String methodName = 'consumeTill';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName($end, $source)');

        if (lastConsumedPosition >= end)
            return;

        String filler = getText(lastConsumedPosition, end);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  filler/5:                  ${StringTools.toDisplayString(filler)}');

        if (_trailingForTests != null && filler.endsWith(_trailingForTests!))
        {
            filler = filler.substring(0, filler.length - _trailingForTests!.length);
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  filler (without trailing): ${StringTools.toDisplayString(filler)}');
        }

        if (!CommentTools.isEmptyOrComments(filler))
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  Result so far:             ${StringTools.toDisplayStringCutAtFront(getResult(), Constants.MAX_DEBUG_LENGTH)}');
            logAndThrowErrorWithOffsets('Internal error: Missed some text:', '-', StringTools.toDisplayString(filler, 100), lastConsumedPosition, end, source);
        }

        String lastText = _textBuffers.last.toString();
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  lastText1:                 ${StringTools.toDisplayString(lastText)}');

        final int lastLineBreakPos = lastText.lastIndexOf('\n');
        if (lastLineBreakPos >= 0)
        {
            lastText = lastText.substring(lastLineBreakPos + 1);
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  lastText2:                 ${StringTools.toDisplayString(lastText)}');
        }

        /*bool removeLeadingWhitespace = lastText.trim().isEmpty;
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  removeLeadingWhitespace:   $removeLeadingWhitespace');
        if (!removeLeadingWhitespace)
        {
            final String firstLine = filler.split('\n').first;
            removeLeadingWhitespace = firstLine.trim().isEmpty;
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  removeLeadingWhitespace:   $removeLeadingWhitespace');
        if (removeLeadingWhitespace)
        */

        /*if (true)
        {*/
        final String fixedFiller = _removeLeadingWhitespace(filler, lastConsumedPosition);
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  fixedFiller:               ${StringTools.toDisplayString(fixedFiller)}');
            logInternal('+ ${StringTools.toDisplayString(fixedFiller, Constants.MAX_DEBUG_LENGTH)} ($fullSource)');
        }

        write(fixedFiller);
        /*}
        else
        {
            write(filler);
        }*/

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

    /*void copyRawStringEntity(SyntacticEntity? entity, AstVisitor<void> astVisitor, String source)
    {
        const String methodName = 'copyRawStringEntity';

        if (entity is! Token)
            throw ArgumentError('Not a Token: ${entity.runtimeType}');

        if (entity.type != TokenType.STRING)
            throw ArgumentError('Not a string: ${entity.type}');

        if (Constants.DEBUG_FORMAT_STATE) logInternal('${entity.type}');
        if (Constants.DEBUG_FORMAT_STATE) logInternal('${entity.value()}');
        copyEntity(entity, astVisitor, source, isRaw: true);
    }*/

    void copyEntity(SyntacticEntity? entity, AstVisitor<void> astVisitor, String source)
    {
        const String methodName = 'copyEntity';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(entity, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (entity == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($fullSource)');
            return;
        }

        if (entity is AstNode)
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
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName($offset, $end, $source)');

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
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, addNewLineBefore=$addNewLineBefore, addNewLineAfter=$addNewLineAfter, pushLevel: $pushLevel, popLevel: $popLevel, $source)');

        _copyTokenCommentsOnly(token, fullSource);
        _addNewLineBeforeToken(token, add: addNewLineBefore, beforeComments: false, fullSource);

        if (popLevel)
            popLevelAndIndent();

        _copyTokenWithoutComments(token, fullSource);
        addNewLineAfterToken(token, add: addNewLineAfter, fullSource);

        if (pushLevel)
            this.pushLevel(fullSource);
    }

    void _copyTokenCommentsOnly(Token? token, String source)
    {
        const String methodName = 'copyTokenCommentsOnly';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($fullSource)');
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
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <no comments> ($fullSource)');
            return;
        }

        int adjustedCommentsOffset = commentsOffset;
        if (commentsOffset < lastConsumedPosition)
        {
            final String alreadyConsumedText = getText(commentsOffset, lastConsumedPosition);
            if (Constants.DEBUG_TODOS) logDebug('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
            if (CommentTools.isEmptyOrComments(alreadyConsumedText))
            {
                // TODO: test
                // TODO: Find a better way!
                adjustedCommentsOffset = lastConsumedPosition;
            }
        }

        // TODO: test
        if (adjustedCommentsOffset < commentsEnd)
            copyText(adjustedCommentsOffset, commentsEnd, fullSource);
        else
            logWarning('Comments not consumed: adjustedCommentsOffset ($adjustedCommentsOffset) < commentsEnd ($commentsEnd): ${StringTools.toDisplayString(token)}');
    }

    void _copyTokenWithoutComments(Token? token, String source)
    {
        const String methodName = 'copyTokenWithoutComments';
        final String fullSource = '$source/$methodName';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($fullSource)');
            return;
        }

        Token? commentToken = token.precedingComments;
        int? commentTokenEnd = commentToken?.end;
        while (commentToken != null)
        {
            commentTokenEnd = commentToken.end;
            commentToken = commentToken.next;
        }

        if (commentTokenEnd == null)
        {
            copyText(token.offset, token.end, fullSource);
            return;
        }

        int adjustedCommentTokenEnd = commentTokenEnd;
        if (commentTokenEnd < lastConsumedPosition)
        {
            final String alreadyConsumedText = getText(commentTokenEnd, lastConsumedPosition);
            if (Constants.DEBUG_TODOS) logDebug('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
            if (CommentTools.isEmptyOrComments(alreadyConsumedText))
            {
                // TODO: test
                // TODO: Find a better way!
                adjustedCommentTokenEnd = lastConsumedPosition;
            }
        }

        // TODO: test
        if (adjustedCommentTokenEnd < token.end)
            copyText(adjustedCommentTokenEnd, token.end, fullSource);
        else
            logWarning('Comments not consumed: adjustedCommentTokenEnd ($adjustedCommentTokenEnd) < token.end (${token.end}): ${StringTools.toDisplayString(token)}');
    }

    String getLastText()
    => _textBuffers.last.lastText;

    CharacterLocation? getLocation(int offset)
    {
        try
        {
            return _parseResult.lineInfo.getLocation(offset);
        }
        // ignore: avoid_catching_errors
        on UnimplementedError catch (_)
        {
            // TestParseStringResult will throw an UnimplementedError.
            //logInfo('Offset $offset');
            return null;
        }
    }

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

    String getResultAfterLastLineBreak()
    {
        final String text = _textBuffers.last.toString();
        final int lastPos = text.lastIndexOf('\n');
        final String r = lastPos == -1 ? '' : text.substring(lastPos + 1);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('getResultAfterLastLineBreak: ${StringTools.toDisplayString(r)}');
        return r;
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

    String getText(int offset, int end)
    {
        try
        {
            return _parseResult.content.substring(offset, end);
        }
        catch (e)
        {
            if (Constants.DEBUG_FORMAT_STATE)
            {
                logInternal('FormatState.getText($offset, $end) $e');
                logInternal('  ${StringTools.toDisplayString(_parseResult.content)}');
            }
            rethrow;
        }
    }

    void popLevelAndIndent()
    {
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# FormatState.popLevelAndIndent()');

        final Indentation lastLevel = _indentations.removeLast();
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  Popped level: name: "${lastLevel.name}" type: "${lastLevel.type}"');

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

        String indent = '';
        if (lastLevel.type == IndentationType.single)
        {
            if (!s.trim().startsWith('{'))
                indent = ' ' * _indentationSpacesPerLevel;
        }
        else if (lastLevel.type == IndentationType.multiple)
        {
            indent = ' ' * _indentationSpacesPerLevel;
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  indent:      ${StringTools.toDisplayString(indent)}');
        final bool endsWithNewLine = s.endsWith('\n');
        if (endsWithNewLine)
            s = s.substring(0, s.length - 1);

        s = s.replaceAll('\n', '\n$indent');
        s = s.replaceAll(RegExp('\n\\s+\n'), '\n\n');

        if (endsWithNewLine)
            s += '\n';

        if (previousTextEndsWithNewLine)
            s = s.substring(1);

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  indentedText: ${StringTools.toDisplayString(s)}');
        _textBuffers.last.write(s);
    }

    // TODO: remove usage of pushLevel() until covered by tests.
    // TODO: when is IndentationType.multiple even used?
    void pushLevel(String name, [IndentationType type = IndentationType.single])
    {
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('# FormatState.pushLevel(name: "$name", type: "$type")');
            //logInternal('  lastText: ${StringTools.toDisplayString(_textBuffers.last.lastText)}');
            //logInternal('  allText:  ${StringTools.toDisplayString(_textBuffers.last)}');
        }

        _indentations.add(Indentation(name: name, type: type));
        _textBuffers.add(StringBufferEx(lastText: _textBuffers.last.lastText));
    }

    void write(String s)
    {
        _textBuffers.last.write(s);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('= ${StringTools.toDisplayString(getResult())}');
    } 

    void _logError(String s)
    {
        logInternalError(s);
    }

    void logAndThrowError(String message, [CharacterLocation? location])
    {
        _logError(message);
        throw DartFormatException.error(message, location);
    }

    void logAndThrowErrorWithOffset(String message, String? additionalText, int offset)
    {
        final String positionInfo = Constants.DEBUG_FORMAT_STATE ? '$offset, ${getPositionInfo(offset)}' : getPositionInfo(offset);

        String finalMessage = '$message ($positionInfo)';
        if (additionalText != null)
            finalMessage += ' $additionalText';

        logAndThrowError(finalMessage, getLocation(offset));
    }

    void logAndThrowErrorWithOffsets(String message, String delimiter, String? additionalText, int offset1, int offset2, String source)
    {
        final String positionInfo1 = Constants.DEBUG_FORMAT_STATE ? '$offset1, ${getPositionInfo(offset1)}' : getPositionInfo(offset1);
        final String positionInfo2 = Constants.DEBUG_FORMAT_STATE ? '$offset2, ${getPositionInfo(offset2)}' : getPositionInfo(offset2);

        String finalMessage = '$message ($positionInfo1) $delimiter ($positionInfo2)';
        if (additionalText != null)
            finalMessage += ' $additionalText';

        finalMessage += ' ($source)';
        logAndThrowError(finalMessage, getLocation(offset1));
    }

    String _removeLeadingWhitespace(String s, int offset)
    {
        if (_indentationSpacesPerLevel < 0)
            return s;

        try
        {
            if (offset == 0)
                return LeadingWhitespaceRemover.removeFrom(s, removeLeadingSpaces: true);

            final String resultAfterLastLineBreak = getResultAfterLastLineBreak();
            final String currentLineSoFar = _getCurrentLineSoFar(offset);
            return LeadingWhitespaceRemover.removeFrom(s, removeLeadingSpaces: false, initialCurrentLineSoFar: currentLineSoFar, resultAfterLastLineBreak: resultAfterLastLineBreak);
        }
        on DartFormatException catch(e, stackTrace)
        {
            logError('$e\n$stackTrace');
            final CharacterLocation? location = getLocation(offset);
            throw e.copyWith(line: location?.lineNumber, column: location?.columnNumber);
        }
    }

    void _setLastConsumedPosition(int value, String source)
    {
        if (value < lastConsumedPosition)
            logAndThrowErrorWithOffsets('Internal error: setLastConsumedPosition: value < lastConsumedPosition:', '<', null, value, lastConsumedPosition, source);

        _lastConsumedPosition = value;
    }

    String _getCurrentLineSoFar(int offset)
    {
        if (Constants.DEBUG_FORMAT_STATE) logInternal('getCurrentLineSoFar($offset)');

        if (offset == 0)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal("  Offset==0 => returning ''");
            return '';
        }

        int currentOffset = offset - 1;
        while (currentOffset >= 0)
        {
            final String c = _parseResult.content[currentOffset];
            if (c == '\n')
            {
                final String result = _parseResult.content.substring(currentOffset + 1, offset);
                if (result.isEmpty)
                {
                    if (Constants.DEBUG_FORMAT_STATE) logInternal("  Line break found and current line is empty => Returning ''");
                    return '';
                }

                if (Constants.DEBUG_FORMAT_STATE) logInternal('  Line break found => Returning: ${StringTools.toDisplayString(result)}');
                return result;
            }

            currentOffset--;
        }

        final String result = _parseResult.content.substring(0, offset);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  No line break found => Returning all: ${StringTools.toDisplayString(result)}');
        return result;
    }
}
