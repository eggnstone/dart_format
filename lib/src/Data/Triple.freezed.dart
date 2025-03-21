// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Triple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Triple<T1, T2, T3> {
  T1 get item1;
  T2 get item2;
  T3 get item3;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TripleCopyWith<T1, T2, T3, Triple<T1, T2, T3>> get copyWith =>
      _$TripleCopyWithImpl<T1, T2, T3, Triple<T1, T2, T3>>(
          this as Triple<T1, T2, T3>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Triple<T1, T2, T3> &&
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

  @override
  String toString() {
    return 'Triple<$T1, $T2, $T3>(item1: $item1, item2: $item2, item3: $item3)';
  }
}

/// @nodoc
abstract mixin class $TripleCopyWith<T1, T2, T3, $Res> {
  factory $TripleCopyWith(
          Triple<T1, T2, T3> value, $Res Function(Triple<T1, T2, T3>) _then) =
      _$TripleCopyWithImpl;
  @useResult
  $Res call({T1 item1, T2 item2, T3 item3});
}

/// @nodoc
class _$TripleCopyWithImpl<T1, T2, T3, $Res>
    implements $TripleCopyWith<T1, T2, T3, $Res> {
  _$TripleCopyWithImpl(this._self, this._then);

  final Triple<T1, T2, T3> _self;
  final $Res Function(Triple<T1, T2, T3>) _then;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
    Object? item3 = freezed,
  }) {
    return _then(_self.copyWith(
      item1: freezed == item1
          ? _self.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T1,
      item2: freezed == item2
          ? _self.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as T2,
      item3: freezed == item3
          ? _self.item3
          : item3 // ignore: cast_nullable_to_non_nullable
              as T3,
    ));
  }
}

/// @nodoc

class _Triple<T1, T2, T3> implements Triple<T1, T2, T3> {
  const _Triple(this.item1, this.item2, this.item3);

  @override
  final T1 item1;
  @override
  final T2 item2;
  @override
  final T3 item3;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TripleCopyWith<T1, T2, T3, _Triple<T1, T2, T3>> get copyWith =>
      __$TripleCopyWithImpl<T1, T2, T3, _Triple<T1, T2, T3>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Triple<T1, T2, T3> &&
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

  @override
  String toString() {
    return 'Triple<$T1, $T2, $T3>(item1: $item1, item2: $item2, item3: $item3)';
  }
}

/// @nodoc
abstract mixin class _$TripleCopyWith<T1, T2, T3, $Res>
    implements $TripleCopyWith<T1, T2, T3, $Res> {
  factory _$TripleCopyWith(
          _Triple<T1, T2, T3> value, $Res Function(_Triple<T1, T2, T3>) _then) =
      __$TripleCopyWithImpl;
  @override
  @useResult
  $Res call({T1 item1, T2 item2, T3 item3});
}

/// @nodoc
class __$TripleCopyWithImpl<T1, T2, T3, $Res>
    implements _$TripleCopyWith<T1, T2, T3, $Res> {
  __$TripleCopyWithImpl(this._self, this._then);

  final _Triple<T1, T2, T3> _self;
  final $Res Function(_Triple<T1, T2, T3>) _then;

  /// Create a copy of Triple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
    Object? item3 = freezed,
  }) {
    return _then(_Triple<T1, T2, T3>(
      freezed == item1
          ? _self.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T1,
      freezed == item2
          ? _self.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as T2,
      freezed == item3
          ? _self.item3
          : item3 // ignore: cast_nullable_to_non_nullable
              as T3,
    ));
  }
}

// dart format on
