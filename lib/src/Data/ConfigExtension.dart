import '../../dart_format.dart';

extension ConfigExtension on Config
{
    int? get space0 => fixSpaces ? 0 : null;
    int? get space1 => fixSpaces ? 1 : null;
}
