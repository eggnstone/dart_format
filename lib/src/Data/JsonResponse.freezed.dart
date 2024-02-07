// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'JsonResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JsonResponse _$JsonResponseFromJson(Map<String, dynamic> json) {
  return _JsonResponse.fromJson(json);
}

/// @nodoc
mixin _$JsonResponse {
  @JsonKey(name: 'StatusCode')
  int get statusCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false, name: 'CurrentVersion')
  String? get currentVersion => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false, name: 'LatestVersion')
  String? get latestVersion => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false, name: 'Message')
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonResponseCopyWith<JsonResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonResponseCopyWith<$Res> {
  factory $JsonResponseCopyWith(
          JsonResponse value, $Res Function(JsonResponse) then) =
      _$JsonResponseCopyWithImpl<$Res, JsonResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'StatusCode') int statusCode,
      @JsonKey(name: 'Status') String status,
      @JsonKey(includeIfNull: false, name: 'CurrentVersion')
      String? currentVersion,
      @JsonKey(includeIfNull: false, name: 'LatestVersion')
      String? latestVersion,
      @JsonKey(includeIfNull: false, name: 'Message') String? message});
}

/// @nodoc
class _$JsonResponseCopyWithImpl<$Res, $Val extends JsonResponse>
    implements $JsonResponseCopyWith<$Res> {
  _$JsonResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? status = null,
    Object? currentVersion = freezed,
    Object? latestVersion = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentVersion: freezed == currentVersion
          ? _value.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVersion: freezed == latestVersion
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JsonResponseImplCopyWith<$Res>
    implements $JsonResponseCopyWith<$Res> {
  factory _$$JsonResponseImplCopyWith(
          _$JsonResponseImpl value, $Res Function(_$JsonResponseImpl) then) =
      __$$JsonResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'StatusCode') int statusCode,
      @JsonKey(name: 'Status') String status,
      @JsonKey(includeIfNull: false, name: 'CurrentVersion')
      String? currentVersion,
      @JsonKey(includeIfNull: false, name: 'LatestVersion')
      String? latestVersion,
      @JsonKey(includeIfNull: false, name: 'Message') String? message});
}

/// @nodoc
class __$$JsonResponseImplCopyWithImpl<$Res>
    extends _$JsonResponseCopyWithImpl<$Res, _$JsonResponseImpl>
    implements _$$JsonResponseImplCopyWith<$Res> {
  __$$JsonResponseImplCopyWithImpl(
      _$JsonResponseImpl _value, $Res Function(_$JsonResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? status = null,
    Object? currentVersion = freezed,
    Object? latestVersion = freezed,
    Object? message = freezed,
  }) {
    return _then(_$JsonResponseImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentVersion: freezed == currentVersion
          ? _value.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVersion: freezed == latestVersion
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JsonResponseImpl implements _JsonResponse {
  const _$JsonResponseImpl(
      {@JsonKey(name: 'StatusCode') required this.statusCode,
      @JsonKey(name: 'Status') required this.status,
      @JsonKey(includeIfNull: false, name: 'CurrentVersion')
      this.currentVersion,
      @JsonKey(includeIfNull: false, name: 'LatestVersion') this.latestVersion,
      @JsonKey(includeIfNull: false, name: 'Message') this.message});

  factory _$JsonResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$JsonResponseImplFromJson(json);

  @override
  @JsonKey(name: 'StatusCode')
  final int statusCode;
  @override
  @JsonKey(name: 'Status')
  final String status;
  @override
  @JsonKey(includeIfNull: false, name: 'CurrentVersion')
  final String? currentVersion;
  @override
  @JsonKey(includeIfNull: false, name: 'LatestVersion')
  final String? latestVersion;
  @override
  @JsonKey(includeIfNull: false, name: 'Message')
  final String? message;

  @override
  String toString() {
    return 'JsonResponse(statusCode: $statusCode, status: $status, currentVersion: $currentVersion, latestVersion: $latestVersion, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonResponseImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentVersion, currentVersion) ||
                other.currentVersion == currentVersion) &&
            (identical(other.latestVersion, latestVersion) ||
                other.latestVersion == latestVersion) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, statusCode, status, currentVersion, latestVersion, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonResponseImplCopyWith<_$JsonResponseImpl> get copyWith =>
      __$$JsonResponseImplCopyWithImpl<_$JsonResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JsonResponseImplToJson(
      this,
    );
  }
}

abstract class _JsonResponse implements JsonResponse {
  const factory _JsonResponse(
      {@JsonKey(name: 'StatusCode') required final int statusCode,
      @JsonKey(name: 'Status') required final String status,
      @JsonKey(includeIfNull: false, name: 'CurrentVersion')
      final String? currentVersion,
      @JsonKey(includeIfNull: false, name: 'LatestVersion')
      final String? latestVersion,
      @JsonKey(includeIfNull: false, name: 'Message')
      final String? message}) = _$JsonResponseImpl;

  factory _JsonResponse.fromJson(Map<String, dynamic> json) =
      _$JsonResponseImpl.fromJson;

  @override
  @JsonKey(name: 'StatusCode')
  int get statusCode;
  @override
  @JsonKey(name: 'Status')
  String get status;
  @override
  @JsonKey(includeIfNull: false, name: 'CurrentVersion')
  String? get currentVersion;
  @override
  @JsonKey(includeIfNull: false, name: 'LatestVersion')
  String? get latestVersion;
  @override
  @JsonKey(includeIfNull: false, name: 'Message')
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$JsonResponseImplCopyWith<_$JsonResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
