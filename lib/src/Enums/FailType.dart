import 'package:freezed_annotation/freezed_annotation.dart';

/// Severity of a `DartFormatException`. Serialised over the web service as the
/// JSON values `"Error"` and `"Warning"`.
enum FailType
{
    @JsonValue('Error') error,
    @JsonValue('Warning') warning
}

/// Adds the human-readable [displayName] used in error output and HTTP
/// responses. Kept as an extension because `name` would silently shadow the
/// built-in enum `.name`.
extension FailTypeExtension on FailType
{
    /// Capitalised label used in CLI / HTTP messages (`"Error"` / `"Warning"`).
    String get displayName
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
