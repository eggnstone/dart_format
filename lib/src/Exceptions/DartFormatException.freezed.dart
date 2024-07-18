// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DartFormatException.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DartFormatException _$DartFormatExceptionFromJson(Map<String, dynamic> json) {
  return _DartFormatException.fromJson(json);
}

/// @nodoc
mixin _$DartFormatException {
  /// The message of the exception.
  @JsonKey(name: 'Message')
  String get message => throw _privateConstructorUsedError;

  /// The type of the exception.
  @JsonKey(name: 'Type')
  FailType get type => throw _privateConstructorUsedError;

  /// The line number where the exception occurred.
  @JsonKey(includeIfNull: false, name: 'Line')
  int? get line => throw _privateConstructorUsedError;

  /// The column number where the exception occurred.
  @JsonKey(includeIfNull: false, name: 'Column')
  int? get column => throw _privateConstructorUsedError;

  /// Serializes this DartFormatException to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DartFormatException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DartFormatExceptionCopyWith<DartFormatException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DartFormatExceptionCopyWith<$Res> {
  factory $DartFormatExceptionCopyWith(
          DartFormatException value, $Res Function(DartFormatException) then) =
      _$DartFormatExceptionCopyWithImpl<$Res, DartFormatException>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Message') String message,
      @JsonKey(name: 'Type') FailType type,
      @JsonKey(includeIfNull: false, name: 'Line') int? line,
      @JsonKey(includeIfNull: false, name: 'Column') int? column});
}

/// @nodoc
class _$DartFormatExceptionCopyWithImpl<$Res, $Val extends DartFormatException>
    implements $DartFormatExceptionCopyWith<$Res> {
  _$DartFormatExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DartFormatException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? line = freezed,
    Object? column = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FailType,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      column: freezed == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DartFormatExceptionImplCopyWith<$Res>
    implements $DartFormatExceptionCopyWith<$Res> {
  factory _$$DartFormatExceptionImplCopyWith(_$DartFormatExceptionImpl value,
          $Res Function(_$DartFormatExceptionImpl) then) =
      __$$DartFormatExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Message') String message,
      @JsonKey(name: 'Type') FailType type,
      @JsonKey(includeIfNull: false, name: 'Line') int? line,
      @JsonKey(includeIfNull: false, name: 'Column') int? column});
}

/// @nodoc
class __$$DartFormatExceptionImplCopyWithImpl<$Res>
    extends _$DartFormatExceptionCopyWithImpl<$Res, _$DartFormatExceptionImpl>
    implements _$$DartFormatExceptionImplCopyWith<$Res> {
  __$$DartFormatExceptionImplCopyWithImpl(_$DartFormatExceptionImpl _value,
      $Res Function(_$DartFormatExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DartFormatException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? line = freezed,
    Object? column = freezed,
  }) {
    return _then(_$DartFormatExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FailType,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      column: freezed == column
          ? _value.column
          : column // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DartFormatExceptionImpl implements _DartFormatException {
  const _$DartFormatExceptionImpl(
      {@JsonKey(name: 'Message') required this.message,
      @JsonKey(name: 'Type') required this.type,
      @JsonKey(includeIfNull: false, name: 'Line') this.line,
      @JsonKey(includeIfNull: false, name: 'Column') this.column});

  factory _$DartFormatExceptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DartFormatExceptionImplFromJson(json);

  /// The message of the exception.
  @override
  @JsonKey(name: 'Message')
  final String message;

  /// The type of the exception.
  @override
  @JsonKey(name: 'Type')
  final FailType type;

  /// The line number where the exception occurred.
  @override
  @JsonKey(includeIfNull: false, name: 'Line')
  final int? line;

  /// The column number where the exception occurred.
  @override
  @JsonKey(includeIfNull: false, name: 'Column')
  final int? column;

  @override
  String toString() {
    return 'DartFormatException(message: $message, type: $type, line: $line, column: $column)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartFormatExceptionImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.column, column) || other.column == column));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, type, line, column);

  /// Create a copy of DartFormatException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DartFormatExceptionImplCopyWith<_$DartFormatExceptionImpl> get copyWith =>
      __$$DartFormatExceptionImplCopyWithImpl<_$DartFormatExceptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DartFormatExceptionImplToJson(
      this,
    );
  }
}

abstract class _DartFormatException implements DartFormatException {
  const factory _DartFormatException(
          {@JsonKey(name: 'Message') required final String message,
          @JsonKey(name: 'Type') required final FailType type,
          @JsonKey(includeIfNull: false, name: 'Line') final int? line,
          @JsonKey(includeIfNull: false, name: 'Column') final int? column}) =
      _$DartFormatExceptionImpl;

  factory _DartFormatException.fromJson(Map<String, dynamic> json) =
      _$DartFormatExceptionImpl.fromJson;

  /// The message of the exception.
  @override
  @JsonKey(name: 'Message')
  String get message;

  /// The type of the exception.
  @override
  @JsonKey(name: 'Type')
  FailType get type;

  /// The line number where the exception occurred.
  @override
  @JsonKey(includeIfNull: false, name: 'Line')
  int? get line;

  /// The column number where the exception occurred.
  @override
  @JsonKey(includeIfNull: false, name: 'Column')
  int? get column;

  /// Create a copy of DartFormatException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DartFormatExceptionImplCopyWith<_$DartFormatExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
