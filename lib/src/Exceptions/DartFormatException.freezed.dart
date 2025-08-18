// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DartFormatException.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DartFormatException {

/// The message of the exception.
@JsonKey(name: 'Message') String get message;/// The type of the exception.
@JsonKey(name: 'Type') FailType get type;/// The line number where the exception occurred.
@JsonKey(includeIfNull: false, name: 'Line') int? get line;/// The column number where the exception occurred.
@JsonKey(includeIfNull: false, name: 'Column') int? get column;
/// Create a copy of DartFormatException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DartFormatExceptionCopyWith<DartFormatException> get copyWith => _$DartFormatExceptionCopyWithImpl<DartFormatException>(this as DartFormatException, _$identity);

  /// Serializes this DartFormatException to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DartFormatException&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.line, line) || other.line == line)&&(identical(other.column, column) || other.column == column));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,type,line,column);

@override
String toString() {
  return 'DartFormatException(message: $message, type: $type, line: $line, column: $column)';
}


}

/// @nodoc
abstract mixin class $DartFormatExceptionCopyWith<$Res>  {
  factory $DartFormatExceptionCopyWith(DartFormatException value, $Res Function(DartFormatException) _then) = _$DartFormatExceptionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Message') String message,@JsonKey(name: 'Type') FailType type,@JsonKey(includeIfNull: false, name: 'Line') int? line,@JsonKey(includeIfNull: false, name: 'Column') int? column
});




}
/// @nodoc
class _$DartFormatExceptionCopyWithImpl<$Res>
    implements $DartFormatExceptionCopyWith<$Res> {
  _$DartFormatExceptionCopyWithImpl(this._self, this._then);

  final DartFormatException _self;
  final $Res Function(DartFormatException) _then;

/// Create a copy of DartFormatException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? type = null,Object? line = freezed,Object? column = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailType,line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,column: freezed == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DartFormatException].
extension DartFormatExceptionPatterns on DartFormatException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DartFormatException value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DartFormatException() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DartFormatException value)  $default,){
final _that = this;
switch (_that) {
case _DartFormatException():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DartFormatException value)?  $default,){
final _that = this;
switch (_that) {
case _DartFormatException() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Message')  String message, @JsonKey(name: 'Type')  FailType type, @JsonKey(includeIfNull: false, name: 'Line')  int? line, @JsonKey(includeIfNull: false, name: 'Column')  int? column)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DartFormatException() when $default != null:
return $default(_that.message,_that.type,_that.line,_that.column);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Message')  String message, @JsonKey(name: 'Type')  FailType type, @JsonKey(includeIfNull: false, name: 'Line')  int? line, @JsonKey(includeIfNull: false, name: 'Column')  int? column)  $default,) {final _that = this;
switch (_that) {
case _DartFormatException():
return $default(_that.message,_that.type,_that.line,_that.column);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Message')  String message, @JsonKey(name: 'Type')  FailType type, @JsonKey(includeIfNull: false, name: 'Line')  int? line, @JsonKey(includeIfNull: false, name: 'Column')  int? column)?  $default,) {final _that = this;
switch (_that) {
case _DartFormatException() when $default != null:
return $default(_that.message,_that.type,_that.line,_that.column);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DartFormatException implements DartFormatException {
  const _DartFormatException({@JsonKey(name: 'Message') required this.message, @JsonKey(name: 'Type') required this.type, @JsonKey(includeIfNull: false, name: 'Line') this.line, @JsonKey(includeIfNull: false, name: 'Column') this.column});
  factory _DartFormatException.fromJson(Map<String, dynamic> json) => _$DartFormatExceptionFromJson(json);

/// The message of the exception.
@override@JsonKey(name: 'Message') final  String message;
/// The type of the exception.
@override@JsonKey(name: 'Type') final  FailType type;
/// The line number where the exception occurred.
@override@JsonKey(includeIfNull: false, name: 'Line') final  int? line;
/// The column number where the exception occurred.
@override@JsonKey(includeIfNull: false, name: 'Column') final  int? column;

/// Create a copy of DartFormatException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DartFormatExceptionCopyWith<_DartFormatException> get copyWith => __$DartFormatExceptionCopyWithImpl<_DartFormatException>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DartFormatExceptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DartFormatException&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.line, line) || other.line == line)&&(identical(other.column, column) || other.column == column));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,type,line,column);

@override
String toString() {
  return 'DartFormatException(message: $message, type: $type, line: $line, column: $column)';
}


}

/// @nodoc
abstract mixin class _$DartFormatExceptionCopyWith<$Res> implements $DartFormatExceptionCopyWith<$Res> {
  factory _$DartFormatExceptionCopyWith(_DartFormatException value, $Res Function(_DartFormatException) _then) = __$DartFormatExceptionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Message') String message,@JsonKey(name: 'Type') FailType type,@JsonKey(includeIfNull: false, name: 'Line') int? line,@JsonKey(includeIfNull: false, name: 'Column') int? column
});




}
/// @nodoc
class __$DartFormatExceptionCopyWithImpl<$Res>
    implements _$DartFormatExceptionCopyWith<$Res> {
  __$DartFormatExceptionCopyWithImpl(this._self, this._then);

  final _DartFormatException _self;
  final $Res Function(_DartFormatException) _then;

/// Create a copy of DartFormatException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? type = null,Object? line = freezed,Object? column = freezed,}) {
  return _then(_DartFormatException(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailType,line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,column: freezed == column ? _self.column : column // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
