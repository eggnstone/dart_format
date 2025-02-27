// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CommentInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentInfo {
  String? get errorMessage;
  bool get hasError;
  bool get isComment;
  bool get isEmpty;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentInfoCopyWith<CommentInfo> get copyWith =>
      _$CommentInfoCopyWithImpl<CommentInfo>(this as CommentInfo, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentInfo &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.isComment, isComment) ||
                other.isComment == isComment) &&
            (identical(other.isEmpty, isEmpty) || other.isEmpty == isEmpty));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, errorMessage, hasError, isComment, isEmpty);

  @override
  String toString() {
    return 'CommentInfo(errorMessage: $errorMessage, hasError: $hasError, isComment: $isComment, isEmpty: $isEmpty)';
  }
}

/// @nodoc
abstract mixin class $CommentInfoCopyWith<$Res> {
  factory $CommentInfoCopyWith(
          CommentInfo value, $Res Function(CommentInfo) _then) =
      _$CommentInfoCopyWithImpl;
  @useResult
  $Res call(
      {String? errorMessage, bool hasError, bool isComment, bool isEmpty});
}

/// @nodoc
class _$CommentInfoCopyWithImpl<$Res> implements $CommentInfoCopyWith<$Res> {
  _$CommentInfoCopyWithImpl(this._self, this._then);

  final CommentInfo _self;
  final $Res Function(CommentInfo) _then;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? hasError = null,
    Object? isComment = null,
    Object? isEmpty = null,
  }) {
    return _then(_self.copyWith(
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _self.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isComment: null == isComment
          ? _self.isComment
          : isComment // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmpty: null == isEmpty
          ? _self.isEmpty
          : isEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _CommentInfo extends CommentInfo {
  const _CommentInfo(
      {this.errorMessage,
      this.hasError = false,
      this.isComment = false,
      this.isEmpty = false})
      : super._();

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final bool isComment;
  @override
  @JsonKey()
  final bool isEmpty;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentInfoCopyWith<_CommentInfo> get copyWith =>
      __$CommentInfoCopyWithImpl<_CommentInfo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentInfo &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.isComment, isComment) ||
                other.isComment == isComment) &&
            (identical(other.isEmpty, isEmpty) || other.isEmpty == isEmpty));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, errorMessage, hasError, isComment, isEmpty);

  @override
  String toString() {
    return 'CommentInfo(errorMessage: $errorMessage, hasError: $hasError, isComment: $isComment, isEmpty: $isEmpty)';
  }
}

/// @nodoc
abstract mixin class _$CommentInfoCopyWith<$Res>
    implements $CommentInfoCopyWith<$Res> {
  factory _$CommentInfoCopyWith(
          _CommentInfo value, $Res Function(_CommentInfo) _then) =
      __$CommentInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? errorMessage, bool hasError, bool isComment, bool isEmpty});
}

/// @nodoc
class __$CommentInfoCopyWithImpl<$Res> implements _$CommentInfoCopyWith<$Res> {
  __$CommentInfoCopyWithImpl(this._self, this._then);

  final _CommentInfo _self;
  final $Res Function(_CommentInfo) _then;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = freezed,
    Object? hasError = null,
    Object? isComment = null,
    Object? isEmpty = null,
  }) {
    return _then(_CommentInfo(
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _self.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isComment: null == isComment
          ? _self.isComment
          : isComment // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmpty: null == isEmpty
          ? _self.isEmpty
          : isEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
