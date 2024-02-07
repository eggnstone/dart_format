import 'package:freezed_annotation/freezed_annotation.dart';

part 'Version.freezed.dart';

@freezed
class Version with _$Version
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

    bool isOlderThan(Version? latestVersion)
    {
        if (latestVersion == null)
            return false;

        if (major < latestVersion.major)
            return true;

        if (major > latestVersion.major)
            return false;

        if (minor < latestVersion.minor)
            return true;

        if (minor > latestVersion.minor)
            return false;

        return patch < latestVersion.patch;
    }
}
