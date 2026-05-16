import 'package:freezed_annotation/freezed_annotation.dart';

part 'JsonResponse.freezed.dart';
part 'JsonResponse.g.dart';

/// Shape of the JSON line dart_format writes to stdout on startup.
///
/// Plugins should prefer the structured fields (`Protocol` + `Address` + `Port`,
/// `LogFilePath` + `LogFileName`, `ProcessId`) over parsing `Message`. `Message`
/// is kept for back-compat with older plugin builds and will be removed in a
/// future release.
@freezed
abstract class JsonResponse with _$JsonResponse implements Exception
{
    const factory JsonResponse({
        @JsonKey(name: 'StatusCode') required int statusCode,
        @JsonKey(name: 'Status') required String status,
        @JsonKey(includeIfNull: false, name: 'CurrentVersion') String? currentVersion,
        @JsonKey(includeIfNull: false, name: 'LatestVersion') String? latestVersion,
        @JsonKey(includeIfNull: false, name: 'Protocol') String? protocol,
        @JsonKey(includeIfNull: false, name: 'Address') String? address,
        @JsonKey(includeIfNull: false, name: 'Port') int? port,
        @JsonKey(includeIfNull: false, name: 'ProcessId') int? processId,
        @JsonKey(includeIfNull: false, name: 'LogFilePath') String? logFilePath,
        @JsonKey(includeIfNull: false, name: 'LogFileName') String? logFileName,
        @JsonKey(includeIfNull: false, name: 'Message') String? message
    }) = _JsonResponse;

    factory JsonResponse.fromJson(Map<String, dynamic> json)
    => _$JsonResponseFromJson(json);
}
