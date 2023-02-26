import 'package:eggnstone_dart/eggnstone_dart.dart';
import "package:meta/meta.dart";

@sealed
class DotlinLogger {
  static const DotlinLogger$Companion $companion = DotlinLogger$Companion.$instance;

  static void log(String s) => DotlinLogger$Companion.$instance.$log(s);
}

@sealed
class DotlinLogger$Companion {
  const DotlinLogger$Companion._() : super();

  @nonVirtual
  void $log(String s)
  => logDebug(s);

  static const DotlinLogger$Companion $instance = const DotlinLogger$Companion._();
}
