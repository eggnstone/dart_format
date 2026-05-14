// ignore_for_file: always_put_control_body_on_new_line

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/source/line_info.dart';

import 'Constants/Constants.dart';
import 'Data/Config.dart';
import 'DebugDumper.dart';
import 'Enums/IndentationType.dart';
import 'Exceptions/DartFormatException.dart';
import 'FormatErrorReporter.dart';
import 'IndentedOutput.dart';
import 'StringBufferEx.dart';
import 'Text/LeadingWhitespaceRemover.dart';
import 'Tools/CommentTools.dart';
import 'Tools/FormatTools.dart';
import 'Tools/LogTools.dart';
import 'Tools/StringTools.dart';

class FormatState
{
    final int _indentationSpacesPerLevel;
    final DateTime _maxDateTime;
    final ParseStringResult _parseResult;
    final bool _removeTrailingCommas;
    final DateTime _startDateTime;
    final IndentedOutput _output;
    final FormatErrorReporter _errorReporter;
    final DebugDumper _dumper;

    int _lastConsumedPosition = 0;
    String? _trailingForTests;

    int logIndent = 0;

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
        _startDateTime = startDateTime,
        _output = IndentedOutput(indentationSpacesPerLevel),
        _errorReporter = FormatErrorReporter(parseResult),
        _dumper = DebugDumper(parseResult.content);

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

    CompilationUnit get compilationUnit => _parseResult.unit;

    int get lastConsumedPosition => _lastConsumedPosition;

    DateTime get maxDateTime => _maxDateTime;

    DateTime get startDateTime => _startDateTime;

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
                    final String trimmed = StringTools.trimSpaces(commaText);
                    final String trimmedCommaText = trimmed.contains('\n') ? trimmed : '$trimmed ';
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
                else if (commaText.trim().isNotEmpty && CommentTools.isEmptyOrComments(commaText))
                {
                    // No trailing comma, but trailing comments before endToken: consume them
                    // inside the current (pushed) level so popLevelAndIndent re-indents them.
                    // Otherwise the comments end up in the outer buffer as filler before endToken
                    // and lose their indentation. Leave the final line break (and any trailing
                    // whitespace after it) unconsumed so the closing token still sits on its own
                    // line at the outer indent level.
                    final int lastNewlinePos = commaText.lastIndexOf('\n');
                    final int trailingEnd = lastNewlinePos >= 0
                        ? lastNode.end + lastNewlinePos
                        : endToken.offset;
                    if (lastNode.end < trailingEnd)
                        consumeText(lastNode.end, trailingEnd, getText(lastNode.end, trailingEnd), source);
                }
            }
        }
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

    void addText(String s, String source)
    {
        const String methodName = 'addText';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName(${StringTools.toDisplayString(s, Constants.MAX_DEBUG_LENGTH)}, $source)');

        consumeText(lastConsumedPosition, lastConsumedPosition, s, source);
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
            final String lastText = _output.lastStringBuffer.toString();
            logInternal('consumeSpaces($spaces):');
            logInternal('  entity:   ${StringTools.toDisplayString(getText(entity.offset, entity.end))}');
            logInternal('  lastText: ${StringTools.toDisplayString(lastText)}');
            logInternal('  filler:   ${StringTools.toDisplayString(getText(lastConsumedPosition, entity.offset))}');
        }

        consumeText(lastConsumedPosition, entity.offset, '', 'consumeSpaces', spaces: spaces);

        if (Constants.DEBUG_FORMAT_STATE_SPACING)
        {
            final String lastText = _output.lastStringBuffer.toString();
            logInternal('  lastText: ${StringTools.toDisplayString(lastText)}');
        }
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
                final String lastText = _output.lastStringBuffer.toString();

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
                logInternal('  _output.lastStringBuffer: ${StringTools.toDisplayString(_output.lastStringBuffer)}');
            }

            if (filler.replaceAll(' ', '').isEmpty && _output.levelCount == 0 && _output.lastStringBuffer.toString().isEmpty)
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
                        logInternal('    lastText:       ${StringTools.toDisplayString(_output.lastStringBuffer.toString())}');
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
                                final String lastText = _output.lastStringBuffer.toString();
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

        String lastText = _output.lastStringBuffer.toString();
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

    void copyText(int offset, int end, String source, [int? spaces])
    {
        const String methodName = 'copyText';
        if (Constants.DEBUG_FORMAT_STATE) logInternal('# $methodName($offset, $end, $source)');

        final String s = getText(offset, end);
        consumeText(offset, end, s, source, spaces: spaces);
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

    void dump(SyntacticEntity? entity, String name, [String indent = ''])
    => _dumper.dump(entity, name, indent, lastConsumedPosition);

    void dump2(SyntacticEntity? entity, SyntacticEntity? previousEntity, String name, [String indent = ''])
    => _dumper.dump2(entity, previousEntity, name, indent, lastConsumedPosition);

    void dumpList(List<SyntacticEntity>? list, String name, [String indent = ''])
    => _dumper.dumpList(list, name, indent);

    StringBufferEx getLastStringBuffer()
    => _output.lastStringBuffer;

    // TODO: rename to better distinguish from getLastStringBuffer()
    /// Do you mean getLastStringBuffer?
    String getLastText()
    => _output.lastText;

    CharacterLocation? getLocation(int offset)
    => _errorReporter.getLocation(offset);

    String getPositionInfo(int offset)
    => _errorReporter.getPositionInfo(offset);

    String getResult()
    => _output.getResult();

    String getResultAfterLast(String searchText)
    => _output.getResultAfterLast(searchText);

    /// Returns complete string if no line break found
    String getResultAfterOptionalLastLineBreak()
    => _output.getResultAfterOptionalLastLineBreak();

    /// Returns empty string if no line break found
    String getResultAfterRequiredLastLineBreak()
    => _output.getResultAfterRequiredLastLineBreak();

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

    void logAndThrowError(String message, [CharacterLocation? location])
    => _errorReporter.logAndThrowError(message, location);

    void logAndThrowErrorWithOffset(String message, String? additionalText, int offset)
    => _errorReporter.logAndThrowErrorWithOffset(message, additionalText, offset);

    void logAndThrowErrorWithOffsets(String message, String delimiter, String? additionalText, int offset1, int offset2, String source)
    => _errorReporter.logAndThrowErrorWithOffsets(message, delimiter, additionalText, offset1, offset2, source);

    void popLevelAndIndent()
    => _output.popLevelAndIndent();

    void pushLevel(String name, [IndentationType type = IndentationType.single, int? customIndentSize])
    => _output.pushLevel(name, type, customIndentSize);

    void write(String s)
    {
        _output.write(s);
        if (Constants.DEBUG_FORMAT_STATE) logInternal('= ${StringTools.toDisplayString(getResult())}');
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

}
