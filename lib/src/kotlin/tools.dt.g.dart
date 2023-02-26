 import "dotlin/dotlin_tools.dt.g.dart" show DotlinTools$Companion;
 import "package:dotlin/src/kotlin/ranges/ranges_ext.dt.g.dart" show IntRangeFactoryExt;
 import "package:dotlin/src/kotlin/library.dt.g.dart" show SafeStringPlus;
 import "dotlin/c.dt.g.dart" show C;
 import "package:dotlin/src/dotlin/intrinsics/internal.dt.g.dart" show $Return;
 import "dart_format_exception.dt.g.dart" show DartFormatException;
 import "package:dotlin/src/kotlin/ranges/ranges.dt.g.dart" show IntRange;
 import "package:meta/meta.dart" ;
@sealed class Tools{ static const Tools$Companion  $companion = Tools$Companion.$instance; static bool isWhitespace(C c)=> Tools$Companion.$instance.$isWhitespace(c); static bool isClosingBracket(C c)=> Tools$Companion.$instance.$isClosingBracket(c); static bool isOpeningBracket(C c)=> Tools$Companion.$instance.$isOpeningBracket(c); static String _charsToDisplayString1(List<C> chars)=> Tools$Companion.$instance._$charsToDisplayString1(chars); static String charsToDisplayString2(List<C> chars)=> Tools$Companion.$instance.$charsToDisplayString2(chars); static String _toDisplayString1(String s)=> Tools$Companion.$instance._$toDisplayString1(s); static String toDisplayString2(String s)=> Tools$Companion.$instance.$toDisplayString2(s); static String _toDisplayString1$49df03d9576a1e0e(C c)=> Tools$Companion.$instance._$toDisplayString1$1c0e0cca663d1ff0(c); static String toDisplayString2$6a899a9abd46949d(C c)=> Tools$Companion.$instance.$toDisplayString2$m1a72e3bf6f893cb5(c); static String _stringsToDisplayString1(List<String> strings)=> Tools$Companion.$instance._$stringsToDisplayString1(strings); static C getOpeningBracket(C closingBracket)=> Tools$Companion.$instance.$getOpeningBracket(closingBracket);}
@sealed class Tools$Companion{ const  Tools$Companion._() : super();@nonVirtual bool $isWhitespace(C c){return DotlinTools$Companion.$instance.$contains("/n/r/t ", c);}@nonVirtual bool $isClosingBracket(C c){return DotlinTools$Companion.$instance.$contains("})]", c);}@nonVirtual bool $isOpeningBracket(C c){return DotlinTools$Companion.$instance.$contains("{([", c);}@nonVirtual String _$charsToDisplayString1(List<C> chars){ String  result = "";for ( int  i = 0; i < chars.length; i += 1) result += this._$toDisplayString1$1c0e0cca663d1ff0(chars[i]);return result;}@nonVirtual String $charsToDisplayString2(List<C> chars){return "[" + this._$charsToDisplayString1(chars) + "]";}@nonVirtual String _$toDisplayString1(String s){return DotlinTools$Companion.$instance.$replace(DotlinTools$Companion.$instance.$replace(s, C("/r"), "\/r"), C("/n"), "\/n");}@nonVirtual String $toDisplayString2(String s){return "\"" + this._$toDisplayString1(s) + "\"";}@nonVirtual String _$toDisplayString1$1c0e0cca663d1ff0(C c){return this._$toDisplayString1(c.value);}@nonVirtual String $toDisplayString2$m1a72e3bf6f893cb5(C c){return "'" + this._$toDisplayString1$1c0e0cca663d1ff0(c) + "'";}@nonVirtual String _$stringsToDisplayString1(List<String> strings){ String  result = "";for ( int  i = 0; i < strings.length; i += 1) result += this._$toDisplayString1(strings[i]);return result;}@nonVirtual C $getOpeningBracket(C closingBracket){try {final String  tmp0_subject = closingBracket.value;if (tmp0_subject == "}"){throw $Return<C>(C("{"), -1475888898);}else if (tmp0_subject == ")"){throw $Return<C>(C("("), -1475888898);}else if (tmp0_subject == "]"){throw $Return<C>(C("["), -1475888898);}else {throw DartFormatException("Unexpected closing bracket: ${closingBracket}");}}on $Return<C> catch (tmp0_return){if (tmp0_return.target == -1475888898){return tmp0_return.value;}else {throw tmp0_return;}} } static const Tools$Companion  $instance = const Tools$Companion._();}