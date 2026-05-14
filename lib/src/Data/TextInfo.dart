import 'package:freezed_annotation/freezed_annotation.dart';

import '../Enums/TextType.dart';

part 'TextInfo.freezed.dart';

@freezed
abstract class TextInfo with _$TextInfo
{
    const factory TextInfo({
        required TextType type,
        required String text
    }) = _TextInfo;
}
