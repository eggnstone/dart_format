import 'package:freezed_annotation/freezed_annotation.dart';

enum FailType
{
    @JsonValue('Error') error,
    @JsonValue('Warning') warning
}

extension FailTypeExtension on FailType
{
    String get name
    {
        switch (this)
        {
            case FailType.error:
                return 'Error';
            case FailType.warning:
                return 'Warning';
        }
    }
}
