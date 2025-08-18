// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 String? get errorMessage; bool get hasError; bool get isComment; bool get isEmpty;
/// Create a copy of CommentInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentInfoCopyWith<CommentInfo> get copyWith => _$CommentInfoCopyWithImpl<CommentInfo>(this as CommentInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentInfo&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isComment, isComment) || other.isComment == isComment)&&(identical(other.isEmpty, isEmpty) || other.isEmpty == isEmpty));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,hasError,isComment,isEmpty);

@override
String toString() {
  return 'CommentInfo(errorMessage: $errorMessage, hasError: $hasError, isComment: $isComment, isEmpty: $isEmpty)';
}


}

/// @nodoc
abstract mixin class $CommentInfoCopyWith<$Res>  {
  factory $CommentInfoCopyWith(CommentInfo value, $Res Function(CommentInfo) _then) = _$CommentInfoCopyWithImpl;
@useResult
$Res call({
 String? errorMessage, bool hasError, bool isComment, bool isEmpty
});




}
/// @nodoc
class _$CommentInfoCopyWithImpl<$Res>
    implements $CommentInfoCopyWith<$Res> {
  _$CommentInfoCopyWithImpl(this._self, this._then);

  final CommentInfo _self;
  final $Res Function(CommentInfo) _then;

/// Create a copy of CommentInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorMessage = freezed,Object? hasError = null,Object? isComment = null,Object? isEmpty = null,}) {
  return _then(_self.copyWith(
errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isComment: null == isComment ? _self.isComment : isComment // ignore: cast_nullable_to_non_nullable
as bool,isEmpty: null == isEmpty ? _self.isEmpty : isEmpty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentInfo].
extension CommentInfoPatterns on CommentInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentInfo value)  $default,){
final _that = this;
switch (_that) {
case _CommentInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CommentInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? errorMessage,  bool hasError,  bool isComment,  bool isEmpty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentInfo() when $default != null:
return $default(_that.errorMessage,_that.hasError,_that.isComment,_that.isEmpty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? errorMessage,  bool hasError,  bool isComment,  bool isEmpty)  $default,) {final _that = this;
switch (_that) {
case _CommentInfo():
return $default(_that.errorMessage,_that.hasError,_that.isComment,_that.isEmpty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? errorMessage,  bool hasError,  bool isComment,  bool isEmpty)?  $default,) {final _that = this;
switch (_that) {
case _CommentInfo() when $default != null:
return $default(_that.errorMessage,_that.hasError,_that.isComment,_that.isEmpty);case _:
  return null;

}
}

}

/// @nodoc


class _CommentInfo extends CommentInfo {
  const _CommentInfo({this.errorMessage, this.hasError = false, this.isComment = false, this.isEmpty = false}): super._();
  

@override final  String? errorMessage;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  bool isComment;
@override@JsonKey() final  bool isEmpty;

/// Create a copy of CommentInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentInfoCopyWith<_CommentInfo> get copyWith => __$CommentInfoCopyWithImpl<_CommentInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentInfo&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isComment, isComment) || other.isComment == isComment)&&(identical(other.isEmpty, isEmpty) || other.isEmpty == isEmpty));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,hasError,isComment,isEmpty);

@override
String toString() {
  return 'CommentInfo(errorMessage: $errorMessage, hasError: $hasError, isComment: $isComment, isEmpty: $isEmpty)';
}


}

/// @nodoc
abstract mixin class _$CommentInfoCopyWith<$Res> implements $CommentInfoCopyWith<$Res> {
  factory _$CommentInfoCopyWith(_CommentInfo value, $Res Function(_CommentInfo) _then) = __$CommentInfoCopyWithImpl;
@override @useResult
$Res call({
 String? errorMessage, bool hasError, bool isComment, bool isEmpty
});




}
/// @nodoc
class __$CommentInfoCopyWithImpl<$Res>
    implements _$CommentInfoCopyWith<$Res> {
  __$CommentInfoCopyWithImpl(this._self, this._then);

  final _CommentInfo _self;
  final $Res Function(_CommentInfo) _then;

/// Create a copy of CommentInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = freezed,Object? hasError = null,Object? isComment = null,Object? isEmpty = null,}) {
  return _then(_CommentInfo(
errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isComment: null == isComment ? _self.isComment : isComment // ignore: cast_nullable_to_non_nullable
as bool,isEmpty: null == isEmpty ? _self.isEmpty : isEmpty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
