import 'package:freezed_annotation/freezed_annotation.dart';

import 'Types/IndentationType.dart';

part 'Indentation.freezed.dart';

@freezed
class Indentation with _$Indentation
{
    const factory Indentation({
        required String name,
        required IndentationType type
    }) = _Indentation;
}
