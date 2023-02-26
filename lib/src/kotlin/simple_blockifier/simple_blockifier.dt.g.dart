import "../StringExtensions.dart";
 import "simple_area_type.dt.g.dart" show SimpleAreaType;
 import "package:dotlin/src/kotlin/ranges/ranges_ext.dt.g.dart" show IntRangeFactoryExt;
 import "../dotlin/dotlin_char.dt.g.dart" show DotlinChar;
 import "../dotlin/dotlin_logger.dt.g.dart" show DotlinLogger$Companion;
 import "../tools.dt.g.dart" show Tools$Companion;
 import "../simple_blocks/simple_instruction_block.dt.g.dart" show SimpleInstructionBlock;
 import "../simple_blocks/simple_whitespace_block.dt.g.dart" show SimpleWhitespaceBlock;
 import "package:dotlin/src/dotlin/intrinsics/errors.dt.g.dart" show NoWhenBranchMatchedError;
 import "package:dotlin/src/kotlin/library.dt.g.dart" show SafeStringPlus;
 import "../dart_format_exception.dt.g.dart" show DartFormatException;
 import "../simple_blocks/isimple_block.dt.g.dart" show ISimpleBlock;
 import "package:dotlin/src/kotlin/ranges/ranges.dt.g.dart" show IntRange;
 import "package:meta/meta.dart" ;
@sealed class SimpleBlockifier{@nonVirtual final List<ISimpleBlock>  _blocks = <ISimpleBlock>[];@nonVirtual  SimpleAreaType  _currentAreaType = SimpleAreaType.Unknown;@nonVirtual final List<DotlinChar>  _currentBrackets = <DotlinChar>[];@nonVirtual  String  _currentText = "";@nonVirtual  bool  _hasMainCurlyBrackets = false;@nonVirtual List<ISimpleBlock> blockify(String text){for ( int  i = 0; i < text.length; i += 1) {final DotlinChar  c = DotlinChar(text.get(i).toString());if (SimpleBlockifier$Companion.$instance._$debug){DotlinLogger$Companion.$instance.$log("${Tools$Companion.$instance.$toDisplayString2$m3975160dbe00d095(c)} ${this._currentAreaType} ${Tools$Companion.$instance.$toDisplayString2(this._currentText)}");}(){final SimpleAreaType  tmp1_subject = this._currentAreaType;return tmp1_subject == SimpleAreaType.Instruction ? this._handleInstructionArea(c) : tmp1_subject == SimpleAreaType.Unknown ? this._handleUnknownArea(c) : tmp1_subject == SimpleAreaType.Whitespace ? this._handleWhitespaceArea(c) : this._throwError("only necessary because of dotlin");}.call();}if (this._currentText.length > 0){ ISimpleBlock?  finalBlock = null;if (SimpleBlockifier$Companion.$instance._$debug){this.printBlocks(this._blocks, label: "Final / currentText is not empty");}if (this._currentAreaType == SimpleAreaType.Instruction){if (this._currentBrackets.isNotEmpty){this._throwError("Text ends but brackets not closed.");}if (this._currentText == ";"){finalBlock = SimpleInstructionBlock(this._currentText);}else if (this._hasMainCurlyBrackets){finalBlock = SimpleInstructionBlock(this._currentText);}}if (finalBlock == null){finalBlock = (){final SimpleAreaType  tmp2_subject = this._currentAreaType;return tmp2_subject == SimpleAreaType.Instruction ? this._throwError("Text ends but instruction not closed.") : tmp2_subject == SimpleAreaType.Unknown ? this._throwError("Unexpected area type: ${this._currentAreaType}") : tmp2_subject == SimpleAreaType.Whitespace ? SimpleWhitespaceBlock(this._currentText) : throw NoWhenBranchMatchedError();}.call();}if (SimpleBlockifier$Companion.$instance._$debug){DotlinLogger$Companion.$instance.$log("Final block: ${finalBlock}");}this._blocks.add(finalBlock);}else {if (SimpleBlockifier$Companion.$instance._$debug){this.printBlocks(this._blocks, label: "Final / currentText is empty");}}return this._blocks;}@nonVirtual void _handleInstructionArea(DotlinChar c){if (c.value == ";" && this._currentBrackets.length == 0){final String  dotlinC = c.value;this._blocks.add(SimpleInstructionBlock(this._currentText + dotlinC));this._reset(SimpleAreaType.Unknown, "");return;}if (Tools$Companion.$instance.$isOpeningBracket(c)){if (c.value == "{" && this._currentBrackets.length == 0){this._hasMainCurlyBrackets = true;}this._currentBrackets.add(c);final String  dotlinC = c.value;this._currentText += dotlinC;return;}if (Tools$Companion.$instance.$isClosingBracket(c)){final DotlinChar?  lastOrNull = this._currentBrackets.length == 0 ? null : this._currentBrackets[this._currentBrackets.length - 1];if (lastOrNull != Tools$Companion.$instance.$getOpeningBracket(c)){this._throwError("Unexpected closing bracket.");}this._currentBrackets.removeLast();if (this._currentBrackets.length == 0){if (this._hasMainCurlyBrackets){this._blocks.add(SimpleInstructionBlock(this._currentText.plus(c)));this._reset(SimpleAreaType.Unknown, "");return;}}final String  dotlinC = c.value;this._currentText += dotlinC;return;}final String  dotlinC = c.value;this._currentText += dotlinC;}@nonVirtual void _handleUnknownArea(DotlinChar c){if (Tools$Companion.$instance.$isWhitespace(c)){this._reset(SimpleAreaType.Whitespace, c.value);return;}this._reset(SimpleAreaType.Instruction, c.value);if (Tools$Companion.$instance.$isOpeningBracket(c)){this._currentBrackets.add(c);if (c.value == "{"){this._hasMainCurlyBrackets = true;}}}@nonVirtual void _handleWhitespaceArea(DotlinChar c){if (Tools$Companion.$instance.$isWhitespace(c)){final String  dotlinC = c.value;this._currentText += dotlinC;return;}this._blocks.add(SimpleWhitespaceBlock(this._currentText));this._reset(SimpleAreaType.Instruction, c.value);}@nonVirtual void printBlocks(List<ISimpleBlock> blocks, {String label = "", }){final String  prefix = label.length == 0 ? "" : "${label} - ";if (blocks.length == 0){DotlinLogger$Companion.$instance.$log("${prefix}No blocks.");}else {DotlinLogger$Companion.$instance.$log("${prefix}${blocks.length} blocks:");}for ( int  i = 0; i < blocks.length; i += 1) {final ISimpleBlock  block = blocks[i];DotlinLogger$Companion.$instance.$log("  ${block}");}}@nonVirtual void _reset(SimpleAreaType areaType, String text, ){this._currentAreaType = areaType;this._currentBrackets.clear();this._currentText = text;this._hasMainCurlyBrackets = false;}@nonVirtual ISimpleBlock _throwError(String message){DotlinLogger$Companion.$instance.$log("Error: ${message}");DotlinLogger$Companion.$instance.$log("  currentAreaType:      ${this._currentAreaType}");DotlinLogger$Companion.$instance.$log("  currentBrackets:      ${Tools$Companion.$instance.$charsToDisplayString2(this._currentBrackets)}");DotlinLogger$Companion.$instance.$log("  currentText:          ${Tools$Companion.$instance.$toDisplayString2(this._currentText)}");DotlinLogger$Companion.$instance.$log("  hasMainCurlyBrackets: ${this._hasMainCurlyBrackets}");this.printBlocks(this._blocks);throw DartFormatException(message);} static const SimpleBlockifier$Companion  $companion = SimpleBlockifier$Companion.$instance; static const bool  _debug = false;}
@sealed class SimpleBlockifier$Companion{ const  SimpleBlockifier$Companion._() : super();@nonVirtual final bool  _$debug = false; static const SimpleBlockifier$Companion  $instance = const SimpleBlockifier$Companion._();}