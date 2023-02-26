import "../StringExtensions.dart";
 import "package:dotlin/src/kotlin/ranges/ranges_ext.dt.g.dart" show IntRangeFactoryExt;
 import "c.dt.g.dart" show C;
 import "package:dotlin/src/dotlin/intrinsics/internal.dt.g.dart" show $Return;
 import "package:dotlin/src/kotlin/library.dt.g.dart" show SafeStringPlus;
 import "package:dotlin/src/kotlin/ranges/ranges.dt.g.dart" show IntRange;
 import "package:meta/meta.dart" ;
@sealed class DotlinTools{ static const DotlinTools$Companion  $companion = DotlinTools$Companion.$instance; static bool contains(String s, C c, )=> DotlinTools$Companion.$instance.$contains(s, c); static String replace(String s, C searchChar, String replaceText, )=> DotlinTools$Companion.$instance.$replace(s, searchChar, replaceText);}
@sealed class DotlinTools$Companion{ const  DotlinTools$Companion._() : super();@nonVirtual bool $contains(String s, C c, ){try {for ( int  i = 0; i < s.length; i += 1) {final C  sc = C(s.get(i).toString());if (sc == c){throw const $Return<bool>(true, -1765825969);}}return false;}on $Return<bool> catch (tmp0_return){if (tmp0_return.target == -1765825969){return tmp0_return.value;}else {throw tmp0_return;}} }@nonVirtual String $replace(String s, C searchChar, String replaceText, ){ String  result = "";for ( int  i = 0; i < s.length; i += 1) {final C  sc = C(s.get(i).toString());if (sc == searchChar){result += replaceText;}else {result += sc.value;}}return result;} static const DotlinTools$Companion  $instance = const DotlinTools$Companion._();}