$versionRegex = "version: (\d+)\.(\d+).(\d+)"
$pubspecFileName = "pubspec.yaml"
$versionDartFileName = "lib/src/Constants/Generated/VersionConstants.dart"

$pubspecFileContent = (Get-Content -Path $pubspecFileName)
$select = $pubspecFileContent | Select-String -Pattern $versionRegex
$dummy = $select[0] -match $versionRegex
$major = $matches[1]
$minor = $matches[2]
$patch = $matches[3]

$oldVersionDartFileContent = (Get-Content -Path $versionDartFileName)
$newVersionDartFileContent = $oldVersionDartFileContent `
    -replace "MAJOR = \d+;", "MAJOR = $major;" `
    -replace "MINOR = \d+;", "MINOR = $minor;" `
    -replace "PATCH = \d+;", "PATCH = $patch;"

Set-Content -Path $versionDartFileName -Value $newVersionDartFileContent

dart pub publish
