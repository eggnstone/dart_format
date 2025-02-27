// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'JsonResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JsonResponse {
  @JsonKey(name: 'StatusCode')
  int get statusCode;
  @JsonKey(name: 'Status')
  String get status;
  @JsonKey(includeIfNull: false, name: 'CurrentVersion')
  String? get currentVersion;
  @JsonKey(includeIfNull: false, name: 'LatestVersion')
  String? get latestVersion;
  @JsonKey(includeIfNull: false, name: 'Message')
  String? get message;

  /// Create a copy of JsonResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JsonResponseCopyWith<JsonResponse> get copyWith =>
      _$JsonResponseCopyWithImpl<JsonResponse>(
          this as JsonResponse, _$identity);

  /// Serializes this JsonResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JsonResponse &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentVersion, currentVersion) ||
                other.currentVersion == currentVersion) &&
            (identical(other.latestVersion, latestVersion) ||
                other.latestVersion == latestVersion) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, statusCode, status, currentVersion, latestVersion, message);

  @override
  String toString() {
    return 'JsonResponse(statusCode: $statusCode, status: $status, currentVersion: $currentVersion, latestVersion: $latestVersion, message: $message)';
  }
}

/// @nodoc
abstract mixin class $JsonResponseCopyWith<$Res> {
  factory $JsonResponseCopyWith(
          JsonResponse value, $Res Function(JsonResponse) _then) =
      _$JsonResponseCopyWithImpl;
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
class _$JsonResponseCopyWithImpl<$Res> implements $JsonResponseCopyWith<$Res> {
  _$JsonResponseCopyWithImpl(this._self, this._then);

  final JsonResponse _self;
  final $Res Function(JsonResponse) _then;

  /// Create a copy of JsonResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? status = null,
    Object? currentVersion = freezed,
    Object? latestVersion = freezed,
    Object? message = freezed,
  }) {
    return _then(_self.copyWith(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentVersion: freezed == currentVersion
          ? _self.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVersion: freezed == latestVersion
          ? _self.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _JsonResponse implements JsonResponse {
  const _JsonResponse(
      {@JsonKey(name: 'StatusCode') required this.statusCode,
      @JsonKey(name: 'Status') required this.status,
      @JsonKey(includeIfNull: false, name: 'CurrentVersion')
      this.currentVersion,
      @JsonKey(includeIfNull: false, name: 'LatestVersion') this.latestVersion,
      @JsonKey(includeIfNull: false, name: 'Message') this.message});
  factory _JsonResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonResponseFromJson(json);

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

  /// Create a copy of JsonResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JsonResponseCopyWith<_JsonResponse> get copyWith =>
      __$JsonResponseCopyWithImpl<_JsonResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JsonResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JsonResponse &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentVersion, currentVersion) ||
                other.currentVersion == currentVersion) &&
            (identical(other.latestVersion, latestVersion) ||
                other.latestVersion == latestVersion) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, statusCode, status, currentVersion, latestVersion, message);

  @override
  String toString() {
    return 'JsonResponse(statusCode: $statusCode, status: $status, currentVersion: $currentVersion, latestVersion: $latestVersion, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$JsonResponseCopyWith<$Res>
    implements $JsonResponseCopyWith<$Res> {
  factory _$JsonResponseCopyWith(
          _JsonResponse value, $Res Function(_JsonResponse) _then) =
      __$JsonResponseCopyWithImpl;
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
class __$JsonResponseCopyWithImpl<$Res>
    implements _$JsonResponseCopyWith<$Res> {
  __$JsonResponseCopyWithImpl(this._self, this._then);

  final _JsonResponse _self;
  final $Res Function(_JsonResponse) _then;

  /// Create a copy of JsonResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? statusCode = null,
    Object? status = null,
    Object? currentVersion = freezed,
    Object? latestVersion = freezed,
    Object? message = freezed,
  }) {
    return _then(_JsonResponse(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentVersion: freezed == currentVersion
          ? _self.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVersion: freezed == latestVersion
          ? _self.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
