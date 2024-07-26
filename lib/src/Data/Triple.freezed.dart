// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Triple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Triple<T1, T2, T3> {
  T1 get item1 => throw _privateConstructorUsedError;
  T2 get item2 => throw _privateConstructorUsedError;
  T3 get item3 => throw _privateConstructorUsedError;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripleCopyWith<T1, T2, T3, Triple<T1, T2, T3>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripleCopyWith<T1, T2, T3, $Res> {
  factory $TripleCopyWith(
          Triple<T1, T2, T3> value, $Res Function(Triple<T1, T2, T3>) then) =
      _$TripleCopyWithImpl<T1, T2, T3, $Res, Triple<T1, T2, T3>>;
  @useResult
  $Res call({T1 item1, T2 item2, T3 item3});
}

/// @nodoc
class _$TripleCopyWithImpl<T1, T2, T3, $Res, $Val extends Triple<T1, T2, T3>>
    implements $TripleCopyWith<T1, T2, T3, $Res> {
  _$TripleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
    Object? item3 = freezed,
  }) {
    return _then(_value.copyWith(
      item1: freezed == item1
          ? _value.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T1,
      item2: freezed == item2
          ? _value.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as T2,
      item3: freezed == item3
          ? _value.item3
          : item3 // ignore: cast_nullable_to_non_nullable
              as T3,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripleImplCopyWith<T1, T2, T3, $Res>
    implements $TripleCopyWith<T1, T2, T3, $Res> {
  factory _$$TripleImplCopyWith(_$TripleImpl<T1, T2, T3> value,
          $Res Function(_$TripleImpl<T1, T2, T3>) then) =
      __$$TripleImplCopyWithImpl<T1, T2, T3, $Res>;
  @override
  @useResult
  $Res call({T1 item1, T2 item2, T3 item3});
}

/// @nodoc
class __$$TripleImplCopyWithImpl<T1, T2, T3, $Res>
    extends _$TripleCopyWithImpl<T1, T2, T3, $Res, _$TripleImpl<T1, T2, T3>>
    implements _$$TripleImplCopyWith<T1, T2, T3, $Res> {
  __$$TripleImplCopyWithImpl(_$TripleImpl<T1, T2, T3> _value,
      $Res Function(_$TripleImpl<T1, T2, T3>) _then)
      : super(_value, _then);

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
    Object? item3 = freezed,
  }) {
    return _then(_$TripleImpl<T1, T2, T3>(
      freezed == item1
          ? _value.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T1,
      freezed == item2
          ? _value.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as T2,
      freezed == item3
          ? _value.item3
          : item3 // ignore: cast_nullable_to_non_nullable
              as T3,
    ));
  }
}

/// @nodoc

class _$TripleImpl<T1, T2, T3> implements _Triple<T1, T2, T3> {
  const _$TripleImpl(this.item1, this.item2, this.item3);

  @override
  final T1 item1;
  @override
  final T2 item2;
  @override
  final T3 item3;

  @override
  String toString() {
    return 'Triple<$T1, $T2, $T3>(item1: $item1, item2: $item2, item3: $item3)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripleImpl<T1, T2, T3> &&
            const DeepCollectionEquality().equals(other.item1, item1) &&
            const DeepCollectionEquality().equals(other.item2, item2) &&
            const DeepCollectionEquality().equals(other.item3, item3));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(item1),
      const DeepCollectionEquality().hash(item2),
      const DeepCollectionEquality().hash(item3));

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripleImplCopyWith<T1, T2, T3, _$TripleImpl<T1, T2, T3>> get copyWith =>
      __$$TripleImplCopyWithImpl<T1, T2, T3, _$TripleImpl<T1, T2, T3>>(
          this, _$identity);
}

abstract class _Triple<T1, T2, T3> implements Triple<T1, T2, T3> {
  const factory _Triple(final T1 item1, final T2 item2, final T3 item3) =
      _$TripleImpl<T1, T2, T3>;

  @override
  T1 get item1;
  @override
  T2 get item2;
  @override
  T3 get item3;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripleImplCopyWith<T1, T2, T3, _$TripleImpl<T1, T2, T3>> get copyWith =>
      throw _privateConstructorUsedError;
}
