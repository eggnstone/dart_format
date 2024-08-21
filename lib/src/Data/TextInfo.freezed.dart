// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'TextInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextInfo {
  TextType get type => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Create a copy of TextInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextInfoCopyWith<TextInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextInfoCopyWith<$Res> {
  factory $TextInfoCopyWith(TextInfo value, $Res Function(TextInfo) then) =
      _$TextInfoCopyWithImpl<$Res, TextInfo>;
  @useResult
  $Res call({TextType type, String text});
}

/// @nodoc
class _$TextInfoCopyWithImpl<$Res, $Val extends TextInfo>
    implements $TextInfoCopyWith<$Res> {
  _$TextInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TextType,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextInfoImplCopyWith<$Res>
    implements $TextInfoCopyWith<$Res> {
  factory _$$TextInfoImplCopyWith(
          _$TextInfoImpl value, $Res Function(_$TextInfoImpl) then) =
      __$$TextInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TextType type, String text});
}

/// @nodoc
class __$$TextInfoImplCopyWithImpl<$Res>
    extends _$TextInfoCopyWithImpl<$Res, _$TextInfoImpl>
    implements _$$TextInfoImplCopyWith<$Res> {
  __$$TextInfoImplCopyWithImpl(
      _$TextInfoImpl _value, $Res Function(_$TextInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? text = null,
  }) {
    return _then(_$TextInfoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TextType,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TextInfoImpl implements _TextInfo {
  const _$TextInfoImpl({required this.type, required this.text});

  @override
  final TextType type;
  @override
  final String text;

  @override
  String toString() {
    return 'TextInfo(type: $type, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextInfoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, text);

  /// Create a copy of TextInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextInfoImplCopyWith<_$TextInfoImpl> get copyWith =>
      __$$TextInfoImplCopyWithImpl<_$TextInfoImpl>(this, _$identity);
}

abstract class _TextInfo implements TextInfo {
  const factory _TextInfo(
      {required final TextType type,
      required final String text}) = _$TextInfoImpl;

  @override
  TextType get type;
  @override
  String get text;

  /// Create a copy of TextInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextInfoImplCopyWith<_$TextInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
