 import "package:meta/meta.dart" ;
 enum SimpleAreaType{Instruction._(), Unknown._(), Whitespace._(); const  SimpleAreaType._();}
 SimpleAreaType $SimpleAreaType$valueOf(String value)=> SimpleAreaType.values.firstWhere((SimpleAreaType v)=> v.name == value);