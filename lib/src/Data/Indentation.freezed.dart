// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Indentation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Indentation {
  String get name;
  IndentationType get type;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IndentationCopyWith<Indentation> get copyWith =>
      _$IndentationCopyWithImpl<Indentation>(this as Indentation, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Indentation &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @override
  String toString() {
    return 'Indentation(name: $name, type: $type)';
  }
}

/// @nodoc
abstract mixin class $IndentationCopyWith<$Res> {
  factory $IndentationCopyWith(
          Indentation value, $Res Function(Indentation) _then) =
      _$IndentationCopyWithImpl;
  @useResult
  $Res call({String name, IndentationType type});
}

/// @nodoc
class _$IndentationCopyWithImpl<$Res> implements $IndentationCopyWith<$Res> {
  _$IndentationCopyWithImpl(this._self, this._then);

  final Indentation _self;
  final $Res Function(Indentation) _then;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndentationType,
    ));
  }
}

/// @nodoc

class _Indentation implements Indentation {
  const _Indentation({required this.name, required this.type});

  @override
  final String name;
  @override
  final IndentationType type;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IndentationCopyWith<_Indentation> get copyWith =>
      __$IndentationCopyWithImpl<_Indentation>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Indentation &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @override
  String toString() {
    return 'Indentation(name: $name, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$IndentationCopyWith<$Res>
    implements $IndentationCopyWith<$Res> {
  factory _$IndentationCopyWith(
          _Indentation value, $Res Function(_Indentation) _then) =
      __$IndentationCopyWithImpl;
  @override
  @useResult
  $Res call({String name, IndentationType type});
}

/// @nodoc
class __$IndentationCopyWithImpl<$Res> implements _$IndentationCopyWith<$Res> {
  __$IndentationCopyWithImpl(this._self, this._then);

  final _Indentation _self;
  final $Res Function(_Indentation) _then;

  /// Create a copy of Indentation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_Indentation(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndentationType,
    ));
  }
}

// dart format on
