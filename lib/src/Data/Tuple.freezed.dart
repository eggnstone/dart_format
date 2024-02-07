// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Tuple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Tuple<T1, T2> {
  T1 get item1 => throw _privateConstructorUsedError;
  T2 get item2 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TupleCopyWith<T1, T2, Tuple<T1, T2>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TupleCopyWith<T1, T2, $Res> {
  factory $TupleCopyWith(
          Tuple<T1, T2> value, $Res Function(Tuple<T1, T2>) then) =
      _$TupleCopyWithImpl<T1, T2, $Res, Tuple<T1, T2>>;
  @useResult
  $Res call({T1 item1, T2 item2});
}

/// @nodoc
class _$TupleCopyWithImpl<T1, T2, $Res, $Val extends Tuple<T1, T2>>
    implements $TupleCopyWith<T1, T2, $Res> {
  _$TupleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TupleImplCopyWith<T1, T2, $Res>
    implements $TupleCopyWith<T1, T2, $Res> {
  factory _$$TupleImplCopyWith(
          _$TupleImpl<T1, T2> value, $Res Function(_$TupleImpl<T1, T2>) then) =
      __$$TupleImplCopyWithImpl<T1, T2, $Res>;
  @override
  @useResult
  $Res call({T1 item1, T2 item2});
}

/// @nodoc
class __$$TupleImplCopyWithImpl<T1, T2, $Res>
    extends _$TupleCopyWithImpl<T1, T2, $Res, _$TupleImpl<T1, T2>>
    implements _$$TupleImplCopyWith<T1, T2, $Res> {
  __$$TupleImplCopyWithImpl(
      _$TupleImpl<T1, T2> _value, $Res Function(_$TupleImpl<T1, T2>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item1 = freezed,
    Object? item2 = freezed,
  }) {
    return _then(_$TupleImpl<T1, T2>(
      freezed == item1
          ? _value.item1
          : item1 // ignore: cast_nullable_to_non_nullable
              as T1,
      freezed == item2
          ? _value.item2
          : item2 // ignore: cast_nullable_to_non_nullable
              as T2,
    ));
  }
}

/// @nodoc

class _$TupleImpl<T1, T2> implements _Tuple<T1, T2> {
  const _$TupleImpl(this.item1, this.item2);

  @override
  final T1 item1;
  @override
  final T2 item2;

  @override
  String toString() {
    return 'Tuple<$T1, $T2>(item1: $item1, item2: $item2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TupleImpl<T1, T2> &&
            const DeepCollectionEquality().equals(other.item1, item1) &&
            const DeepCollectionEquality().equals(other.item2, item2));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(item1),
      const DeepCollectionEquality().hash(item2));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TupleImplCopyWith<T1, T2, _$TupleImpl<T1, T2>> get copyWith =>
      __$$TupleImplCopyWithImpl<T1, T2, _$TupleImpl<T1, T2>>(this, _$identity);
}

abstract class _Tuple<T1, T2> implements Tuple<T1, T2> {
  const factory _Tuple(final T1 item1, final T2 item2) = _$TupleImpl<T1, T2>;

  @override
  T1 get item1;
  @override
  T2 get item2;
  @override
  @JsonKey(ignore: true)
  _$$TupleImplCopyWith<T1, T2, _$TupleImpl<T1, T2>> get copyWith =>
      throw _privateConstructorUsedError;
}
