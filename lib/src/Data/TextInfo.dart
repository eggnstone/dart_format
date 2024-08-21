// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../Types/TextType.dart';

part 'TextInfo.freezed.dart';

@freezed
class TextInfo with _$TextInfo
{
    const factory TextInfo({
        required TextType type,
        required String text
    }) = _TextInfo;
}
