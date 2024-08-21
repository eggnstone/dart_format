// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CommentInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentInfo {
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  bool get isComment => throw _privateConstructorUsedError;
  bool get isEmpty => throw _privateConstructorUsedError;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentInfoCopyWith<CommentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentInfoCopyWith<$Res> {
  factory $CommentInfoCopyWith(
          CommentInfo value, $Res Function(CommentInfo) then) =
      _$CommentInfoCopyWithImpl<$Res, CommentInfo>;
  @useResult
  $Res call(
      {String? errorMessage, bool hasError, bool isComment, bool isEmpty});
}

/// @nodoc
class _$CommentInfoCopyWithImpl<$Res, $Val extends CommentInfo>
    implements $CommentInfoCopyWith<$Res> {
  _$CommentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isComment: null == isComment
          ? _value.isComment
          : isComment // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmpty: null == isEmpty
          ? _value.isEmpty
          : isEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentInfoImplCopyWith<$Res>
    implements $CommentInfoCopyWith<$Res> {
  factory _$$CommentInfoImplCopyWith(
          _$CommentInfoImpl value, $Res Function(_$CommentInfoImpl) then) =
      __$$CommentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? errorMessage, bool hasError, bool isComment, bool isEmpty});
}

/// @nodoc
class __$$CommentInfoImplCopyWithImpl<$Res>
    extends _$CommentInfoCopyWithImpl<$Res, _$CommentInfoImpl>
    implements _$$CommentInfoImplCopyWith<$Res> {
  __$$CommentInfoImplCopyWithImpl(
      _$CommentInfoImpl _value, $Res Function(_$CommentInfoImpl) _then)
      : super(_value, _then);

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
    return _then(_$CommentInfoImpl(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      isComment: null == isComment
          ? _value.isComment
          : isComment // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmpty: null == isEmpty
          ? _value.isEmpty
          : isEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CommentInfoImpl extends _CommentInfo {
  const _$CommentInfoImpl(
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

  @override
  String toString() {
    return 'CommentInfo(errorMessage: $errorMessage, hasError: $hasError, isComment: $isComment, isEmpty: $isEmpty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentInfoImpl &&
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

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentInfoImplCopyWith<_$CommentInfoImpl> get copyWith =>
      __$$CommentInfoImplCopyWithImpl<_$CommentInfoImpl>(this, _$identity);
}

abstract class _CommentInfo extends CommentInfo {
  const factory _CommentInfo(
      {final String? errorMessage,
      final bool hasError,
      final bool isComment,
      final bool isEmpty}) = _$CommentInfoImpl;
  const _CommentInfo._() : super._();

  @override
  String? get errorMessage;
  @override
  bool get hasError;
  @override
  bool get isComment;
  @override
  bool get isEmpty;

  /// Create a copy of CommentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentInfoImplCopyWith<_$CommentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
