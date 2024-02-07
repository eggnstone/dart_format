// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'JsonResponse.freezed.dart';
part 'JsonResponse.g.dart';

@freezed
class JsonResponse with _$JsonResponse implements Exception
{
    const factory JsonResponse({
        @JsonKey(name: 'StatusCode') required int statusCode,
        @JsonKey(name: 'Status') required String status,
        @JsonKey(includeIfNull: false, name: 'Message') String? message,
        @JsonKey(includeIfNull: false, name: 'Version') String? version
    }) = _JsonResponse;

    factory JsonResponse.fromJson(Map<String, dynamic> json)
    => _$JsonResponseFromJson(json);
}
