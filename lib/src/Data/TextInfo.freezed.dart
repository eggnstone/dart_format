// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'TextInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TextInfo {

 TextType get type; String get text;
/// Create a copy of TextInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextInfoCopyWith<TextInfo> get copyWith => _$TextInfoCopyWithImpl<TextInfo>(this as TextInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'TextInfo(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $TextInfoCopyWith<$Res>  {
  factory $TextInfoCopyWith(TextInfo value, $Res Function(TextInfo) _then) = _$TextInfoCopyWithImpl;
@useResult
$Res call({
 TextType type, String text
});




}
/// @nodoc
class _$TextInfoCopyWithImpl<$Res>
    implements $TextInfoCopyWith<$Res> {
  _$TextInfoCopyWithImpl(this._self, this._then);

  final TextInfo _self;
  final $Res Function(TextInfo) _then;

/// Create a copy of TextInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? text = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TextType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TextInfo].
extension TextInfoPatterns on TextInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextInfo value)  $default,){
final _that = this;
switch (_that) {
case _TextInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TextInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextType type,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextInfo() when $default != null:
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextType type,  String text)  $default,) {final _that = this;
switch (_that) {
case _TextInfo():
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextType type,  String text)?  $default,) {final _that = this;
switch (_that) {
case _TextInfo() when $default != null:
return $default(_that.type,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _TextInfo implements TextInfo {
  const _TextInfo({required this.type, required this.text});
  

@override final  TextType type;
@override final  String text;

/// Create a copy of TextInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextInfoCopyWith<_TextInfo> get copyWith => __$TextInfoCopyWithImpl<_TextInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'TextInfo(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class _$TextInfoCopyWith<$Res> implements $TextInfoCopyWith<$Res> {
  factory _$TextInfoCopyWith(_TextInfo value, $Res Function(_TextInfo) _then) = __$TextInfoCopyWithImpl;
@override @useResult
$Res call({
 TextType type, String text
});




}
/// @nodoc
class __$TextInfoCopyWithImpl<$Res>
    implements _$TextInfoCopyWith<$Res> {
  __$TextInfoCopyWithImpl(this._self, this._then);

  final _TextInfo _self;
  final $Res Function(_TextInfo) _then;

/// Create a copy of TextInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? text = null,}) {
  return _then(_TextInfo(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TextType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
