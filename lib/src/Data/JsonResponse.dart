// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'JsonResponse.freezed.dart';
part 'JsonResponse.g.dart';

@freezed
abstract class JsonResponse with _$JsonResponse implements Exception
{
    const factory JsonResponse({
        @JsonKey(name: 'StatusCode') required int statusCode,
        @JsonKey(name: 'Status') required String status,
        @JsonKey(includeIfNull: false, name: 'CurrentVersion') String? currentVersion,
        @JsonKey(includeIfNull: false, name: 'LatestVersion') String? latestVersion,
        @JsonKey(includeIfNull: false, name: 'Message') String? message
    }) = _JsonResponse;

    factory JsonResponse.fromJson(Map<String, dynamic> json)
    => _$JsonResponseFromJson(json);
}
