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
            removeTrailingCommas: removeTrailingCommas,
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

                consumeText(lastNode.end, node.offset, periodText, source);
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

                consumeText(lastToken.end, token.offset, periodText, source);
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

    void acceptListWithComma(NodeList<AstNode> nodes, SyntacticEntity? endToken, AstVisitor<void> astVisitor, String source, {int? leadingSpaces, bool trimCommaText = false})
    {
        const String methodName = 'acceptListWithComma';

        if (nodes.isNotEmpty)
            consumeSpaces(nodes.first, leadingSpaces);

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

                String commaText = getText(end, node.offset);
                if (!FormatTools.isCommaText(commaText))
                    logAndThrowErrorWithOffsets('commaText is not a comma', '-', StringTools.toDisplayString(commaText), end, node.offset, source);

                if (trimCommaText)
                {
                    final String trimmedCommaText = '${StringTools.trimSpaces(commaText)} ';
                    if (Constants.DEBUG_I_FORMATTER) logDebug('Trimming commaText: ${StringTools.toDisplayString(commaText)} => ${StringTools.toDisplayString(trimmedCommaText)}');
                    commaText = trimmedCommaText;
                }

                consumeText(end, node.offset, commaText, source);
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
                        if (Constants.DEBUG_TODOS) logInternal('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
                        if (CommentTools.isEmptyOrComments(alreadyConsumedText))
                        {
                            // TODO: test
                            // TODO: Find a better way!
                            adjustedLastNodeEnd = lastConsumedPosition;
                        }
                    }

                    // TODO: test
                    if (adjustedLastNodeEnd < endToken.offset)
                        consumeText(adjustedLastNodeEnd, endToken.offset, commaText, source);
                    else
                        logWarning('Trailing comma text not consumed: adjustedLastNodeEnd < endToken.offset');
                }
            }
        }
    }

    void addNewLineAfterToken(Token? token, String source, {required bool add})
    {
        const String methodName = 'addNewLineAfterToken';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(add=$add, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('  sb: ${StringTools.toDisplayStringCutAtEnd(getResult(), Constants.MAX_DEBUG_LENGTH)}');

        if (token == null || !add)
            return;

        final Token? nextToken = token.next;
        if (nextToken == null)
            return;

        final int end = nextToken.offset;

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
            consumeText(token.end, nextToken.offset, filler, source);
            _addNewLineBeforeToken(nextToken, add: add, beforeComments: false, source);
            return;
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('  Not EOF');
        _addNewLineBeforeToken(nextToken, add: add, beforeComments: true, source);
    }

    void _addNewLineBeforeToken(Token? token, String source, {required bool add, required bool beforeComments})
    {
        const String methodName = 'addNewLineBeforeToken';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(add=$add, beforeComments=$beforeComments, ${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null || !add)
            return;

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
            addText('\n', source);
            return;
        }

        final int end = beforeComments ? token.precedingComments?.offset ?? token.offset : token.offset;
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  lastConsumedPosition:            $lastConsumedPosition');
            logInternal('  token.precedingComments:         ${StringTools.toDisplayString(token.precedingComments)}');
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
        consumeText(lastConsumedPosition, end, '', source);
        addText('\n', source);
    }

    void addText(String s, String source)
    {
        const String methodName = 'addText';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        consumeText(lastConsumedPosition, lastConsumedPosition, s, source);
    }

    void consumeText(int offset, int end, String s, String source, {bool isString = false, int? spaces})
    {
        const String methodName = 'consumeText';
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('# $methodName($offset-$end, isString: $isString, spaces: $spaces, source: $source)');
            logInternal('  s: ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}');
        }

        if (lastConsumedPosition > offset)
            logAndThrowErrorWithOffsets('Internal error: offset < lastConsumedPosition:', '<', null, offset, lastConsumedPosition, source);

        if (lastConsumedPosition == offset)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  No filler');

            if (spaces != null)
            {
                final String lastText = _textBuffers.last.toString();

                if (Constants.DEBUG_FORMAT_STATE_SPACING)
                {
                    logInternal('  spaces/1:         $spaces');
                    logInternal('    lastText:       ${StringTools.toDisplayString(lastText)}');
                }

                if (lastText.endsWith('\n'))
                {
                    if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    Not adding any spaces because lastText ends with line break');
                }
                else
                {
                    if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    Adding $spaces spaces because lastText does not end with line break');
                    write(' ' * spaces);
                }
            }
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
                if (spaces != null)
                    logWarning('Skipping space-only filler: spaces (${StringTools.toDisplayString(spaces)}) != null');
                /*
                Why did we have this exception?
                if (spaces != null)
                    throw DartFormatException.error('TODO: Skipping space-only filler: spaces (${StringTools.toDisplayString(spaces)}) != null');
                */
            }
            else
            {
                String fixedFiller = _removeLeadingWhitespace(filler, lastConsumedPosition);
                if (Constants.DEBUG_FORMAT_STATE)
                {
                    logInternal('  fixedFiller/4a:   ${StringTools.toDisplayString(fixedFiller)}');
                    logInternal('+ ${StringTools.toDisplayString(fixedFiller, Constants.MAX_DEBUG_LENGTH)} ($source)');
                }

                if (spaces != null)
                {
                    final int existingSpacesLeft = StringTools.countSpacesLeft(fixedFiller);
                    if (Constants.DEBUG_FORMAT_STATE_SPACING)
                    {
                        logInternal('  spaces/2:         $spaces');
                        logInternal('    lastText:       ${StringTools.toDisplayString(_textBuffers.last.toString())}');
                        logInternal('    fixedFiller/4b: ${StringTools.toDisplayString(fixedFiller)}');
                        logInternal('    spacesLeft:     $existingSpacesLeft');
                    }

                    if (existingSpacesLeft == fixedFiller.length)
                    {
                        if (existingSpacesLeft != spaces)
                        {
                            fixedFiller = ' ' * spaces;
                            if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4c: ${StringTools.toDisplayString(fixedFiller)}');
                        }
                    }
                    else
                    {
                        if (existingSpacesLeft != 1)
                        {
                            final String fixedFillerTrimmedLeft = fixedFiller.substring(existingSpacesLeft);
                            if (fixedFillerTrimmedLeft.startsWith('\n'))
                            {
                                fixedFiller = fixedFillerTrimmedLeft;
                                if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4d: ${StringTools.toDisplayString(fixedFiller)}');
                            }
                            else
                            {
                                final String lastText = _textBuffers.last.toString();
                                if (lastText.endsWith('\n'))
                                {
                                    fixedFiller = fixedFillerTrimmedLeft;
                                    if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4e: ${StringTools.toDisplayString(fixedFiller)}');
                                }
                                else
                                {                                
                                    fixedFiller = ' $fixedFillerTrimmedLeft';
                                    if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4f: ${StringTools.toDisplayString(fixedFiller)}');
                                }
                            }
                        }

                        final int existingSpacesRight = StringTools.countSpacesRight(fixedFiller);
                        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('      spacesRight:  $existingSpacesLeft');

                        if (existingSpacesRight != spaces)
                        {
                            final String fixedFillerTrimmedRight = fixedFiller.substring(0, fixedFiller.length - existingSpacesRight);
                            if (fixedFillerTrimmedRight.endsWith('\n'))
                            {
                                fixedFiller = fixedFillerTrimmedRight;
                                if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4g: ${StringTools.toDisplayString(fixedFiller)}');
                            }
                            else
                            {
                                fixedFiller = fixedFillerTrimmedRight + ' ' * spaces;
                                if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('    fixedFiller/4h: ${StringTools.toDisplayString(fixedFiller)}');
                            }
                        }
                    }
                }

                write(fixedFiller);
            }
        }

        if (Constants.DEBUG_FORMAT_STATE) logInternal('+ ${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)} ($source)');
        final String fixedS = _removeLeadingWhitespace(s, offset, isString: isString);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('  S w/o leading ws:  ${StringTools.toDisplayString(fixedS)}');

        if (fixedS.isNotEmpty && StringTools.startsWithNormalChar(fixedS))
        {
            final String resultAfterOptionalLastLineBreak = getResultAfterOptionalLastLineBreak();
            if (StringTools.endsWithNormalChar(resultAfterOptionalLastLineBreak))
            {
                //if (Constants.DEBUG_FORMAT_STATE) logInternal('  Adding 1 space to prevent two normal chars to connect.');
                logError('Adding 1 space to prevent two normal chars to connect (should not be necessary).');
                write(' ');
            }
            else
            {
                if (Constants.DEBUG_FORMAT_STATE) logInternal('  NOT Adding 1 space to prevent two normal chars to connect.');
            }
        }
        else
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('  NOT (fixedS.isNotEmpty && StringTools.startsWithNormalChar(fixedS))');
        }

        write(fixedS);

        _setLastConsumedPosition(end, source);
    }

    void consumeTill(int end, String source)
    {
        const String methodName = 'consumeTill';
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

        final String fixedFiller = _removeLeadingWhitespace(filler, lastConsumedPosition);
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('  fixedFiller:               ${StringTools.toDisplayString(fixedFiller)}');
            logInternal('+ ${StringTools.toDisplayString(fixedFiller, Constants.MAX_DEBUG_LENGTH)} ($source)');
        }

        write(fixedFiller);

        _setLastConsumedPosition(end, source);
    }

    void consumeTillTheEnd(String source)
    => consumeTill(_parseResult.unit.end, source);

    void copyClosingBraceAndPopLevel(Token token, Config config, String source)
    => copyToken(token, source,
        addNewLineBefore: config.addNewLineBeforeClosingBrace,
        addNewLineAfter: config.addNewLineAfterClosingBrace,
        popLevel: true
    );

    void copySemicolon(Token? token, Config config, String source, [int? spaces])
    {
        if (token == null)
            return;

        copyToken(token, source,
            addNewLineBefore: false,
            addNewLineAfter: config.addNewLineAfterSemicolon,
            spaces: spaces
        );
    }

    void copyEntity(SyntacticEntity? entity, AstVisitor<void> astVisitor, String source, [int? spaces])
    {
        const String methodName = 'copyEntity';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(entity, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (entity == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($source)');
            return;
        }

        if (entity is AstNode)
        {
            consumeSpaces(entity, spaces);
            entity.accept(astVisitor);
        }
        else
            copyText(entity.offset, entity.end, source, spaces);
    }

    void copyOpeningBraceAndPushLevel(Token token, Config config, String source)
    => copyToken(token, source,
        addNewLineBefore: config.addNewLineBeforeOpeningBrace,
        addNewLineAfter: config.addNewLineAfterOpeningBrace,
        pushLevel: true
    );

    void copyText(int offset, int end, String source, [int? spaces])
    {
        const String methodName = 'copyText';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName($offset, $end, $source)');

        final String s = getText(offset, end);
        consumeText(offset, end, s, source, spaces: spaces);
    }

    void copyString(int offset, int end, String source)
    {
        const String methodName = 'copyString';
        final String s = getText(offset, end);
        if (Constants.DEBUG_FORMAT_STATE)
        {
            logInternal('# START $methodName($offset, $end, $source)');
            logInternal('  ${StringTools.toDisplayString(s)}');
        }

        consumeText(offset, end, s, source, isString: true);
    }

    void copyToken(Token token, String source, {
            required bool addNewLineBefore,
            required bool addNewLineAfter,
            bool pushLevel = false,
            bool popLevel = false,
            int? spaces
        })
    {
        const String methodName = 'copyToken';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, addNewLineBefore=$addNewLineBefore, addNewLineAfter=$addNewLineAfter, pushLevel: $pushLevel, popLevel: $popLevel, $source)');

        _copyTokenCommentsOnly(token, source);
        _addNewLineBeforeToken(token, add: addNewLineBefore, beforeComments: false, source);

        if (popLevel)
            popLevelAndIndent();

        _copyTokenWithoutComments(token, source, spaces);
        addNewLineAfterToken(token, add: addNewLineAfter, source);

        if (pushLevel)
            this.pushLevel(source);
    }

    void _copyTokenCommentsOnly(Token? token, String source /*, [int? spaces]*/)
    {
        const String methodName = 'copyTokenCommentsOnly';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($source)');
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
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <no comments> ($source)');
            return;
        }

        int adjustedCommentsOffset = commentsOffset;
        if (commentsOffset < lastConsumedPosition)
        {
            final String alreadyConsumedText = getText(commentsOffset, lastConsumedPosition);
            if (Constants.DEBUG_TODOS) logInternal('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
            if (CommentTools.isEmptyOrComments(alreadyConsumedText))
            {
                // TODO: test
                // TODO: Find a better way!
                adjustedCommentsOffset = lastConsumedPosition;
            }
        }

        // TODO: test
        if (adjustedCommentsOffset < commentsEnd)
        {
            copyText(adjustedCommentsOffset, commentsEnd, source /*, spaces*/);
        }
        else
        {
            if (Constants.DEBUG_FORMAT_STATE) logWarning('Comments not consumed: adjustedCommentsOffset ($adjustedCommentsOffset) < commentsEnd ($commentsEnd): ${StringTools.toDisplayString(token)}');
        }
    }

    void _copyTokenWithoutComments(Token? token, String source, [int? spaces])
    {
        const String methodName = 'copyTokenWithoutComments';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(token, Constants.MAX_DEBUG_LENGTH)}, $source)');

        if (token == null)
        {
            if (Constants.DEBUG_FORMAT_STATE) logInternal('+ <null> ($source)');
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
            copyText(token.offset, token.end, source, spaces);
            return;
        }

        int adjustedCommentTokenEnd = commentTokenEnd;
        if (commentTokenEnd < lastConsumedPosition)
        {
            final String alreadyConsumedText = getText(commentTokenEnd, lastConsumedPosition);
            if (Constants.DEBUG_TODOS) logInternal('$methodName: alreadyConsumedText: ${StringTools.toDisplayString(alreadyConsumedText)}');
            if (CommentTools.isEmptyOrComments(alreadyConsumedText))
            {
                // TODO: test
                // TODO: Find a better way!
                adjustedCommentTokenEnd = lastConsumedPosition;
            }
        }

        // TODO: test
        if (adjustedCommentTokenEnd < token.end)
        {
            copyText(adjustedCommentTokenEnd, token.end, source, spaces);
        }
        else
        {
            if (Constants.DEBUG_FORMAT_STATE) logWarning('Comments not consumed: adjustedCommentTokenEnd ($adjustedCommentTokenEnd) < token.end (${token.end}): ${StringTools.toDisplayString(token)}');
        }
    }

    StringBufferEx getLastStringBuffer()
    => _textBuffers.last;

    // TODO: rename to better distinguish from getLastStringBuffer()
    /// Do you mean getLastStringBuffer?
    String getLastText()
    => getLastStringBuffer().lastText;

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

    /// Returns empty string if no line break found
    String getResultAfterRequiredLastLineBreak()
    {
        const String METHOD_NAME = 'getResultAfterRequiredLastLineBreak';
        final String lastText = _textBuffers.last.toString();
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: lastText: ${StringTools.toDisplayString(lastText)}');
        final int lastPos = lastText.lastIndexOf('\n');
        final String r = lastPos == -1 ? '' : lastText.substring(lastPos + 1);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: ${StringTools.toDisplayString(r)}');
        return r;
    }

    /// Returns complete string if no line break found
    String getResultAfterOptionalLastLineBreak()
    {
        const String METHOD_NAME = 'getResultAfterOptionalLastLineBreak';
        final String lastText = _textBuffers.last.toString();
        //if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: lastText: ${StringTools.toDisplayString(lastText)}');
        final int lastPos = lastText.lastIndexOf('\n');
        final String r = lastPos == -1 ? lastText : lastText.substring(lastPos + 1);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('$METHOD_NAME: ${StringTools.toDisplayString(r)}');
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

    String _removeLeadingWhitespace(String s, int offset, {bool isString = false})
    {
        if (_indentationSpacesPerLevel < 0)
            return s;

        try
        {
            if (isString)
                return LeadingWhitespaceRemover.removeFromString(s, '  ');

            if (offset == 0)
                return LeadingWhitespaceRemover.removeFrom(s, removeLeadingSpaces: true);

            final String resultAfterLastLineBreak = getResultAfterRequiredLastLineBreak();
            final String currentLineSoFar = _getCurrentLineSoFar(offset);
            return LeadingWhitespaceRemover.removeFrom(
                s,
                initialCurrentLineSoFar: currentLineSoFar,
                removeLeadingSpaces: false,
                resultAfterLastLineBreak: resultAfterLastLineBreak
            );
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

    void consumeSpacesBeforeFunctionBody(FunctionBody body, Config config)
    {
        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('consumeSpacesBeforeFunctionBody()');
        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('  body:                         ${body.runtimeType}');
        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('  fixSpaces:                    ${config.fixSpaces}');
        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('  addNewLineBeforeOpeningBrace: ${config.addNewLineBeforeOpeningBrace}');

        int? spacesForBody;
        if (config.fixSpaces)
        {
            if (body is BlockFunctionBody)
            {
                if (!config.addNewLineBeforeOpeningBrace)
                    spacesForBody = 1;
            }
            else if (body is ExpressionFunctionBody)
            {
                final String textToConsume = getText(lastConsumedPosition, body.offset);
                if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('  textToConsume:                ${StringTools.toDisplayString(textToConsume)}');
                if (!textToConsume.contains('\n'))
                    spacesForBody = 1;
            }
        }

        if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('  spacesForBody:                $spacesForBody');
        if (spacesForBody != 1)
            return;

        consumeText(lastConsumedPosition, body.offset, ' ', 'consumeSpacesBeforeFunctionBody');
    }

    void consumeSpaces(SyntacticEntity entity, int? spaces)
    {
        if (spaces == null)
            return;

        final String filler = getText(lastConsumedPosition, entity.offset);
        if (StringTools.trimSpaces(filler).isNotEmpty)
        {
            if (Constants.DEBUG_FORMAT_STATE_SPACING) logInternal('consumeSpaces: filler has non-spaces: ${StringTools.toDisplayString(filler)}');
            return;
        }

        if (Constants.DEBUG_FORMAT_STATE_SPACING)
        {
            final String lastText = _textBuffers.last.toString();
            logInternal('consumeSpaces($spaces):');
            logInternal('  entity:   ${StringTools.toDisplayString(getText(entity.offset, entity.end))}');
            logInternal('  lastText: ${StringTools.toDisplayString(lastText)}');
            logInternal('  filler:   ${StringTools.toDisplayString(getText(lastConsumedPosition, entity.offset))}');
        }

        consumeText(lastConsumedPosition, entity.offset, '', 'consumeSpaces', spaces: spaces);

        if (Constants.DEBUG_FORMAT_STATE_SPACING)
        {
            final String lastText = _textBuffers.last.toString();
            logInternal('  lastText: ${StringTools.toDisplayString(lastText)}');
        }
    }

    void dump2(SyntacticEntity? entity, SyntacticEntity? previousEntity, String name, [String indent = ''])
    {
        dump(entity, name, indent);

        if (entity == null || previousEntity == null)
            return;

        logWarning('### dump2:         ${StringTools.toDisplayString(getText(previousEntity.end, entity.offset))}');
    }

    void dumpList(List<SyntacticEntity>? list, String name, [String indent = ''])
    {
        final String paddedName = '$name:'.padRight(10);
        if (list == null)
        {
            logDebug('### $indent$paddedName <null>');
            return;
        }

        logError('### $indent$paddedName ${StringTools.toDisplayString(list)} ${list.runtimeType}');
    }

    void dump(SyntacticEntity? entity, String name, [String indent = ''])
    {
        final String paddedName = '$name:'.padRight(10);
        if (entity == null)
        {
            logDebug('### $indent$paddedName <null>');
            return;
        }

        logError('### $indent$paddedName ${StringTools.toDisplayString(entity)} ${entity.runtimeType}');
        logWarning('### $indent  text:    ${StringTools.toDisplayString(getText(entity.offset, entity.end))}');
        logWarning('### $indent  offset:  ${entity.offset}');
        logWarning('### $indent  end:     ${entity.end}');

        logWarning('### last => start: ${StringTools.toDisplayString(getText(lastConsumedPosition, entity.offset))}');
        //logWarning('### last => start: ${StringTools.toDisplayString(getText(entity.beginToken, entity.offset))}');
        logWarning('### entity text:   ${StringTools.toDisplayString(getText(entity.offset, entity.end))}');
    }
}
