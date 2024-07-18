// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Indentation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Indentation {
  String get name => throw _privateConstructorUsedError;
  IndentationType get type => throw _privateConstructorUsedError;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IndentationCopyWith<Indentation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndentationCopyWith<$Res> {
  factory $IndentationCopyWith(
          Indentation value, $Res Function(Indentation) then) =
      _$IndentationCopyWithImpl<$Res, Indentation>;
  @useResult
  $Res call({String name, IndentationType type});
}

/// @nodoc
class _$IndentationCopyWithImpl<$Res, $Val extends Indentation>
    implements $IndentationCopyWith<$Res> {
  _$IndentationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndentationType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndentationImplCopyWith<$Res>
    implements $IndentationCopyWith<$Res> {
  factory _$$IndentationImplCopyWith(
          _$IndentationImpl value, $Res Function(_$IndentationImpl) then) =
      __$$IndentationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, IndentationType type});
}

/// @nodoc
class __$$IndentationImplCopyWithImpl<$Res>
    extends _$IndentationCopyWithImpl<$Res, _$IndentationImpl>
    implements _$$IndentationImplCopyWith<$Res> {
  __$$IndentationImplCopyWithImpl(
      _$IndentationImpl _value, $Res Function(_$IndentationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$IndentationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndentationType,
    ));
  }
}

/// @nodoc

class _$IndentationImpl implements _Indentation {
  const _$IndentationImpl({required this.name, required this.type});

  @override
  final String name;
  @override
  final IndentationType type;

  @override
  String toString() {
    return 'Indentation(name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndentationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndentationImplCopyWith<_$IndentationImpl> get copyWith =>
      __$$IndentationImplCopyWithImpl<_$IndentationImpl>(this, _$identity);
}

abstract class _Indentation implements Indentation {
  const factory _Indentation(
      {required final String name,
      required final IndentationType type}) = _$IndentationImpl;

  @override
  String get name;
  @override
  IndentationType get type;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndentationImplCopyWith<_$IndentationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
