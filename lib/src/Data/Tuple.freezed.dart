// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Tuple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Tuple<T1,T2> {

 T1 get item1; T2 get item2;
/// Create a copy of Tuple
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TupleCopyWith<T1, T2, Tuple<T1, T2>> get copyWith => _$TupleCopyWithImpl<T1, T2, Tuple<T1, T2>>(this as Tuple<T1, T2>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tuple<T1, T2>&&const DeepCollectionEquality().equals(other.item1, item1)&&const DeepCollectionEquality().equals(other.item2, item2));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(item1),const DeepCollectionEquality().hash(item2));

@override
String toString() {
  return 'Tuple<$T1, $T2>(item1: $item1, item2: $item2)';
}


}

/// @nodoc
abstract mixin class $TupleCopyWith<T1,T2,$Res>  {
  factory $TupleCopyWith(Tuple<T1, T2> value, $Res Function(Tuple<T1, T2>) _then) = _$TupleCopyWithImpl;
@useResult
$Res call({
 T1 item1, T2 item2
});




}
/// @nodoc
class _$TupleCopyWithImpl<T1,T2,$Res>
    implements $TupleCopyWith<T1, T2, $Res> {
  _$TupleCopyWithImpl(this._self, this._then);

  final Tuple<T1, T2> _self;
  final $Res Function(Tuple<T1, T2>) _then;

/// Create a copy of Tuple
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item1 = freezed,Object? item2 = freezed,}) {
  return _then(_self.copyWith(
item1: freezed == item1 ? _self.item1 : item1 // ignore: cast_nullable_to_non_nullable
as T1,item2: freezed == item2 ? _self.item2 : item2 // ignore: cast_nullable_to_non_nullable
as T2,
  ));
}

}


/// Adds pattern-matching-related methods to [Tuple].
extension TuplePatterns<T1,T2> on Tuple<T1, T2> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tuple<T1, T2> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tuple() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tuple<T1, T2> value)  $default,){
final _that = this;
switch (_that) {
case _Tuple():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tuple<T1, T2> value)?  $default,){
final _that = this;
switch (_that) {
case _Tuple() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T1 item1,  T2 item2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tuple() when $default != null:
return $default(_that.item1,_that.item2);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T1 item1,  T2 item2)  $default,) {final _that = this;
switch (_that) {
case _Tuple():
return $default(_that.item1,_that.item2);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T1 item1,  T2 item2)?  $default,) {final _that = this;
switch (_that) {
case _Tuple() when $default != null:
return $default(_that.item1,_that.item2);case _:
  return null;

}
}

}

/// @nodoc


class _Tuple<T1,T2> implements Tuple<T1, T2> {
  const _Tuple(this.item1, this.item2);
  

@override final  T1 item1;
@override final  T2 item2;

/// Create a copy of Tuple
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TupleCopyWith<T1, T2, _Tuple<T1, T2>> get copyWith => __$TupleCopyWithImpl<T1, T2, _Tuple<T1, T2>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tuple<T1, T2>&&const DeepCollectionEquality().equals(other.item1, item1)&&const DeepCollectionEquality().equals(other.item2, item2));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(item1),const DeepCollectionEquality().hash(item2));

@override
String toString() {
  return 'Tuple<$T1, $T2>(item1: $item1, item2: $item2)';
}


}

/// @nodoc
abstract mixin class _$TupleCopyWith<T1,T2,$Res> implements $TupleCopyWith<T1, T2, $Res> {
  factory _$TupleCopyWith(_Tuple<T1, T2> value, $Res Function(_Tuple<T1, T2>) _then) = __$TupleCopyWithImpl;
@override @useResult
$Res call({
 T1 item1, T2 item2
});




}
/// @nodoc
class __$TupleCopyWithImpl<T1,T2,$Res>
    implements _$TupleCopyWith<T1, T2, $Res> {
  __$TupleCopyWithImpl(this._self, this._then);

  final _Tuple<T1, T2> _self;
  final $Res Function(_Tuple<T1, T2>) _then;

/// Create a copy of Tuple
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item1 = freezed,Object? item2 = freezed,}) {
  return _then(_Tuple<T1, T2>(
freezed == item1 ? _self.item1 : item1 // ignore: cast_nullable_to_non_nullable
as T1,freezed == item2 ? _self.item2 : item2 // ignore: cast_nullable_to_non_nullable
as T2,
  ));
}


}

// dart format on
