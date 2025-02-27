import 'package:freezed_annotation/freezed_annotation.dart';

part 'CommentInfo.freezed.dart';

@freezed
abstract class CommentInfo with _$CommentInfo
{
    const factory CommentInfo({
        String? errorMessage,
        @Default(false) bool hasError,
        @Default(false) bool isComment,
        @Default(false) bool isEmpty
    //@Default(false) bool isEndOfLineComment
    }) = _CommentInfo;

    // necessary when you want to create additional methods
    const CommentInfo._();

    bool get isEmptyOrComments => isEmpty || isComment;
}
