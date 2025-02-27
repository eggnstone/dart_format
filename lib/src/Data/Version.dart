import 'package:freezed_annotation/freezed_annotation.dart';

part 'Version.freezed.dart';

@freezed
abstract class Version with _$Version
{
    // necessary when you want to create additional methods
    const Version._();

    const factory Version(
        int major,
        int minor,
        int patch
    ) = _Version;

    factory Version.parse(String version)
    {
        final List<String> parts = version.split('.');
        final int major = int.parse(parts[0]);
        final int minor = int.parse(parts[1]);
        final int patch = int.parse(parts[2]);

        return Version(major, minor, patch);
    }

    @override
    String toString() => '$major.$minor.$patch';

    bool isOlderThan(Version? otherVersion)
    {
        if (otherVersion == null)
            return false;

        if (major < otherVersion.major)
            return true;

        if (major > otherVersion.major)
            return false;

        if (minor < otherVersion.minor)
            return true;

        if (minor > otherVersion.minor)
            return false;

        return patch < otherVersion.patch;
    }
}
